use crate::template::to_html_single;
use handlebars::{to_json, Handlebars};
use serde_derive::{Deserialize, Serialize};
use serde_json::value::Map;
use warp::{Rejection, Reply};

/* 响应： new_html*/
//
pub async fn new_html() -> std::result::Result<impl Reply, Rejection> {
    log::debug!("[调试信息]访问了“/demo/redirect”");

    let mut data = Map::new();
    // let html = to_html_single("reptile_new.html", data);
    let html = to_html_single("reptile/new.html", data);

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回状态码
}

#[derive(Debug, Clone, serde::Deserialize)]
pub struct NewPost {
    pub url: String, //要抓的目录URL
}
impl NewPost {
    pub fn validate(&self) -> Result<Self, &'static str> {
        if self.url.is_empty() {
            return Err("url不能为空");
        }
        Ok(self.clone())
    }
}

//只抓取“华律”问答
pub async fn qa_66law() -> std::result::Result<impl Reply, Rejection> {
    //华侓 精选解答: https://v.66law.cn/jx/
    let url = "https://v.66law.cn/jx/";
    let result = crate::http::http_request(url).await;
    let response = result.unwrap();
    // println!("response: {:?}", response);
    let html = response.html.as_str();
    // println!("抓取到的html=========={}", html);
    let data = crate::parse::hualv_select(html).await;
    log::info!("所有抓到的提问标题：{:#?}", data);

    for title in data.title {
        if title.is_empty() {
            continue;
        }

        //插入到表
        let new_data = crate::models::qa_questions_m::NewQAQuestions {
            title: title,
            content: None,
            user_id: 0,
            user_name: Some("华律精选".to_string()),
            category_id: None,
            is_show: Some(false),
            created_at: None,
        };
        let insert_id = new_data.insert();
    }

    let html = "成功".to_string();
    Ok(warp::reply::html(html)) //直接返回html
}

pub async fn qa_lvlin_baidu() -> std::result::Result<impl Reply, Rejection> {
    let url = "https://lvlin.baidu.com/pc/qa-999-2.html";
    let result = crate::http::http_request(url).await;
    let response = result.unwrap();
    // println!("response: {:?}", response);
    let html = response.html.as_str();
    // println!("抓取到的html=========={}", html);
    let data = crate::parse::lvlin_baidu_select(html).await;
    log::info!("所有抓到的提问标题：{:#?}", data);

    for title in data.title {
        if title.is_empty() {
            continue;
        }

        //插入到表
        let new_data = crate::models::qa_questions_m::NewQAQuestions {
            title: title,
            content: None,
            user_id: 0,
            user_name: Some("百度律临".to_string()),
            category_id: None,
            is_show: Some(false),
            created_at: None,
        };
        let insert_id = new_data.insert();
    }

    let html = "成功".to_string();
    Ok(warp::reply::html(html)) //直接返回html
}

//响应post /reptile/66law/new
//华侓 精选解答: https://v.66law.cn/jx/
//百度律临 -最新问答： https://lvlin.baidu.com/pc/qa-999-2.html
pub async fn new(form: NewPost) -> std::result::Result<impl Reply, Rejection> {
    log::error!("post:{:#?}", form);
    match form.validate() {
        Ok(post) => {
            let url = post.url.as_str();

            let result = crate::http::http_request(url).await;
            let response = result.unwrap();
            // println!("response: {:?}", response);
            let html = response.html.as_str();
            // println!("抓取到的html=========={}", html);
            let data = crate::parse::hualv_select(html).await;
            // let data = crate::parse::lvlin_baidu_select(html).await;
            log::info!("所有抓到的提问标题：{:#?}", data);

            for title in data.title {
                if title.is_empty() {
                    continue;
                }

                //插入到表
                let new_data = crate::models::qa_questions_m::NewQAQuestions {
                    title: title,
                    content: None,
                    user_id: 0,
                    user_name: None,
                    category_id: None,
                    is_show: Some(false),
                    created_at: None,
                };
                let insert_id = new_data.insert();
            }
        }
        Err(e) => {}
    }

    // let mut data = Map::new();
    let mut html = "抓取书目录页".to_string();
    // let html = to_html_single("reptile/new.html", data);

    Ok(warp::reply::html(html))
}
