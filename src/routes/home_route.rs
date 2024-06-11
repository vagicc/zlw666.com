use crate::handlers::home_handler;
use warp::Filter;

// GET: /
pub fn index() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
    let home = warp::get()
        .and(warp::path::end())
        .and_then(home_handler::index);
    home.or(lawtrim()).or(lawyer())
}

//静态页集中
// GET： /law-firm
pub fn lawtrim() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
    let law = warp::get()
        .and(warp::path("law-firm"))
        .and(warp::path::end())
        .and_then(home_handler::lawfirm);
    law
}

//静态页集中
// GET： /lawyer
pub fn lawyer() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
    let law = warp::get()
        .and(warp::path("lawyer"))
        .and(warp::path::end())
        .and_then(home_handler::lawyer);
    law
}
