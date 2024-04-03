use crate::db::get_connection;
use crate::schema::cmf_portal_post;
use crate::schema::cmf_portal_post::dsl::*;
use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};

/* 表查询插入结构体(Insertable：插入，Queryable：查询) */
#[derive(Debug, Clone, Queryable, Serialize, Deserialize)]
pub struct CMFPortalPost {
    pub id: u64,
    pub son_id: i32,      //四级分类id
    pub category_id: u64, //三级分类id
    pub parent_id: u64,   //二级分类id
    pub top_id: u64,      //一级分类id
    pub post_type: u8,    //类型,1:文章;2:页面
    pub post_format: u8,  //内容格式;默认1:html;2:md
    pub user_id: u64,     //
    pub post_status: u8,  //状态;默认1:已发布;0:未发布;
    pub list_order: f32,  //排序,默认：10000
    pub is_top: u8,       //是否置顶;1:置顶; 默认0:不置顶
    pub recommended:u8,   //
    pub post_hits:u64,    // 
    pub post_favorites:u32,    //
    pub post_like:u64,  // 
    pub comment_count:u64, //
    pub create_time:u32, //
    pub update_time:u32, //
    pub published_time:u32, //
    pub delete_time:u32, //
    pub post_title:String, //
    pub short_title:Option<String>, //
    pub post_keywords:String,
    pub post_excerpt:Option<String>, //
    pub post_source:Option<String>, //
    pub thumbnail:Option<String>, //
    pub post_content:Option<String>,
    pub post_content_filtered:Option<String>,
    pub more:Option<String>,

}
