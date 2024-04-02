use crate::template::{to_html_base, to_html_single};
use serde_json::value::Map;
use warp::{Rejection, Reply};

/* 打官司 */

// 响应GET: djdogsfy/10183.html
// 打架斗殴打官司费用 文章详情
pub async fn index(id: u32) -> std::result::Result<impl Reply, Rejection> {
    log::warn!("URL:{}", id);
    let mut data = Map::new();
    let html = to_html_single("sue/djdogsfy.html", data);
    // let html = "打架斗殴打官司费用 文章详情";

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}
