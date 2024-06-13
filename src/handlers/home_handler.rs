use crate::template::to_html_base;
use handlebars::to_json;
use serde_json::value::Map;
use warp::{Rejection, Reply};

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
    let mut data = Map::new();

    data.insert(
        "seo_title".to_string(),
        to_json("深圳律师-深圳律师事务所-刑事辩护律师-离婚律师咨询-法议网"),
    );
    data.insert(
        "seo_keyword".to_string(),
        to_json("深圳律师事务所,律师,深圳律师,律师事务所,刑事辩护律师,离婚律师,离婚律师咨询,法律咨询,婚姻律师,请律师大概要多少钱"),
    );
    data.insert(
        "seo_description".to_string(),
        to_json("法议律师联盟由法议信息科技有限公司创建，深圳律师事务所法议律师团队专业从事刑事辩护,婚姻家事纠纷,离婚纠纷,债权债务纠纷,民事纠纷,房产纠纷等案件处理,从创立法议网以来,就一直致力于为广大用户提供专业的律师免费法律咨询服务,法议网,您身边的法律顾问专家。"),
    );
    let html = to_html_base("index.html", data);
    // let html = "响应GET： /lawtrim  <br><hr>律所页";

    Ok(warp::reply::html(html)) //直接返回html
                                // Err(warp::reject::not_found())   //错误的返回
}

// 静态页-律所
// 响应GET： /law-firm
pub async fn lawfirm() -> std::result::Result<impl Reply, Rejection> {
    let mut data = Map::new();

    data.insert(
        "seo_title".to_string(),
        to_json("深圳律师-深圳律师事务所-刑事辩护律师-离婚律师咨询-法议网"),
    );
    data.insert(
        "seo_keyword".to_string(),
        to_json("深圳律师事务所,律师,深圳律师,律师事务所,刑事辩护律师,离婚律师,离婚律师咨询,法律咨询,婚姻律师,请律师大概要多少钱"),
    );
    data.insert(
        "seo_description".to_string(),
        to_json("法议律师联盟由法议信息科技有限公司创建，深圳律师事务所法议律师团队专业从事刑事辩护,婚姻家事纠纷,离婚纠纷,债权债务纠纷,民事纠纷,房产纠纷等案件处理,从创立法议网以来,就一直致力于为广大用户提供专业的律师免费法律咨询服务,法议网,您身边的法律顾问专家。"),
    );
    let html = to_html_base("lawfirm/index.html", data);
    // let html = "响应GET： /lawtrim  <br><hr>律所页";
    Ok(warp::reply::html(html)) //直接返回html
}

// 静态页-律师
// 响应GET： /lawyer
pub async fn lawyer() -> std::result::Result<impl Reply, Rejection> {
    let mut data = Map::new();

    data.insert("seo_title".to_string(), to_json("晏华明律师-法议网"));
    data.insert(
        "seo_keyword".to_string(),
        to_json("深圳律师事务所,律师,深圳律师,律师事务所,刑事辩护律师,离婚律师,离婚律师咨询,法律咨询,婚姻律师,请律师大概要多少钱"),
    );
    data.insert(
        "seo_description".to_string(),
        to_json("法议律师联盟由法议信息科技有限公司创建，深圳律师事务所法议律师团队专业从事刑事辩护,婚姻家事纠纷,离婚纠纷,债权债务纠纷,民事纠纷,房产纠纷等案件处理,从创立法议网以来,就一直致力于为广大用户提供专业的律师免费法律咨询服务,法议网,您身边的法律顾问专家。"),
    );
    let html = to_html_base("lawyer/index.html", data);
    // let html = "响应GET： /lawtrim  <br><hr>律所页";
    Ok(warp::reply::html(html)) //直接返回html
}
