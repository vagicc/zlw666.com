use select::document::Document;
use select::predicate::{Attr, Class, Name, Predicate};

#[derive(Debug, Clone)]
pub struct HualvQuestion {
    pub title: Vec<String>,
}

//华律网
pub async fn hualv_select(html: &str) -> HualvQuestion {
    // let html = include_str!("src/views/reptile/66law.cn.html");  //这个用作测试
    let document = Document::from(html);

    let question_ul = document
        .find(Attr("class", "wenda-list mt10"))
        // .find(Class("wenda-list mt10"))
        .next()
        .expect("找不到类：wenda-list mt10,处理取得华律网的最新精选问答");

    let mut title: Vec<String> = Vec::new();
    //<h4><a href="/jx/qjdlzm.html">缺斤短两怎么处罚相关规定是什么</a></h4>
    for li_node in question_ul.find(Name("li")) {
        let h4_node = li_node.find(Name("h4")).next().expect("找不到提问的标题");
        let question_title = h4_node.text().trim().to_string();
        println!("{}", question_title);
        title.push(question_title);
    }
    HualvQuestion { title: title }
}

#[derive(Debug, Clone)]
pub struct LvlinBaiduQuestion {
    pub title: Vec<String>,
}

pub async fn lvlin_baidu_select(html: &str) -> LvlinBaiduQuestion {
    // let html = include_str!("src/views/reptile/66law.cn.html");  //这个用作测试
    let document = Document::from(html);

    //content-left
    let question_datas_node = document
        // .find(Attr("class", "content-left"))
        .find(Class("content-left"))
        .next()
        .expect("找不到类：content-left,处理取得华律网的最新精选问答");

    /*
    <div class="question-title" data-v-db871fc0>
        关于民刑交叉案件中同一事实的认定问题
        <!---->
    </div>
    */
    // let titles_nodes = question_datas_node.find(Class("question-title"));
    let mut title: Vec<String> = Vec::new();
    for title_node in question_datas_node.find(Class("question-title")) {
        let question_title = title_node.text().trim().to_string();
        println!("提问问题：{}", question_title);
        title.push(question_title);
    }
    LvlinBaiduQuestion { title: title }
}
