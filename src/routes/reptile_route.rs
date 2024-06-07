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
}
