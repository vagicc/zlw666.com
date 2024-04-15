/// 取得.env文件key里的值
pub fn get_env(key: &str) -> String {
    dotenv::dotenv().ok();
    let msg = ".env文件必须配置的环境变量：".to_string() + key;
    let value = std::env::var(key).expect(&msg);
    value
}


pub fn now_naive_date_time() -> chrono::NaiveDateTime {
    // use chrono::prelude::{Local, NaiveDate, NaiveDateTime};
    let fmt = "%Y-%m-%d %H:%M:%S";
    let now = chrono::prelude::Local::now();
    let dft = now.format(fmt);
    let str_date = dft.to_string();
    // println!("当前时间：{}", str_date);
    let now_date_time =
        chrono::prelude::NaiveDateTime::parse_from_str(str_date.as_str(), fmt).unwrap();
    // let now_date = chrono::prelude::NaiveDate::parse_from_str(str_date.as_str(), "%Y-%m-%d").unwrap();

    return now_date_time;
}

pub fn now_naive_date() -> chrono::NaiveDate {
    // use chrono::prelude::{Local, NaiveDate, NaiveDateTime};
    let fmt = "%Y-%m-%d";
    let now = chrono::prelude::Local::now();
    let dft = now.format(fmt);
    let str_date = dft.to_string();
    // println!("当前时间：{}", str_date);
    // let now_date_time =
    //     chrono::prelude::NaiveDateTime::parse_from_str(str_date.as_str(), fmt).unwrap();
    let now_date = chrono::prelude::NaiveDate::parse_from_str(str_date.as_str(), "%Y-%m-%d")
        .expect("转日期出错？");

    return now_date;
}