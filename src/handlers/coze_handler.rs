use crate::models::coze_batch_batchtitle_m;
use crate::reptile;
use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};

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
        title: title,
        content: Some(content),
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
    let html = "这里是请求<扣子：www.coze.com >";
    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}

async fn coze_ai_write_article(say: String) -> Option<(String, String)> {
    //这个配置文件还要分割出去
    let coze_config = reptile::CozeConfig {
        api_url: "https://api.coze.com/open_api/v2/chat".to_string(),
        api_key: "pat_1ACJqMzr4mMFGNJ5Mdlq5smyggnnSgp5x8LCqaYq4NbGCvHnO0ABrsMXZa3UQatY".to_string(),
        conversation_id: "123".to_string(), //示例中默认为123
        bot_id: "7356134116951867400".to_string(), //机器模型的ID：7356134116951867400
        stream: false,
    };

    let response = reptile::coze(say, "123".to_string(), &coze_config).await;
    // println!("{:#?}", response);
    let messages = response.messages.first().expect("返回来消息体不对");
    let mut title_and_content: Vec<&str> = messages.content.split("📚").collect();
    log::warn!("原始消息体{:#?}", title_and_content);

    if title_and_content.len() != 2 {
        log::error!("处理文章出错。原始分割符📚变成了n📘");
        title_and_content = messages.content.split("📘").collect();
        if title_and_content.len() != 2 {
            log::error!("原始分割符📚和📘都不对真是的");
        }
    }
    //去除标题前后的空格
    let mut title_option = title_and_content[0].strip_prefix("📝 标题:");
    if title_option.is_none() {
        title_option = title_and_content[0].strip_prefix("📝标题");
        if title_option.is_none() {
            title_option = title_and_content[0].strip_prefix("📝 标题：");
        }
    }
    let title = title_option
        .expect("处理文章标题时出错")
        .trim_start() //去掉前面空格
        .trim_end();

    // let title = title_and_content[0]
    //     .strip_prefix("📝 标题:")
    //     .expect("处理文章标题时出错")
    //     .trim_start() //去掉前面空格
    //     .trim_end();

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
    let html_content = format!("<p>{}</p>", temp.join("</p><p>"));
    log::info!("处理后的内容内容：{}", html_content);

    Some((title.to_string(), html_content))
}
