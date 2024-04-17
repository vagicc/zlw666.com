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
        .or(rand())
        .or(backstage())
}

pub fn rand() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone {
    warp::get()
        .and(warp::path("coze"))
        .and(warp::path("rand"))
        .and(warp::path::end())
        .and_then(coze_handler::test_rand_image)
}

pub fn backstage(
) -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone {
    warp::get()
        .and(warp::path("coze"))
        .and(warp::path("backstage"))
        .and(warp::path::end())
        .and_then(coze_handler::backstage)
}
