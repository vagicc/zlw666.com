use crate::db::{get_connection, my_connection};
use crate::schema::coze_batch_batchtitle;
use crate::schema::coze_batch_batchtitle::dsl::*;
use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};
use warp::filters::query;

/* 表查询插入结构体合二为一(Insertable：插入，Queryable：查询) */
#[derive(Debug, Clone, Queryable, Deserialize, Serialize)]
pub struct CozeBatchBatchtitle {
    pub id: i64,
    pub title: String,
    pub content: Option<String>,
    pub is_done: Option<bool>,
    pub created_at: NaiveDateTime,
    pub generated_at: Option<NaiveDateTime>,
    pub description: Option<String>,
    pub is_published: Option<bool>,
}

#[derive(Debug, Clone, Insertable, AsChangeset)]
#[table_name = "coze_batch_batchtitle"]
pub struct NewCozeBatchBatchtitle {
    pub title: String,
    pub content: Option<String>,
    pub is_done: Option<bool>,
    pub created_at: NaiveDateTime,
    pub generated_at: Option<NaiveDateTime>,
    pub description: Option<String>,
    pub is_published: Option<bool>,
}

impl NewCozeBatchBatchtitle {
    pub fn insert(&self) -> i64 {
        let mut connection = get_connection();

        //开启事务(原因是mysql无法用get_result)，只能这样子取到插入ID
        let last_insert_id = connection
            .transaction::<i64, diesel::result::Error, _>(|conn| {
                diesel::insert_into(coze_batch_batchtitle)
                    .values(self)
                    .execute(conn)
                    .expect("coze_batch_batchtitle表插入数据出错");

                //查询最新的数据
                let last_insert_id = coze_batch_batchtitle
                    .order(id.desc())
                    .select(id)
                    .first::<i64>(conn)
                    .expect("查询最新插入ID出错");
                Ok(last_insert_id)
            })
            .expect("事务执行失败");
        last_insert_id

        // let last_insert_id =
        //     diesel::sql_query("SELECT LAST_INSERT_ID();").load::<i64>(&mut connection);
        // 执行 SQL 查询，获取最后插入的自增 ID
        // let last_insert_id: Option<i64> = diesel::sql_query("SELECT LAST_INSERT_ID()")
        //     .get_result(&mut connection)
        //     .expect("Failed to get last insert id");

        // let last_insert_id=diesel::sql_query("SELECT LAST_INSERT_ID();").load::<i64>(connection);
        // SELECT LAST_INSERT_ID();   可以通过个条语句得到插入ID

        // 插入成功后，返回最后插入的 id
        // let last_insert_id: Option<i32> = diesel::select(diesel::dsl::last_insert_id)
        //     .first(&mut connection)
        //     .expect("Failed to get last insert id");

        // let k= diesel::insert_into(coze_batch_batchtitle)
        // .values(self)
        // .get_result::<CozeBatchBatchtitle>(&mut connection);
    }
}

pub fn delete(pky: i64) {
    let query = diesel::delete(coze_batch_batchtitle.find(pky));

    let mut conn = get_connection();

    let deleted_rows = query.execute(&mut conn);
}

// 这个函数还要再处理
pub fn modify(pky: i64, data: &NewCozeBatchBatchtitle) {
    let query = diesel::update(coze_batch_batchtitle.find(pky)).set(data);
    log::debug!(
        "coze_batch_batchtitle更新数据SQL:{:?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string()
    );

    let mut connection = get_connection();
    let k = query.execute(&mut connection);
}

pub fn find_title(article_title: String) -> Option<CozeBatchBatchtitle> {
    let query = coze_batch_batchtitle.filter(title.eq(article_title));

    let sql = diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string();
    log::debug!("find_title查询SQL:{:?}", sql);

    let mut connection = get_connection();
    let result = query.first::<CozeBatchBatchtitle>(&mut connection);
    match result {
        Ok(row) => Some(row),
        Err(err) => {
            log::debug!("get_admin查无数据：{}", err);
            None
        }
    }
}

/// 取得列表数据
/// page: Option<u32>  第几页
/// per: Option<u32>   每页多少条数据,默认为50
/// 返回（总条数：i64,数据数组，分页html)
pub fn no_done_list(
    page: Option<u32>,
    per: Option<u32>,
) -> (i64, Vec<CozeBatchBatchtitle>, String) {
    let mut limit: i64 = 50; //每页取几条数据
    let mut offset: i64 = 0; //从第0条开始

    if !per.is_none() {
        limit = per.unwrap() as i64; //u32是无符号整数,也就是大于0
    }

    if !page.is_none() && page.unwrap() > 1 {
        offset = ((page.unwrap() as i64) - 1) * limit;
    }

    let query_count = coze_batch_batchtitle.filter(is_done.eq(false)).count();
    log::error!(
        "分页数量查询SQL：{:#?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query_count).to_string()
    );

    let mut conn = get_connection();
    let count: i64 = query_count
        .get_result(&mut conn)
        .expect("coze_batch_batchtitle分页数量查询出错"); //查询总条数

    let mut pages = String::new();
    let data_null: Vec<CozeBatchBatchtitle> = Vec::new();
    if count <= 0 {
        return (count, data_null, pages);
    }

    let query = coze_batch_batchtitle
        .filter(is_done.eq(false))
        .order_by(id.desc())
        .limit(limit)
        .offset(offset);
    log::error!(
        "分页查询SQL：{:#?}",
        diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string()
    );

    let list = query
        .get_results::<CozeBatchBatchtitle>(&mut conn)
        .unwrap_or(data_null);

    println!("{:?}", list);

    // pages="";  这里做分页HTML
    (count, list, pages)
}
