-- 建表sql和初始化数据SQL(可放多个表)
 CREATE TABLE `batch_batchtitle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext,
  `is_done` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `generated_at` datetime(6) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ChatGPT生成文章的表';

CREATE TABLE `coze_batch_batchtitle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` longtext COMMENT '文章内容',
  `is_done` tinyint(1) DEFAULT 0 COMMENT '是否已生成文章：默认0已生成',
  `created_at` datetime(6) NOT NULL COMMENT '创建时间',
  `generated_at` datetime(6) DEFAULT NULL COMMENT '文章生成时间',
  `description` varchar(300) DEFAULT NULL COMMENT '文章描述',
  `is_published` tinyint(1) DEFAULT 0 COMMENT '是否已发布：默认0未发布  1为已发布',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `is_done` (`is_done`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coze生成文章的表';
