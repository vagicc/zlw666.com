use crate::db::get_connection;
use crate::schema::qa_answers;
use crate::schema::qa_answers::dsl::*;
use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};

/* 表查询插入结构体合二为一(Insertable：插入，Queryable：查询) */
#[derive(Debug, Clone, Queryable, Deserialize, Serialize)]
pub struct QAAnswers {
    pub id: i32,
    pub question_id: i32,
    pub content: String,
    pub user_id: i32,
    pub user_name: Option<String>,
    pub is_accepted: Option<bool>,
    pub created_at: Option<NaiveDateTime>,
    pub updated_at: Option<NaiveDateTime>,
}

#[derive(Debug, Clone, Insertable, AsChangeset)]
#[table_name = "qa_answers"]
pub struct NewQAAnswers {
    pub question_id: i32,
    pub content: String,
    pub user_id: i32,
    pub user_name: Option<String>,
    pub is_accepted: Option<bool>,
    pub created_at: Option<NaiveDateTime>,
    pub updated_at: Option<NaiveDateTime>,
}
impl NewQAAnswers {
    pub fn insert(&self) -> i32 {
        let mut connection = get_connection();

        //开启事务(原因是mysql无法用get_result)，只能这样子取到插入ID
        let last_insert_id = connection
            .transaction::<i32, diesel::result::Error, _>(|conn| {
                diesel::insert_into(qa_answers)
                    .values(self)
                    .execute(conn)
                    .expect("qa_answers表插入数据出错");

                //查询最新的数据
                let last_insert_id = qa_answers
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

//取得问题的所有答案
pub fn get_my_answers(q_id: i32) -> Option<Vec<QAAnswers>> {
    let query = qa_answers.filter(question_id.eq(q_id)).order_by(id.desc());
    log::debug!(
        "get_my_answers查询SQL:{:?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string()
    );
    let mut conn = get_connection();
    let result = query.get_results::<QAAnswers>(&mut conn);
    match result {
        Ok(list) => Some(list),
        Err(err) => {
            log::debug!("get_my_answers查无数据：{}", err);
            None
        }
    }
}
