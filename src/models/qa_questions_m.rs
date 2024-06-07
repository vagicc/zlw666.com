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
                diesel::insert_into(qa_questions)
                    .values(self)
                    .execute(conn)
                    .expect("qa_questions表插入数据出错");

                //查询最新的数据
                let last_insert_id = qa_questions
                    .order(id.desc())
                    .select(id)
                    .first::<i32>(conn)
                    .expect("查询最新插入ID出错");
                Ok(last_insert_id)
            })
            .expect("事务执行失败");
        last_insert_id
    }
}
