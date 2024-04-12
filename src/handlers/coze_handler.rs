use crate::reptile;
use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};

pub async fn title(title: String) -> Result<impl Reply, Rejection> {
    let k=title.encode_utf16();
    log::info!("要生成的文章标题：{}", title);

    // let mut data = Map::new();
    // let html = to_html_base("home.html", data);
    let html = "这里是请求<扣子：www.coze.com >";

    println!("开始执行请求");
    let say = "生成“强奸罪”文章".to_string();

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
    let title_and_content: Vec<&str> = messages.content.split("📚").collect();
    println!("{:#?}", title_and_content);

    if title_and_content.len() != 2 {
        println!("生成文章出错。。%");
    }
    //去除标题前后的空格
    let title = title_and_content[0]
        .strip_prefix("📝 标题:")
        .expect("处理文章标题时出错")
        .trim_start() //去掉前面空格
        .trim_end();
    let content = title_and_content[1]
        .trim_start()
        .strip_prefix("内容:\n\n")
        .expect("处理文章见容出错1")
        .trim();

    println!("标题： {:#?}", title);
    println!("内容：");
    println!("{:#?}", content);
    let k: Vec<&str> = content.split("\n\n").collect();

    let string = format!("<p>{}</p>", k.join("</p><p>"));
    println!("---------------------------------");
    println!("拼接后的内容内容：{}", string);
    // let t=title.

    println!("请求生成文章结束&&&****");

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}
