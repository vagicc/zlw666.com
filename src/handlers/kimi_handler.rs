use crate::reptile;
use crate::{json_value::kimi_response_json::Message, models::qa_answers_m};
use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};

//响应GET：/kimi/answers/{question_id}
//取表qa_questions问题标题，插入答案表qa_answers
pub async fn answers(question_id: i32) -> Result<impl Reply, Rejection> {
    log::info!("kimi回答法律提问:{}", question_id);

    use crate::models::qa_answers_m;
    use crate::models::qa_questions_m;

    let questions = qa_questions_m::find_questions(question_id);
    if questions.is_none() {
        let html = "失败".to_string();
        return Ok(warp::reply::html(html)); //直接返回html
    }

    let title = questions.unwrap().title;

    let config = crate::reptile::KimiConfig {
        // api_url: "https://api.moonshot.cn/v1/chat/completions".to_string(),
        api_url: crate::get_env("kimi_api_url"),
        api_key: crate::get_env("kimi_api_key"),
        stream: false, //是否启用流式返回
    };
    let lawyers = ["宋律师", "郭律师助理", "王律师", "翁律师", "周律师助理"];

    let data = crate::reptile::kimi(title, &config).await;
    log::warn!("AI回来：{:#?}", data);
    if let Some(ref choices) = data.choices {
        //AI有回复
        log::warn!("AI有回复");
        let mesage = &choices.first().expect("AI没有返回正确的消息").message;
        let user_name = get_random_assistant(&lawyers);

        let new_data = qa_answers_m::NewQAAnswers {
            question_id: question_id,
            content: mesage.content.clone(),
            user_id: 1,  //kimi为1,
            user_name: Some(user_name), //这里还要做随机生成
            is_accepted: None,
            created_at: None,
            updated_at: None,
        };
        let insert_id = new_data.insert();
        log::warn!("Insert:{}", insert_id);
    }

    let html = "成功".to_string();
    Ok(warp::reply::html(html)) //直接返回html
}

fn get_random_assistant(lawyers: &[&str]) -> String {
    use rand::Rng;
    let mut rng = rand::thread_rng(); // 创建一个线程局部的随机数生成器
    let index = rng.gen_range(0..lawyers.len()); // 生成一个随机索引
    let k = lawyers[index]; // 返回随机选择的字符串
    let j = k.to_string();
    j
}

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
