use crate::models::qa_answers_m;
use crate::models::qa_questions_m;
use crate::template::to_html_base;
use handlebars::to_json;
use serde_json::value::Map;
use warp::{Rejection, Reply};

// 问答专区
// 响应GET： /questions/list/{}
pub async fn list(page: u32) -> std::result::Result<impl Reply, Rejection> {
    let (count, list, pages) =
        qa_questions_m::list_page(Some(page), Some(crate::constants::PER_PAGE));

    let mut data = Map::new();
    data.insert("list_len".to_string(), to_json(count)); //
    data.insert("list".to_string(), to_json(list)); //
    data.insert("pages".to_string(), to_json(pages));

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
    let html = to_html_base("questions/list.html", data);
    // let html = "响应GET： /lawtrim  <br><hr>律所页";
    Ok(warp::reply::html(html)) //直接返回html
}

// 问答详情页
// 响应GET： /questions/detail/{}
// 取得问题，取得所有答案，取热门问题
pub async fn detail(question_id: i32) -> std::result::Result<impl Reply, Rejection> {
    let questions = qa_questions_m::find_questions(question_id);
    if questions.is_none() {
        let html = "查无此问题".to_string();
        // let html = "响应GET： /lawtrim  <br><hr>律所页";
        return Ok(warp::reply::html(html)); //直接返回html
    }

    let answers = qa_answers_m::get_my_answers(question_id);

    let mut data = Map::new();
    data.insert("questions".to_string(), to_json(questions));
    data.insert("answers".to_string(), to_json(answers));

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
    let html = to_html_base("questions/detail.html", data);
    // let html = "响应GET： /lawtrim  <br><hr>律所页";
    Ok(warp::reply::html(html)) //直接返回html
}
