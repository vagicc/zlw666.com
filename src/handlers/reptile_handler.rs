use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};


/* 响应： new_html*/
// 
pub async fn new_html(session: Session) -> std::result::Result<impl Reply, Rejection> {
    log::debug!("[调试信息]访问了“/demo/redirect”");

    let mut data = Map::new();
    // let html = to_html_single("reptile_new.html", data);
    let html = view("reptile/new.html", data, session);

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回状态码
}