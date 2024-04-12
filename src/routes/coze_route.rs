use crate::handlers::coze_handler;
use warp::Filter;

/// GET: /coze/title
pub fn index() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
    warp::get()
        .and(warp::path("coze"))
        .and(warp::path("title"))
        .and(warp::path::param())
        .and(warp::path::end())
        .and_then(coze_handler::title)
}
