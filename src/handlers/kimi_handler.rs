use crate::reptile;
use crate::{json_value::kimi_response_json::Message, models::qa_answers_m};
use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};

pub async fn test(chat: String) -> Result<impl Reply, Rejection> {
    log::info!("要生成的文章标题：{}", chat);
    //解码URL的中文
    let chat: String = url::form_urlencoded::parse(chat.as_bytes())
        .map(|(key, _)| key.into_owned())
        .collect();
    log::info!("解码的文章标题：{}", chat);

    let config = crate::reptile::KimiConfig {
        // api_url: "https://api.moonshot.cn/v1/chat/completions".to_string(),
        api_url: crate::get_env("kimi_api_url"),
        api_key: crate::get_env("kimi_api_key"),
        stream: false, //是否启用流式返回
    };

    let data = crate::reptile::kimi(chat.clone(), &config).await;
    log::warn!("AI回来：{:#?}", data);
    if let Some(ref choices) = data.choices {
        //AI有回复
        log::warn!("AI有回复");
        let mesage = &choices.first().expect("AI没有返回正确的消息").message;
        let new_data = qa_answers_m::NewQAAnswers {
            question_id: 1,
            content: mesage.content.clone(),
            user_id: 0,
            user_name: Some("宋律师助理".to_string()),
            is_accepted: None,
            created_at: None,
            updated_at: None,
        };
        let insert_id = new_data.insert();
        log::warn!("Insert:{}", insert_id);
    }

    let html = format!(
        "这里是请求<kimi AI>
    <br><Hr>
    标题：{}
    <br><Hr>
    AI回答：{:#?}
    
    ",
        chat, data
    );
    Ok(warp::reply::html(html)) //直接返回html
}
