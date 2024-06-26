use crate::db::get_connection;
use crate::schema::qa_questions;
use crate::schema::qa_questions::dsl::*;
use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};

/* 表查询插入结构体合二为一(Insertable：插入，Queryable：查询) */
#[derive(Debug, Clone, Queryable, Deserialize, Serialize)]
pub struct QAQuestions {
    pub id: i32,
    pub title: String,
    pub content: Option<String>,
    pub user_id: i32,
    pub user_name: Option<String>,
    pub category_id: Option<i32>,
    pub is_show: Option<bool>,
    pub created_at: Option<NaiveDateTime>,
}

#[derive(Debug, Clone, Insertable, AsChangeset)]
#[table_name = "qa_questions"]
pub struct NewQAQuestions {
    pub title: String,
    pub content: Option<String>,
    pub user_id: i32,
    pub user_name: Option<String>,
    pub category_id: Option<i32>,
    pub is_show: Option<bool>,
    pub created_at: Option<NaiveDateTime>,
}

impl NewQAQuestions {
    pub fn insert(&self) -> i32 {
        let mut connection = get_connection();

        //开启事务(原因是mysql无法用get_result)，只能这样子取到插入ID
        let last_insert_id = connection
            .transaction::<i32, diesel::result::Error, _>(|conn| {
                let result = diesel::insert_into(qa_questions).values(self).execute(conn);
                // .expect("qa_questions表插入数据出错");

                let last_insert_id = match result {
                    Ok(row) => {
                        let last_insert_id = qa_questions
                            .order(id.desc())
                            .select(id)
                            .first::<i32>(conn)
                            .expect("查询最新插入ID出错");
                        last_insert_id
                    }
                    Err(e) => {
                        log::error!("插入数据出错：{:#?}", e);
                        /*
                        插入数据出错：DatabaseError(
                            UniqueViolation,
                            "Duplicate entry '生产销售有毒有害食品罪' for key 'title'",
                        ) */
                        0
                    }
                };

                //查询最新的数据
                // let last_insert_id = qa_questions
                //     .order(id.desc())
                //     .select(id)
                //     .first::<i32>(conn)
                //     .expect("查询最新插入ID出错");
                Ok(last_insert_id)
            })
            .expect("事务执行失败");
        last_insert_id
    }
}

pub fn find_questions(pky: i32) -> Option<QAQuestions> {
    let query = qa_questions.find(pky);

    log::debug!(
        "find_questions查询SQL:{:?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string()
    );

    let mut connection = get_connection();
    let result = query.first::<QAQuestions>(&mut connection);
    match result {
        Ok(row) => Some(row),
        Err(err) => {
            log::debug!("find_questions查无数据：{}", err);
            None
        }
    }
}

/// 取得列表数据
/// page: Option<u32>  第几页
/// per: Option<u32>   每页多少条数据,默认为50
/// 返回（总条数：i64,数据数组，分页html)
pub fn list_page(page: Option<u32>, per: Option<u32>) -> (i64, Vec<QAQuestions>, String) {
    let mut limit: i64 = 50; //每页取几条数据
    let mut offset: i64 = 0; //从第0条开始

    if !per.is_none() {
        limit = per.unwrap() as i64;
    }

    if !page.is_none() && page.unwrap() > 1 {
        offset = ((page.unwrap() as i64) - 1) * limit;
    }

    let query_count = qa_questions.filter(is_show.eq(true)).count();
    log::error!(
        "分页数量查询SQL：{:#?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query_count).to_string()
    );
    let mut conn = get_connection();
    let count: i64 = query_count
        .get_result(&mut conn)
        .expect("qa_questions分页数量查询出错"); //查询总条数
    let mut pages = String::new();
    let data_null: Vec<QAQuestions> = Vec::new();
    if count <= 0 {
        // return (count, data_null, pages);
    }
    let query = qa_questions
        .filter(is_show.eq(true))
        .order_by(id.desc())
        .limit(limit)
        .offset(offset);
    log::error!(
        "分页查询SQL：{:#?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string()
    );

    let list = query
        .get_results::<QAQuestions>(&mut conn)
        .unwrap_or(data_null);

    println!("{:?}", list);
    pages = crate::pager::default("questions/list", count, page.unwrap_or(1), limit as u32);

    // pages="";  这里做分页HTML
    (count, list, pages)
}
