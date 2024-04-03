-- 建表sql和初始化数据SQL(可放多个表)
CREATE TABLE `cmf_portal_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `son_id` int(11) NOT NULL DEFAULT 0 COMMENT '四级分类id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
  `list_order` float unsigned NOT NULL DEFAULT 10000 COMMENT '排序',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '查看数',
  `post_favorites` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '收藏数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '评论数',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '发布时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '删除时间',
  `post_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) COLLATE utf8_bin DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) COLLATE utf8_bin DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) COLLATE utf8_bin DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext COLLATE utf8_bin DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` text COLLATE utf8_bin DEFAULT NULL COMMENT '处理过的文章内容',
  `more` text COLLATE utf8_bin DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='portal应用 文章表-打官司';

CREATE TABLE `cmf_portal_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类父id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级顶级分类ID',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '目录',
  `description` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) COLLATE utf8_bin DEFAULT '',
  `seo_keywords` varchar(255) COLLATE utf8_bin DEFAULT '',
  `seo_description` varchar(255) COLLATE utf8_bin DEFAULT '',
  `list_tpl` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '分类文章页模板',
  `more` text COLLATE utf8_bin DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='打官司文章分类表';

CREATE TABLE `cmf_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签文章对应表';
 