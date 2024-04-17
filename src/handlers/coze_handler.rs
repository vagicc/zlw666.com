use std::fmt::format;

use crate::models::coze_batch_batchtitle_m;
use crate::reptile;
use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};

pub async fn test_rand_image() -> Result<impl Reply, Rejection> {
    let (one, two) = rand_img();

    let new = format!(
        "<img src=\"{}\" alt=\"A beautiful red rose\" title=\"A beautiful red rose\">
        <br><hr>
        <img src=\"{}\" alt=\"A beautiful red rose\" title=\"A beautiful red rose\">",
        one, two
    );

    let html = "随机取一个文件夹里的图片";
    Ok(warp::reply::html(new)) //直接返回html
}

pub async fn backstage() -> Result<impl Reply, Rejection> {
    let (_, list, _) = coze_batch_batchtitle_m::no_done_list(None, None);

    if list.is_empty() {
        log::warn!("没有未生成的关键字");
    }

    for coze_data in list.iter() {
        // 请求接口，生成文章，再更改数据保存文章
        let say = format!("生成“{}”文章", coze_data.title);
        let mut new_article: Option<(String, String)> = None;
        new_article = coze_ai_write_article(say.clone()).await;
        let (title, content) = new_article.unwrap();
        let now_date_time = crate::common::now_naive_date_time();
        let description = format!(
            "扣子（coze.com）AI作者根据关键词《{}》写的文章",
            coze_data.title
        );
        log::debug!("{:?}", description);
        let new_data = coze_batch_batchtitle_m::NewCozeBatchBatchtitle {
            title: title.clone(),
            content: Some(content.clone()),
            is_done: Some(true),
            created_at: coze_data.created_at,
            generated_at: Some(now_date_time),
            description: Some(description),
            is_published: Some(false),
        };
        coze_batch_batchtitle_m::modify(coze_data.id, &new_data);
    }

    let html = "后台把关键都发送去生成文章";
    Ok(warp::reply::html(html)) //直接返回html
}

pub async fn title(title: String) -> Result<impl Reply, Rejection> {
    log::info!("要生成的文章标题：{}", title);
    //解码URL的中文
    let title: String = url::form_urlencoded::parse(title.as_bytes())
        .map(|(key, _)| key.into_owned())
        .collect();
    log::info!("解码的文章标题：{}", title);

    /*
    流程：
        先检查文章标题是否有，是否已生成过
        请求Coze生成文章
        插入文章
        是否处理相似的文章标题
    */

    let created_time = crate::common::now_naive_date_time();
    let say = format!("生成“{}”文章", title);
    // let say = "生成“强奸罪”文章".to_string();

    let mut new_article: Option<(String, String)> = None;
    let is_article = coze_batch_batchtitle_m::find_title(say.clone());
    match is_article {
        Some(old_article) => {
            let is_done = old_article.is_done;
        }
        None => {
            log::info!("准备生成标题为“{}”的文章", say);
            new_article = coze_ai_write_article(say.clone()).await;
        }
    }

    let (title, content) = new_article.unwrap();
    let now_date_time = crate::common::now_naive_date_time();

    let new_data = coze_batch_batchtitle_m::NewCozeBatchBatchtitle {
        title: title.clone(),
        content: Some(content.clone()),
        is_done: Some(true),
        created_at: created_time,
        generated_at: Some(now_date_time),
        description: None,
        is_published: Some(false),
    };

    let insert_id = new_data.insert();
    log::warn!("Insert ID: {}", insert_id);

    // let mut data = Map::new();
    // let html = to_html_base("home.html", data);
    let html = format!(
        "这里是请求<扣子：www.coze.com >
    <br><Hr>
    标题：{}
    <br><Hr>
    {}
    ",
        title, content
    );
    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}

fn get_coze_config() -> reptile::CozeConfig {
    use crate::common::get_env;
    let api_key = get_env("coze_api_key");
    let bot_id = get_env("coze_bot_id");
    reptile::CozeConfig {
        api_url: "https://api.coze.com/open_api/v2/chat".to_string(),
        api_key: api_key,
        conversation_id: "123".to_string(), //标识对话发生在哪一次会话中,示例中默认为123
        bot_id: bot_id,                     //机器模型的ID：7356134116951867400
        stream: false,
    }
}

async fn coze_ai_write_article(say: String) -> Option<(String, String)> {
    //这个配置文件还要分割出去
    let coze_config = get_coze_config();

    let response = reptile::coze(say, "123".to_string(), &coze_config).await;
    // println!("{:#?}", response);
    let messages = response.messages.first().expect("返回来消息体不对");
    let mut title_and_content: Vec<&str> = messages.content.split("📚").collect();
    log::warn!("原始消息体{:#?}", title_and_content);

    if title_and_content.len() != 2 {
        log::error!("处理文章出错。原始分割符📚变成了n📘");
        title_and_content = messages.content.split("📘").collect();
        if title_and_content.len() != 2 {
            log::error!("原始分割符📚和📘都不对真是的,那就是AI没有去生成，而是反问了");
        }
    }
    //去除标题前后的空格
    let title_temp = title_and_content[0]
        .replace("\n\n", "")
        .replace(":", "")
        .replace("：", "");

    let mut original_title = String::new();
    let title_option = title_temp.strip_prefix("📝 标题");

    match title_option {
        Some(o_title) => {
            // let k = title_option.expect("处理文章标题时出错");
            original_title = o_title.replace(":", "").replace("：", "").to_string();
        }
        None => {
            // 处理返回AI多余的话
            let mut title_array: Vec<String> = title_and_content[0]
                .split("📝")
                .map(|k| k.to_string())
                .collect();
            let title_temp = title_array.pop().expect("最出最后数组为空，没有文章标题!");
            let title_prefix = title_temp
                .replace("\n\n", "")
                .replace(":", "")
                .replace("：", "");

            original_title = format!("{:?}", title_prefix.trim().strip_prefix("标题"));
        }
    }

    let title = original_title
        .trim_start() //去掉前面空格
        .trim_end()
        .trim_matches('\"'); //去掉前后的"

    let mut content_option = title_and_content[1].trim_start().strip_prefix("内容:");
    if content_option.is_none() {
        content_option = title_and_content[1].trim_start().strip_prefix("内容：");
    }
    let content = content_option.expect("处理文章见容出错1").trim();

    // let content = title_and_content[1]
    //     .trim_start()
    //     .strip_prefix("内容:")
    //     .expect("处理文章见容出错1")
    //     .trim();

    log::info!("处理后的标题： {:#?}", title);
    log::info!("未处理的文章内容{:#?}", content);

    let temp: Vec<&str> = content.split("\n\n").collect();

    // 处理在文章头部与尾部添加固定的随机图片
    let (one, two) = rand_img();
    let front_img = format!("<img src=\"{}\" alt=\"{}\" title=\"{1}\">", one, title);
    let mut back_img = "".to_string();
    if one != two {
        back_img = format!("<img src=\"{}\" alt=\"{}\" title=\"{1}\">", two, title);
    }

    let html_content = format!(
        "
        <p>{}</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;{}</p>
        <p>{}</p>
        ",
        front_img,
        temp.join("</p><p>&nbsp;&nbsp;&nbsp;&nbsp;"),
        back_img
    );
    log::info!("处理后的内容内容：{}", html_content);

    Some((title.to_string(), html_content))
}

//返回两张随机图片
fn rand_img() -> (String, String) {
    use crate::common::get_env;
    let absolute_path = get_env("path");
    let relative_path = "uploads/allimg"; //相对路径：relative path
                                          // let absolute_path = "/home/luck/Code/PHP/59fayiweb"; //网站根路径
    let url = format!("https:{}", get_env("BASE_URL"));
    // let url = "https://59fayi.up";
    //                       /home/luck/Code/PHP/59fayiweb/public/uploads/allimg/4917.jpg
    let p = format!("{}/public/{}", absolute_path, relative_path);
    //$directory = '/www/wwwroot/59fayiweb/public/uploads/allimg/*';
    let dir = std::path::Path::new(&p); //图片路径

    // 获取文件夹下所有的文件
    // let files: Vec<_> = std::fs::read_dir(dir)
    //     .unwrap()
    //     .map(|res| res.unwrap().path())
    //     .collect();
    let files: Vec<_> = std::fs::read_dir(dir)
        .unwrap()
        .filter_map(|entry| {
            let entry = entry.unwrap();
            let path = entry.path();
            if path.is_file()
                && path
                    .extension()
                    .and_then(|s| s.to_str())
                    .map_or(false, |ext| {
                        ext.eq_ignore_ascii_case("jpg")
                            || ext.eq_ignore_ascii_case("png")
                            || ext.eq_ignore_ascii_case("jpeg")
                    })
            {
                Some(path)
            } else {
                None
            }
        })
        .collect();

    // 使用随机数生成器选择一个文件
    use rand::seq::SliceRandom;
    let mut rng = rand::thread_rng();
    // let mut two = rand::thread_rng();

    let selected_file = files
        .choose(&mut rng)
        .expect("取随机图片出错1")
        .to_str()
        .unwrap();
    let selected_two = files
        .choose(&mut rng)
        .expect("取随机图片出错2")
        .to_str()
        .unwrap();
    // let file_name = format!("随机的图片：{:?}", selected_file);
    let repath = format!("{}/public/", absolute_path);
    let rand_img = selected_file.replace(&repath, &url);
    let two_img = selected_two.replace(&repath, &url);

    (rand_img, two_img)
}
