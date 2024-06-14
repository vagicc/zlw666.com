use crate::handlers::questions_handler;
use warp::Filter;

/// GET: /questions/list/{page}
pub fn index() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
    warp::get()
        .and(warp::path("questions"))
        .and(warp::path("list"))
        .and(warp::path::param())
        .and(warp::path::end())
        .and_then(questions_handler::list)
        .or(warp::get()
            .and(warp::path("questions"))
            .and(warp::path("list"))
            .and(warp::path::end())
            .and_then(|| async { questions_handler::list(1).await }))
}
