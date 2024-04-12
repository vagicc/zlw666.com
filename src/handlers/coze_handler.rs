use crate::reptile;
use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};

pub async fn title(title: String) -> Result<impl Reply, Rejection> {
    log::info!("要生成的文章标题：{}", title);

    // let mut data = Map::new();
    // let html = to_html_base("home.html", data);
    let html = "这里是请求<扣子：www.coze.com >";

    println!("开始执行请求");
    let say = "生成“深圳盗窃罪一万元判几年”文章".to_string();

    let coze_config = reptile::CozeConfig {
        api_url: "https://api.coze.com/open_api/v2/chat".to_string(),
        api_key: "pat_1ACJqMzr4mMFGNJ5Mdlq5smyggnnSgp5x8LCqaYq4NbGCvHnO0ABrsMXZa3UQatY".to_string(),
        conversation_id: "123".to_string(), //示例中默认为123
        bot_id: "7356134116951867400".to_string(), //机器模型的ID：7356134116951867400
        stream: false,
    };

    reptile::coze(say, "123".to_string(), &coze_config).await;
    println!("请求生成文章结束&&&****");

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}
