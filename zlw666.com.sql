-- MySQL dump 10.19  Distrib 10.3.30-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: zlw666
-- ------------------------------------------------------
-- Server version	10.3.30-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `zlw666`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `zlw666` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `zlw666`;

--
-- Table structure for table `cmf_admin_api`
--

DROP TABLE IF EXISTS `cmf_admin_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_admin_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父级ID',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '类型;1:纯API;2:父级节点',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '访问地址;1.界面路由,如:/users;2.API的路由,如:GET|admin/users/:id;',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `tags` varchar(100) NOT NULL DEFAULT '' COMMENT 'API标签列表，用于分组，以英文逗号分隔',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台API列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_admin_menu`
--

DROP TABLE IF EXISTS `cmf_admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `app` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parent_id` (`parent_id`),
  KEY `controller` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=3027 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='后台菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_arctype`
--

DROP TABLE IF EXISTS `cmf_arctype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_arctype` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `reid` smallint(5) unsigned NOT NULL DEFAULT 0,
  `topid` smallint(5) unsigned NOT NULL DEFAULT 0,
  `sortrank` smallint(5) unsigned NOT NULL DEFAULT 50,
  `typename` char(30) NOT NULL DEFAULT '',
  `level` char(30) NOT NULL DEFAULT '',
  `typedir` char(60) NOT NULL DEFAULT '',
  `isdefault` smallint(6) NOT NULL DEFAULT 0,
  `defaultname` char(15) NOT NULL DEFAULT 'index.html',
  `issend` smallint(6) NOT NULL DEFAULT 0,
  `channeltype` smallint(6) DEFAULT 1,
  `maxpage` smallint(6) NOT NULL DEFAULT -1,
  `ispart` smallint(6) NOT NULL DEFAULT 0,
  `corank` smallint(6) NOT NULL DEFAULT 0,
  `tempindex` char(50) NOT NULL DEFAULT '',
  `templist` char(50) NOT NULL DEFAULT '',
  `temparticle` char(50) NOT NULL DEFAULT '',
  `namerule` char(50) NOT NULL DEFAULT '',
  `namerule2` char(50) NOT NULL DEFAULT '',
  `modname` char(20) NOT NULL DEFAULT '',
  `description` char(150) NOT NULL DEFAULT '',
  `keywords` varchar(60) NOT NULL DEFAULT '',
  `seotitle` varchar(80) NOT NULL DEFAULT '',
  `moresite` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sitepath` char(60) NOT NULL DEFAULT '',
  `siteurl` char(50) NOT NULL DEFAULT '',
  `ishidden` smallint(6) NOT NULL DEFAULT 0,
  `cross` tinyint(1) NOT NULL DEFAULT 0,
  `crossid` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `smalltypes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reid` (`reid`,`isdefault`,`channeltype`,`ispart`,`corank`,`topid`,`ishidden`),
  KEY `sortrank` (`sortrank`)
) ENGINE=MyISAM AUTO_INCREMENT=7136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_area`
--

DROP TABLE IF EXISTS `cmf_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '上级',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '行政区名称',
  `level` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '行政区级别',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=713207 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='地区';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_asset`
--

DROP TABLE IF EXISTS `cmf_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COLLATE utf8_bin DEFAULT NULL COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_auth_access`
--

DROP TABLE IF EXISTS `cmf_auth_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_auth_rule`
--

DROP TABLE IF EXISTS `cmf_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '规则所属app',
  `type` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_comment`
--

DROP TABLE IF EXISTS `cmf_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '评论内容 id',
  `like_count` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '点赞数',
  `dislike_count` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '不喜欢数',
  `floor` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '楼层数',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text DEFAULT NULL COMMENT '原文地址',
  `content` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '评论内容',
  `more` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `object_id` (`object_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_hook`
--

DROP TABLE IF EXISTS `cmf_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统钩子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_hook_plugin`
--

DROP TABLE IF EXISTS `cmf_hook_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统钩子插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_link`
--

DROP TABLE IF EXISTS `cmf_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT 0 COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='友情链接表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_migration`
--

DROP TABLE IF EXISTS `cmf_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_migration` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_nav`
--

DROP TABLE IF EXISTS `cmf_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='前台导航位置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_nav_menu`
--

DROP TABLE IF EXISTS `cmf_nav_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='前台导航菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_option`
--

DROP TABLE IF EXISTS `cmf_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='全站配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_plugin`
--

DROP TABLE IF EXISTS `cmf_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '插件安装时间',
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '插件描述',
  `config` text COLLATE utf8_bin DEFAULT NULL COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_case`
--

DROP TABLE IF EXISTS `cmf_portal_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_case` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10224 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='案例列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category`
--

DROP TABLE IF EXISTS `cmf_portal_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=612 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='portal应用 文章分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_case`
--

DROP TABLE IF EXISTS `cmf_portal_category_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_case` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned DEFAULT 0 COMMENT '一级分类id',
  `post_count` bigint(20) unsigned DEFAULT 0 COMMENT '分类案例数',
  `status` tinyint(3) unsigned DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned DEFAULT 0 COMMENT '删除时间',
  `list_order` float DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) DEFAULT '' COMMENT '目录',
  `description` varchar(255) DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `list_tpl` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT '' COMMENT '分类文章页模板',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1639 DEFAULT CHARSET=utf8 COMMENT='案例分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_case_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_case_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_case_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `term_taxonomy_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='案例分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_download`
--

DROP TABLE IF EXISTS `cmf_portal_category_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_download` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned DEFAULT 0 COMMENT '一级分类id',
  `post_count` bigint(20) unsigned DEFAULT 0 COMMENT '分类案例数',
  `status` tinyint(3) unsigned DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned DEFAULT 0 COMMENT '删除时间',
  `list_order` float DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) DEFAULT '' COMMENT '目录',
  `description` varchar(255) DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `list_tpl` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT '' COMMENT '分类文章页模板',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1614 DEFAULT CHARSET=utf8 COMMENT='下载分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_download_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_download_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_download_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `term_taxonomy_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 COMMENT='下载分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_falvjiejuefangan`
--

DROP TABLE IF EXISTS `cmf_portal_category_falvjiejuefangan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_falvjiejuefangan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned DEFAULT 386 COMMENT '一级分类id',
  `post_count` bigint(20) unsigned DEFAULT 0 COMMENT '分类案例数',
  `status` tinyint(3) unsigned DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned DEFAULT 0 COMMENT '删除时间',
  `list_order` float DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) DEFAULT '' COMMENT '目录',
  `description` varchar(255) DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `list_tpl` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT '' COMMENT '分类文章页模板',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1609 DEFAULT CHARSET=utf8 COMMENT='法律解决方案分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_falvjiejuefangan_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_falvjiejuefangan_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_falvjiejuefangan_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `term_taxonomy_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='法律解决方案分类对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_falvzhishi`
--

DROP TABLE IF EXISTS `cmf_portal_category_falvzhishi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_falvzhishi` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned DEFAULT 0 COMMENT '一级分类id',
  `post_count` bigint(20) unsigned DEFAULT 0 COMMENT '分类案例数',
  `status` tinyint(3) unsigned DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned DEFAULT 0 COMMENT '删除时间',
  `list_order` float DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) DEFAULT '' COMMENT '目录',
  `description` varchar(255) DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `list_tpl` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT '' COMMENT '分类文章页模板',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7132 DEFAULT CHARSET=utf8 COMMENT='法律知识分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_falvzhishi_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_falvzhishi_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_falvzhishi_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `term_taxonomy_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6844 DEFAULT CHARSET=utf8 COMMENT='法律知识分类对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_falvzixun`
--

DROP TABLE IF EXISTS `cmf_portal_category_falvzixun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_falvzixun` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned DEFAULT 0 COMMENT '一级分类id',
  `post_count` bigint(20) unsigned DEFAULT 0 COMMENT '分类案例数',
  `status` tinyint(3) unsigned DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned DEFAULT 0 COMMENT '删除时间',
  `list_order` float DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) DEFAULT '' COMMENT '目录',
  `description` varchar(255) DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `list_tpl` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT '' COMMENT '分类文章页模板',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57841 DEFAULT CHARSET=utf8 COMMENT='法律咨询分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_falvzixun_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_falvzixun_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_falvzixun_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `term_taxonomy_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2978 DEFAULT CHARSET=utf8 COMMENT='法律咨询分类对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_lvshizixun`
--

DROP TABLE IF EXISTS `cmf_portal_category_lvshizixun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_lvshizixun` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned DEFAULT 112 COMMENT '一级分类id',
  `post_count` bigint(20) unsigned DEFAULT 0 COMMENT '分类案例数',
  `status` tinyint(3) unsigned DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned DEFAULT 0 COMMENT '删除时间',
  `list_order` float DEFAULT 10000 COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类名称',
  `typedir` varchar(200) DEFAULT '' COMMENT '目录',
  `description` varchar(255) DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `list_tpl` varchar(50) DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT '' COMMENT '分类文章页模板',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5683 DEFAULT CHARSET=utf8 COMMENT='律师咨询分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_lvshizixun_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_lvshizixun_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_lvshizixun_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `term_taxonomy_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=477 DEFAULT CHARSET=utf8 COMMENT='律师咨询分类对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_category_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章id',
  `son_id` int(11) NOT NULL DEFAULT 0 COMMENT '四级分类id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_download`
--

DROP TABLE IF EXISTS `cmf_portal_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_download` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5022 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='下载列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_falvjiejuefangan`
--

DROP TABLE IF EXISTS `cmf_portal_falvjiejuefangan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_falvjiejuefangan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10222 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='法律解决方案列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_falvzhishi`
--

DROP TABLE IF EXISTS `cmf_portal_falvzhishi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_falvzhishi` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10265 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='法律知识列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_falvzixun`
--

DROP TABLE IF EXISTS `cmf_portal_falvzixun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_falvzixun` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10582 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='法律咨询列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_lvshizixun`
--

DROP TABLE IF EXISTS `cmf_portal_lvshizixun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_lvshizixun` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='律师咨询列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_lvshizixun_bak`
--

DROP TABLE IF EXISTS `cmf_portal_lvshizixun_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_lvshizixun_bak` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '三级分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '二级分类id',
  `top_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '一级分类id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:已发布;0:未发布;',
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
  `post_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `short_title` varchar(100) NOT NULL DEFAULT '' COMMENT '短标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` mediumtext DEFAULT NULL COMMENT '文章内容',
  `post_content_filtered` mediumtext DEFAULT NULL COMMENT '处理过的文章内容',
  `more` mediumtext DEFAULT NULL COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9999 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='律师咨询列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_post`
--

DROP TABLE IF EXISTS `cmf_portal_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10306 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='portal应用 文章表-打官司';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_tag`
--

DROP TABLE IF EXISTS `cmf_portal_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='portal应用 文章标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_portal_tag_post`
--

DROP TABLE IF EXISTS `cmf_portal_tag_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_recycle_bin`
--

DROP TABLE IF EXISTS `cmf_recycle_bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT 0 COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT 0 COMMENT '创建时间',
  `table_name` varchar(60) COLLATE utf8_bin DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT=' 回收站';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_region`
--

DROP TABLE IF EXISTS `cmf_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_region` (
  `region_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `region_name` varchar(120) NOT NULL DEFAULT '',
  `region_type` tinyint(1) NOT NULL DEFAULT 2,
  `agency_id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `ispass` tinyint(1) DEFAULT 0 COMMENT '1 不显示 0 显示',
  PRIMARY KEY (`region_id`),
  UNIQUE KEY `region_id` (`region_id`),
  KEY `parent_id` (`parent_id`),
  KEY `region_type` (`region_type`),
  KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3644 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_role`
--

DROP TABLE IF EXISTS `cmf_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT 0 COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `type` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'admin' COMMENT '角色类型',
  `remark` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_role_user`
--

DROP TABLE IF EXISTS `cmf_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_route`
--

DROP TABLE IF EXISTS `cmf_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='url路由表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_slide`
--

DROP TABLE IF EXISTS `cmf_slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='幻灯片表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_slide_item`
--

DROP TABLE IF EXISTS `cmf_slide_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT 0 COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `title` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 DEFAULT NULL COMMENT '幻灯片内容',
  `more` text COLLATE utf8_bin DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `slide_id` (`slide_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='幻灯片子项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_theme`
--

DROP TABLE IF EXISTS `cmf_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_theme_file`
--

DROP TABLE IF EXISTS `cmf_theme_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT 10000 COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text DEFAULT NULL COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text DEFAULT NULL COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text DEFAULT NULL COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_third_party_user`
--

DROP TABLE IF EXISTS `cmf_third_party_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '第三方唯一码',
  `app_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COLLATE utf8_bin DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='第三方用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user`
--

DROP TABLE IF EXISTS `cmf_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(4) NOT NULL DEFAULT 0 COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT 0 COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT 0 COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `more` text COLLATE utf8_bin DEFAULT NULL COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_action`
--

DROP TABLE IF EXISTS `cmf_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT 0 COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT 0 COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT 0 COMMENT '奖励次数',
  `cycle_type` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '周期时间值',
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COLLATE utf8_bin DEFAULT NULL COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户操作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_action_log`
--

DROP TABLE IF EXISTS `cmf_user_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '最后访问时间',
  `object` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='访问记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_balance_log`
--

DROP TABLE IF EXISTS `cmf_user_balance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_balance_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '更改后余额',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户余额变更日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_favorite`
--

DROP TABLE IF EXISTS `cmf_user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '用户 id',
  `title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `thumbnail` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '缩略图',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '收藏内容的原文地址，JSON格式',
  `description` text CHARACTER SET utf8 DEFAULT NULL COMMENT '收藏内容的描述',
  `table_name` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned DEFAULT 0 COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned DEFAULT 0 COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_like`
--

DROP TABLE IF EXISTS `cmf_user_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_like` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '用户 id',
  `object_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '内容原来的主键id',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '内容以前所在表,不带前缀',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '内容的原文地址，不带域名',
  `title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '内容的标题',
  `thumbnail` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '缩略图',
  `description` text COLLATE utf8_bin DEFAULT NULL COMMENT '内容的描述',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户点赞表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_login_attempt`
--

DROP TABLE IF EXISTS `cmf_user_login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '锁定时间',
  `ip` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_score_log`
--

DROP TABLE IF EXISTS `cmf_user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `action` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT 0 COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT 0 COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户操作积分等奖励日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_user_token`
--

DROP TABLE IF EXISTS `cmf_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建时间',
  `token` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户客户端登录 token 表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmf_verification_code`
--

DROP TABLE IF EXISTS `cmf_verification_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='手机邮箱数字验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-02 10:05:03
