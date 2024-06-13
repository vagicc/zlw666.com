use crate::handlers::reptile_handler;
use warp::Filter;

pub fn new() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let post = warp::post()
        .and(warp::path("reptile"))
        .and(warp::path("66law"))
        .and(warp::path("new"))
        .and(warp::path::end())
        .and(warp::body::form())
        .and_then(reptile_handler::new);

    warp::get()
        .and(warp::path("reptile"))
        .and(warp::path("66law"))
        .and(warp::path("new"))
        .and(warp::path::end())
        .and_then(reptile_handler::new_html)
        .or(post)
        .or(qa())
}

///
/// GET: /reptile/qa/66law  抓取“华律网 ” 精选问答中的问题
/// GET: /reptile/qa/lvlin  抓取“百度律临 ” 问答中的问题
pub fn qa() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    let baidu = warp::get()
        .and(warp::path("reptile"))
        .and(warp::path("qa"))
        .and(warp::path("lvlin"))
        .and(warp::path::end())
        .and_then(reptile_handler::qa_lvlin_baidu);

    warp::get()
        .and(warp::path("reptile"))
        .and(warp::path("qa"))
        .and(warp::path("66law"))
        .and(warp::path::end())
        .and_then(reptile_handler::qa_66law)
        .or(baidu)
}
