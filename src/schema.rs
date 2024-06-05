// @generated automatically by Diesel CLI.

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

diesel::allow_tables_to_appear_in_same_query!(
    batch_batchtitle,
    cmf_portal_category,
    cmf_portal_post,
    cmf_portal_tag_post,
    coze_batch_batchtitle,
);
