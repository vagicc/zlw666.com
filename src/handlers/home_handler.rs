use handlebars::{to_json, Handlebars};
use warp::{Rejection, Reply};
// use crate::template::to_html_base;
// use serde_json::value::Map;

// type ResultWarp<T> = std::result::Result<T, Rejection>;

/* 响应/请求的返回 */
/// # Example
///
/// ```
/// use warp::{http::Uri, Filter};
///
/// let route = warp::path("v1")
///     .map(|| {
///         warp::redirect(Uri::from_static("/v2"))
///     });
/// ```
pub async fn index() -> std::result::Result<impl Reply, Rejection> {
    // log::debug!("[调试信息]访问了“/”");
    // log::warn!("[警告信息] warn");
    // log::info!("[提示信息] info");

    // let mut data = Map::new();
    // let html = to_html_base("home.html", data);
    let html = "首页";

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}
