use reqwest::header::{HeaderValue, ACCEPT, AUTHORIZATION, CONNECTION, CONTENT_TYPE, HOST};
use serde_derive::{Deserialize, Serialize};
use serde_json::Value;
use std::collections::HashMap;
//爬虫请求全部集中到此处

#[derive(Debug, Clone)]
pub struct CozeConfig {
    pub api_url: String, //https://api.coze.com/open_api/v2/chat
    pub api_key: String,
    pub conversation_id: String, //标识对话发生在哪一次会话中,示例中默认为123
    pub bot_id: String,          //要进行会话聊天的 Bot ID机器模型的ID：7356134116951867400
    pub stream: bool,            //是否启用流式返回
}

#[derive(Debug, Deserialize, Serialize)]
pub struct CozePostData {
    pub conversation_id: String, //标识对话发生在哪一次会话中
    pub bot_id: String,          //要进行会话聊天的 Bot ID
    pub user: String,            //标识当前与 Bot 交互的用户，使用方自行维护此字段
    pub query: String,           //用户输入内容
    pub stream: bool,            //是否启用流式返回
}

//官方文档：https://www.coze.com/open/docs/chat?_lang=zh
pub async fn coze(
    say: String,
    user: String,
    config: &CozeConfig,
) -> crate::json_value::coze_response_json::CozeResponse {
    // 创建一个 HeaderMap 来存储请求头
    let mut headers = reqwest::header::HeaderMap::new();
    headers.insert(CONTENT_TYPE, HeaderValue::from_static("application/json"));
    headers.insert(ACCEPT, HeaderValue::from_static("*/*"));
    headers.insert(HOST, HeaderValue::from_static("api.coze.com"));
    headers.insert(CONNECTION, HeaderValue::from_static("keep-alive"));
    let bearer = format!("Bearer {}", config.api_key);
    headers.insert(AUTHORIZATION, bearer.parse().unwrap());
    //这个还要写活
    // headers.insert(
    //     AUTHORIZATION,
    //     HeaderValue::from_static(
    //         "Bearer pat_1ACJqMzr4mMFGNJ5Mdlq5smyggnnSgp5x8LCqaYq4NbGCvHnO0ABrsMXZa3UQatY",
    //     ),
    // );

    // post: &CozePostData
    let post = CozePostData {
        conversation_id: config.conversation_id.clone(), //标识对话发生在哪一次会话中
        bot_id: config.bot_id.clone(),                   //要进行会话聊天的 Bot ID
        user: user,            //标识当前与 Bot 交互的用户，使用方自行维护此字段
        query: say,            //用户输入内容
        stream: config.stream, //是否启用流式返回
    };
    let body = serde_json::to_string(&post).unwrap();

    let client = reqwest::Client::new();
    let response = client
        .post(config.api_url.clone())
        .headers(headers)
        .body(body)
        .send()
        .await
        .expect("请求coze.com接口出错");

    // 检查响应
    if !response.status().is_success() {
        log::error!("Request failed with status: {:#?}", response.status());
    }
    // println!("成功");
    // println!("{}", response.text().await.unwrap());
    // println!("请求完成");

    use crate::json_value::coze_response_json;
    let messages = response
        .json::<coze_response_json::CozeResponse>()
        .await
        .unwrap();
    log::debug!("接收到的返回消息：{:#?}", messages);
    messages
}

//这里还要有其它的参数
pub async fn _coze_old(say: &str, stream: bool, config: CozeConfig) {
    let client = reqwest::Client::new();
    let mut headers = reqwest::header::HeaderMap::new();

    headers.insert(CONTENT_TYPE, HeaderValue::from_static("application/json"));
    headers.insert(ACCEPT, HeaderValue::from_static("*/*"));
    headers.insert(HOST, HeaderValue::from_static("api.coze.com"));
    headers.insert(CONNECTION, HeaderValue::from_static("keep-alive"));
    headers.insert(
        AUTHORIZATION,
        HeaderValue::from_static(
            "Bearer pat_1ACJqMzr4mMFGNJ5Mdlq5smyggnnSgp5x8LCqaYq4NbGCvHnO0ABrsMXZa3UQatY",
        ),
    );

    // 创建一个 POST 请求的主体
    let body = r#"{
        "conversation_id": "123",
        "bot_id": "7356134116951867400",
        "user": "22555",
        "query": "生成“深圳盗窃罪一万元判几年”文章",
        "stream":false
    }"#;

    //下面这个是示例怎么在原始字符串字面量插入变量
    let data = format!(
        r#"{{
        "key": "value",
        "user": "{}"
    }}"#,
        "22555"
    );
    println!("{}", data); // 输出 "{"key": "value","user": "22555"}"

    // 发送 POST 请求并获取响应
    let result = client
        .post("https://api.coze.com/open_api/v2/chat")
        .headers(headers)
        .body(body)
        .send()
        .await;

    match result {
        Ok(response) => {
            log::info!("请求成功返回的的数据：{:#?}", response);
            // 检查响应
            if response.status().is_success() {
                println!("Request successful!");
                //打印出请求的返回
                println!("{:#?}", response.text().await.unwrap());
            } else {
                println!("Request failed with status: {}", response.status());
            }
        }
        Err(err) => {
            log::error!("Coze请求出错：{:#?}", err);
        }
    }
}

#[derive(Debug, Clone)]
pub struct ReptileList {
    pub title: String,      //列表标题
    pub detail_url: String, //详情播放url
    pub list_img: String,   //列表图
}

/* 解析HTML文件 */
pub async fn list(url: &str) -> Option<Vec<ReptileList>> {
    let client = reqwest::Client::new();
    let mut headers = reqwest::header::HeaderMap::new();
    // headers.insert("user-agent", "luck-kd".parse().unwrap());
    // headers.insert("ontent-Type", "application/json".parse().unwrap());
    // Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36
    headers.insert("user-agent", "Mozilla/5.0 (X11; Windows x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36".parse().unwrap());
    // headers.insert("User-Agent", "Mozilla/5.0 (X11; Windows x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36".parse().unwrap());
    headers.insert("sec-ch-ua-platform", "Windows".parse().unwrap());
    let response = client.get(url).headers(headers).send().await;
    // let response = reqwest::get(url).await;

    if response.is_err() {
        // println!("详情网站访问不了：{}", url);
        log::error!("详情网站访问不了：{}", url);
        return None;
    }

    let response = response.unwrap();

    // let response = reqwest::get(url).await.expect("网站不可访问");

    // let base_url=response.url().origin().ascii_serialization();
    let base_url = response.url().origin().unicode_serialization(); // https://bchangke.vip
    let response_text = response.text().await.expect("转换为文本出错");
    let html = response_text.as_str();

    use select::document::Document;
    use select::predicate::{Attr, Class, Name, Predicate};

    // let base_url = "https://bchangke.vip/".to_string();
    // let html = include_str!("html/list.html");
    let document = Document::from(html);

    let mut ad_title = String::new(); //广告标题

    // for ad_node in document.find(Attr("id", "dataic").descendant(Name("a"))) {
    for ad_node in document.find(
        Attr("id", "dataic")
            .descendant(Name("p"))
            .descendant(Name("a")),
    ) {
        // println!(
        //     "广告：{} => ({:?})",
        //     ad_node.text(),
        //     ad_node.attr("href").unwrap()
        // );
        ad_title = ad_node.text();
    }

    // println!("要去除的：{}",ad_title);
    // return false;

    // for ul_node in document.find(Class("lb_nr")) {
    let ul_node = document
        .find(Class("lb_nr"))
        .next()
        .expect("查找不到列表类");

    let mut list_vec: Vec<ReptileList> = Vec::new();
    let mut index = 0;
    // let li = ul_node.find(Name("li"));
    for li_node in ul_node.find(Name("li")) {
        // <div class="lm_lbimg">
        //     <a href="/html/43274/" name="点击播放">
        //         <img src="https://tu555pian.com:1443/p2/03cdcfb4dc132579248e7cb5fd90abb9.jpg" alt="/image/p2/03cdcfb4dc132579248e7cb5fd90abb9.jpg">
        //     </a>
        // </div>
        // let img = li_node
        //     .find(Name("a").descendant(Name("img")))
        //     .next()
        //     .unwrap()
        //     .attr("src")
        //     .unwrap();

        // //列表图不对，不在这里处理，只在详情处理
        // let img = li_node
        //     .find(Class("lm_lbimg").descendant(Name("a")))
        //     .next()
        //     .unwrap();
        // let img = img.find(Name("img")).next().unwrap().attr("src").unwrap();
        // let img = format!("{}{}", base_url, img);
        let img = String::new();

        // println!("列表图：{}", img);

        let content_node = li_node
            .find(Name("p").descendant(Name("a")))
            .next()
            .unwrap();

        // let im_node = content_node.find(Name("img")).next().unwrap();
        // // let img = im_node.attr("src").unwrap();
        // let k_img=im_node.attr("src").unwrap();
        // println!("列表图：{}", k_img);

        let title = content_node.text();
        // println!("列表标题：{}", title);
        if ad_title.eq(&title) {
            //跳过广告
            continue;
        }
        let detail_url = content_node.attr("href").unwrap();
        let detail_url = format!("{}{}", base_url, detail_url);
        // println!("详情播放url: {}", detail_url);

        /* 要把域名ppp.downloadxx.com换成: xia777zhai.com才可以分段下载*/

        let list = ReptileList {
            title: title,
            detail_url: detail_url,
            list_img: img,
        };

        list_vec.insert(index, list);
        index += 1;
    }

    if list_vec.is_empty() {
        log::error!("无列表数据");
        return None;
    }

    // 下面这个是取得当前页所有的 URL
    // Document::from(response.as_str())
    //     .find(Name("a"))
    //     .filter_map(|n| n.attr("href"))
    //     .for_each(|x| println!("所有的链接：{}", x));

    Some(list_vec)
}

pub async fn old_detail(url: &str) -> String {
    //解析详情页
    // let url = "https://bchangke.vip/html/43142/"; //详情页

    //https://bchangke.vip/html/42747/    详情页
    // let response = reqwest::get(url).await.expect("网站不可访问");
    let response = reqwest::get(url).await;
    if response.is_err() {
        println!("详情网站访问不了：{}", url);
        log::error!("详情网站访问不了：{}", url);
        return "".to_string();
    }
    let response = response.unwrap();

    // let base_url=response.url().origin().ascii_serialization();
    // let base_url = response.url().origin().unicode_serialization(); // https://bchangke.vip

    let html = response.text().await.expect("转换为文本出错");

    use select::document::Document;
    use select::predicate::{Attr, Class, Name, Predicate};

    let document = Document::from(html.as_str());

    // let downall_node = document
    //     .find(Attr("id", "clickdownload").descendant(Name("a")))
    //     .next()
    //     .unwrap();   //这个有可能解析不出来   =====

    let downall_node = document
        .find(Attr("id", "clickdownload").descendant(Name("a")))
        .next(); //这个有可能解析不出来   =====
    if downall_node.is_none() {
        println!("详情网站解析不了下载地址：{}", url);
        return "".to_string();
    }
    let downall_node = downall_node.unwrap();

    // let d_name = downall_node.text();
    let down_url = downall_node.attr("href").unwrap();

    /* 要把域名ppp.downloadxx.com换成: xia777zhai.com才可以分段下载*/
    let down_url = down_url.replace("ppp.downloadxx.com", "xia777zhai.com");
    // println!("详情解析出来的：{} ： {}", d_name, down_url);
    println!("详情解析出来的 ： {}", down_url);

    down_url.to_string()
}

#[derive(Debug, Clone)]
pub struct ReptileDetail {
    pub title: String,       //标题
    pub img: String,         //视频图
    pub downloadurl: String, //视频下载URL
}

pub async fn detail(url: &str) -> Option<ReptileDetail> {
    // let response = reqwest::get(url).await.expect("网站不可访问");
    let client = reqwest::Client::new();
    let mut headers = reqwest::header::HeaderMap::new();
    // headers.insert("user-agent", "luck-kd".parse().unwrap());
    // headers.insert("ontent-Type", "application/json".parse().unwrap());
    // Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36
    headers.insert("user-agent", "Mozilla/5.0 (X11; Windows x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36".parse().unwrap());
    // headers.insert("User-Agent", "Mozilla/5.0 (X11; Windows x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36".parse().unwrap());
    headers.insert("sec-ch-ua-platform", "Windows".parse().unwrap());
    let response = client.get(url).headers(headers).send().await;
    // let response = reqwest::get(url).await;

    if response.is_err() {
        println!("详情网站访问不了：{}", url);
        log::error!("详情网站访问不了：{} => {:#?}", url, response);
        return None;
    }
    let response = response.unwrap();

    let html = response.text().await.expect("转换为文本出错");

    use select::document::Document;
    use select::predicate::{Attr, Class, Name, Predicate};

    let document = Document::from(html.as_str());

    // <main id="main" class="xq_nr">
    // 			<div class="xq_bt">日韩三级：未熟之夏-下集</div>
    // <main id="main" class="xq_nr">
    // 			<div class="xq_bt">国产AV：春药试用女郎-宋妮可</div>

    // let main_node = document
    //     .find(Class("xq_nr"))
    //     .next()
    //     .expect("详情页主class变了");

    let main_node_option = document.find(Class("xq_nr")).next();
    if main_node_option.is_none() {
        return None;
    }

    let main_node = main_node_option.unwrap();

    // let title_node = document
    //     .find(Class("xq_nr").descendant(Class("xq_bt")))
    //     .next()
    //     .expect("详情页解析不到标题");
    let title_node = main_node
        .find(Class("xq_bt"))
        .next()
        .expect("详情页解析不了标题");
    let detail_title = title_node.text().trim().to_string();
    // println!("详情标题：{}", detail_title);

    //这个只有浏览器访问时才有
    // <div class="vjs-poster" tabindex="-1" aria-disabled="false"
    //     style="background-image: url(&quot;https://tu555pian.com:1443/p2/3456c7e600f9bc4b755e272e3e1b969e.jpg&quot;);">
    // </div>

    /*
    爬虫时：
    <div class="bf_nr">
        <div class="bf_gg playcouplet"></div>
        <div class="bf_sp">
            <div class="s_p">
                <video id="video" class="s_p video-js vjs-theme-v1 vjs-big-play-centered vjs-fill"
                    webkit-playsinline="true" playsinline="true">
                    <p class="vjs-no-js">您的浏览器无法观看，请下载<a href="https://www.google.cn/intl/zh-CN/chrome/"
                            title="谷歌浏览器下载">谷歌浏览器</a></p>
                </video>
                <span class="hiddenBox" id="vpath"
                    style="display: none;">06f9bcfa3920fafcecdad8791ae839a6/index.m3u8</span>
                <span class="hiddenBox" id="purl"
                    style="display: none;">/image/p2/06f9bcfa3920fafcecdad8791ae839a6.jpg</span>
                <span style="display: none;"
                    id="downloadurl">https://ppp.downloadxx.com/assets/06f9bcfa3920fafcecdad8791ae839a6.mp4</span>
            </div>
     */
    let img_node = document
        .find(Attr("id", "purl"))
        .next()
        .expect("详情图片解析不了");
    // /image/p2/06f9bcfa3920fafcecdad8791ae839a6.jpg
    // 替换成如下
    // https://tu555pian.com:1443/p2/06f9bcfa3920fafcecdad8791ae839a6.jpg
    let img_url = img_node
        .text()
        .replace("/image/", "https://tu555pian.com:1443/");
    // println!("详情图{:?}", img_url);

    let downall_node = document
        .find(Attr("id", "clickdownload").descendant(Name("a")))
        .next(); //这个有可能解析不出来   =====
    if downall_node.is_none() {
        log::error!("详情网站解析不了下载地址：{}", url);
        return None;
    }
    let downall_node = downall_node.unwrap();

    let down_url = downall_node.attr("href").unwrap();

    /* 要把域名ppp.downloadxx.com换成: xia777zhai.com才可以分段下载*/
    let down_url = down_url.replace("ppp.downloadxx.com", "xia777zhai.com");
    // println!("详情解析出下载UEL ： {}", down_url);

    // down_url.to_string()
    let data = ReptileDetail {
        title: detail_title,
        img: img_url,          //视频图
        downloadurl: down_url, //视频下载URL
    };
    Some(data)
}
