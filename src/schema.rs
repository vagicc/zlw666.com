// @generated automatically by Diesel CLI.

pub mod sql_types {
    #[derive(diesel::query_builder::QueryId, diesel::sql_types::SqlType)]
    #[diesel(mysql_type(name = "Set"))]
    pub struct DedeArchivesFlagSet;
}

diesel::table! {
    batch_batchtitle (id) {
        id -> Bigint,
        #[max_length = 255]
        title -> Varchar,
        content -> Nullable<Longtext>,
        is_done -> Bool,
        created_at -> Datetime,
        generated_at -> Nullable<Datetime>,
        #[max_length = 300]
        description -> Nullable<Varchar>,
        is_published -> Bool,
    }
}

diesel::table! {
    cmf_portal_category (id) {
        id -> Unsigned<Bigint>,
        parent_id -> Unsigned<Bigint>,
        top_id -> Unsigned<Bigint>,
        post_count -> Unsigned<Bigint>,
        status -> Unsigned<Tinyint>,
        delete_time -> Unsigned<Integer>,
        list_order -> Float,
        #[max_length = 200]
        name -> Varchar,
        #[max_length = 200]
        typedir -> Varchar,
        #[max_length = 255]
        description -> Nullable<Varchar>,
        #[max_length = 255]
        path -> Nullable<Varchar>,
        #[max_length = 100]
        seo_title -> Nullable<Varchar>,
        #[max_length = 255]
        seo_keywords -> Nullable<Varchar>,
        #[max_length = 255]
        seo_description -> Nullable<Varchar>,
        #[max_length = 50]
        list_tpl -> Nullable<Varchar>,
        #[max_length = 50]
        one_tpl -> Nullable<Varchar>,
        more -> Nullable<Text>,
    }
}

diesel::table! {
    cmf_portal_post (id) {
        id -> Unsigned<Bigint>,
        son_id -> Integer,
        category_id -> Unsigned<Bigint>,
        parent_id -> Unsigned<Bigint>,
        top_id -> Unsigned<Bigint>,
        post_type -> Unsigned<Tinyint>,
        post_format -> Unsigned<Tinyint>,
        user_id -> Unsigned<Bigint>,
        post_status -> Unsigned<Tinyint>,
        list_order -> Unsigned<Float>,
        comment_status -> Unsigned<Tinyint>,
        is_top -> Unsigned<Tinyint>,
        recommended -> Unsigned<Tinyint>,
        post_hits -> Unsigned<Bigint>,
        post_favorites -> Unsigned<Integer>,
        post_like -> Unsigned<Bigint>,
        comment_count -> Unsigned<Bigint>,
        create_time -> Unsigned<Integer>,
        update_time -> Unsigned<Integer>,
        published_time -> Unsigned<Integer>,
        delete_time -> Unsigned<Integer>,
        #[max_length = 255]
        post_title -> Varchar,
        #[max_length = 200]
        short_title -> Nullable<Varchar>,
        #[max_length = 150]
        post_keywords -> Nullable<Varchar>,
        #[max_length = 500]
        post_excerpt -> Nullable<Varchar>,
        #[max_length = 150]
        post_source -> Nullable<Varchar>,
        #[max_length = 100]
        thumbnail -> Nullable<Varchar>,
        post_content -> Nullable<Mediumtext>,
        post_content_filtered -> Nullable<Text>,
        more -> Nullable<Text>,
    }
}

diesel::table! {
    cmf_portal_tag_post (id) {
        id -> Bigint,
        tag_id -> Unsigned<Bigint>,
        post_id -> Unsigned<Bigint>,
        status -> Unsigned<Tinyint>,
    }
}

diesel::table! {
    coze_batch_batchtitle (id) {
        id -> Bigint,
        #[max_length = 255]
        title -> Varchar,
        content -> Nullable<Longtext>,
        is_done -> Nullable<Bool>,
        created_at -> Datetime,
        generated_at -> Nullable<Datetime>,
        #[max_length = 300]
        description -> Nullable<Varchar>,
        #[max_length = 255]
        seo_title -> Nullable<Varchar>,
        #[max_length = 255]
        seo_keywords -> Nullable<Varchar>,
        #[max_length = 300]
        seo_description -> Nullable<Varchar>,
        is_published -> Nullable<Bool>,
    }
}

diesel::table! {
    dede_addonarticle (aid) {
        aid -> Unsigned<Integer>,
        typeid -> Unsigned<Smallint>,
        body -> Nullable<Mediumtext>,
        #[max_length = 255]
        redirecturl -> Varchar,
        #[max_length = 30]
        templet -> Varchar,
        #[max_length = 15]
        userip -> Char,
    }
}

diesel::table! {
    use diesel::sql_types::*;
    use super::sql_types::DedeArchivesFlagSet;

    dede_archives (id) {
        id -> Unsigned<Integer>,
        typeid -> Unsigned<Smallint>,
        #[max_length = 90]
        typeid2 -> Varchar,
        sortrank -> Unsigned<Integer>,
        #[max_length = 15]
        flag -> Nullable<DedeArchivesFlagSet>,
        ismake -> Smallint,
        channel -> Smallint,
        arcrank -> Smallint,
        click -> Unsigned<Integer>,
        money -> Smallint,
        #[max_length = 255]
        title -> Nullable<Varchar>,
        #[max_length = 200]
        shorttitle -> Char,
        #[max_length = 7]
        color -> Char,
        #[max_length = 20]
        writer -> Char,
        #[max_length = 30]
        source -> Char,
        #[max_length = 100]
        litpic -> Char,
        pubdate -> Unsigned<Integer>,
        senddate -> Unsigned<Integer>,
        mid -> Unsigned<Integer>,
        #[max_length = 200]
        keywords -> Nullable<Varchar>,
        lastpost -> Unsigned<Integer>,
        scores -> Integer,
        goodpost -> Unsigned<Integer>,
        badpost -> Unsigned<Integer>,
        voteid -> Integer,
        notpost -> Unsigned<Tinyint>,
        #[max_length = 500]
        description -> Varchar,
        #[max_length = 40]
        filename -> Varchar,
        dutyadmin -> Unsigned<Integer>,
        tackid -> Integer,
        mtype -> Unsigned<Integer>,
        weight -> Integer,
    }
}

diesel::table! {
    dede_arctype (id) {
        id -> Unsigned<Smallint>,
        reid -> Unsigned<Smallint>,
        topid -> Unsigned<Smallint>,
        sortrank -> Unsigned<Smallint>,
        #[max_length = 30]
        typename -> Char,
        #[max_length = 60]
        typedir -> Char,
        isdefault -> Smallint,
        #[max_length = 15]
        defaultname -> Char,
        issend -> Smallint,
        channeltype -> Nullable<Smallint>,
        maxpage -> Smallint,
        ispart -> Smallint,
        corank -> Smallint,
        #[max_length = 50]
        tempindex -> Char,
        #[max_length = 50]
        templist -> Char,
        #[max_length = 50]
        temparticle -> Char,
        #[max_length = 50]
        namerule -> Char,
        #[max_length = 50]
        namerule2 -> Char,
        #[max_length = 20]
        modname -> Char,
        #[max_length = 150]
        description -> Char,
        #[max_length = 60]
        keywords -> Varchar,
        #[max_length = 80]
        seotitle -> Varchar,
        moresite -> Unsigned<Tinyint>,
        #[max_length = 60]
        sitepath -> Char,
        #[max_length = 50]
        siteurl -> Char,
        ishidden -> Smallint,
        cross -> Bool,
        crossid -> Nullable<Text>,
        content -> Nullable<Text>,
        smalltypes -> Nullable<Text>,
    }
}

diesel::table! {
    qa_answers (id) {
        id -> Integer,
        question_id -> Integer,
        content -> Text,
        user_id -> Integer,
        #[max_length = 50]
        user_name -> Nullable<Varchar>,
        is_accepted -> Nullable<Bool>,
        created_at -> Nullable<Datetime>,
        updated_at -> Nullable<Datetime>,
    }
}

diesel::table! {
    qa_questions (id) {
        id -> Integer,
        #[max_length = 255]
        title -> Varchar,
        content -> Nullable<Text>,
        user_id -> Integer,
        #[max_length = 50]
        user_name -> Nullable<Varchar>,
        category_id -> Nullable<Integer>,
        is_show -> Nullable<Bool>,
        created_at -> Nullable<Datetime>,
    }
}

diesel::joinable!(qa_answers -> qa_questions (question_id));

diesel::allow_tables_to_appear_in_same_query!(
    batch_batchtitle,
    cmf_portal_category,
    cmf_portal_post,
    cmf_portal_tag_post,
    coze_batch_batchtitle,
    dede_addonarticle,
    dede_archives,
    dede_arctype,
    qa_answers,
    qa_questions,
);
