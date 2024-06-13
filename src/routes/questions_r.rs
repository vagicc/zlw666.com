use crate::handlers::kimi_handler;
use warp::Filter;

/// GET: /kimi/test
pub fn index() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
     

    warp::get()
        .and(warp::path("kimi"))
        .and(warp::path("test"))
        .and(warp::path::param())
        .and(warp::path::end())
        .and_then(kimi_handler::test)
}
