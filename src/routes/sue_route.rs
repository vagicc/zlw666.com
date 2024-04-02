use crate::handlers::sue_handler;
use warp::Filter;

pub fn index() -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone
{
    djdogsfy()
}

/// 原GET: djdogsfy/10183.html
/// 现GET: djdogsfy/10183
pub fn djdogsfy(
) -> impl warp::Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone {
    let detail = warp::get()
        .and(warp::path("djdogsfy"))
        // .and(warp::path!("sum" / u32 ))
       .and(warp::path::param())
        .and(warp::path::end())
        .and_then(sue_handler::index);
    
    detail
}
