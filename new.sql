-- 问答表
CREATE TABLE `qa_questions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) NOT NULL UNIQUE COMMENT '问题标题',
  `content` TEXT DEFAULT NULL COMMENT '问题详细描述',
  `user_id` INT NOT NULL DEFAULT 0 COMMENT '用户ID',
  `category_id` INT DEFAULT 0 COMMENT '问题分类ID',
  `is_show` tinyint(1) DEFAULT 0 COMMENT '是否展示：默认0不展示  1为展示',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问答表-问题';

CREATE TABLE `qa_answers` (
  `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '答案的主键ID',
  `question_id` INT NOT NULL COMMENT '关联问题的外键ID',
  `content` TEXT NOT NULL COMMENT '答案的内容',
  `user_id` INT NOT NULL COMMENT '回答用户ID',
  `user_name` VARCHAR(50) DEFAULT NULL COMMENT '回答用户名',
  `is_accepted` TINYINT(1) DEFAULT 0 COMMENT '最佳答案标志:1为是，0为否',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '答案创建的时间',
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '答案最后更新的时间',
  FOREIGN KEY (`question_id`) REFERENCES `qa_questions`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问答表-答案';


-- dededb（DedeCMS）
CREATE TABLE `dede_archives` (
  `id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章唯一标识ID',
  `typeid` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '栏目ID',
  `typeid2` varchar(90) NOT NULL DEFAULT '0' COMMENT '第二栏目ID，用于文章关联多个栏目',
  `sortrank` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章排序',
  `flag` set('c','h','p','f','s','j','a','b') DEFAULT NULL COMMENT '文章属性标记，如推荐(c)、热门(h)等',
  `ismake` smallint(6) NOT NULL DEFAULT 0 COMMENT '是否生成HTML文件',
  `channel` smallint(6) NOT NULL DEFAULT 1 COMMENT '文章所属频道',
  `arcrank` smallint(6) NOT NULL DEFAULT 0 COMMENT '浏览权限等级',
  `click` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击次数',
  `money` smallint(6) NOT NULL DEFAULT 0 COMMENT '阅读文章所需支付的费用',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `shorttitle` char(200) NOT NULL DEFAULT '' COMMENT '简短标题，用于SEO优化',
  `color` char(7) NOT NULL DEFAULT '' COMMENT '标题颜色',
  `writer` char(20) NOT NULL DEFAULT '' COMMENT '文章作者',
  `source` char(30) NOT NULL DEFAULT '' COMMENT '文章来源',
  `litpic` char(100) NOT NULL DEFAULT '' COMMENT '文章缩略图',
  `pubdate` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章发布时间',
  `senddate` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章创建时间',
  `mid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布用户ID',
  `keywords` varchar(200) DEFAULT NULL COMMENT '文章关键词，用于SEO优化',
  `lastpost` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后回复时间',
  `scores` mediumint(9) NOT NULL DEFAULT 0 COMMENT '文章评分',
  `goodpost` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '好评次数',
  `badpost` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '差评次数',
  `voteid` mediumint(9) NOT NULL COMMENT '投票ID',
  `notpost` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '不允许评论',
  `description` varchar(500) NOT NULL DEFAULT '' COMMENT '文章摘要或描述',
  `filename` varchar(40) NOT NULL DEFAULT '' COMMENT '生成静态页面时的文件名',
  `dutyadmin` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '负责审核的管理员ID',
  `tackid` int(11) NOT NULL DEFAULT 0 COMMENT '跟踪ID，可能用于文章的跟踪或统计',
  `mtype` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的媒体类型',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT '权重，用于文章排序'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章的基本信息和元数据';

CREATE TABLE `dede_addonarticle` (
  `aid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章ID，与dede_archives表的主键id相对应',
  `typeid` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章分类ID',
  `body` mediumtext DEFAULT NULL COMMENT '文章正文内容',
  `redirecturl` varchar(255) NOT NULL DEFAULT '' COMMENT '文章跳转链接地址',
  `templet` varchar(30) NOT NULL DEFAULT '' COMMENT '文章内容页使用的模板名称',
  `userip` char(15) NOT NULL DEFAULT '' COMMENT '发布文章时用户IP地址'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章附加表，存储文章的详细内容';

CREATE TABLE `dede_arctype` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT '栏目ID',
  `reid` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联上级ID',
  `topid` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '顶级栏目ID',
  `sortrank` smallint(5) UNSIGNED NOT NULL DEFAULT 50 COMMENT '排序',
  `typename` char(30) NOT NULL DEFAULT '' COMMENT '栏目名称',
  `typedir` char(60) NOT NULL DEFAULT '' COMMENT '栏目目录',
  `isdefault` smallint(6) NOT NULL DEFAULT 0 COMMENT '是否为默认',
  `defaultname` char(15) NOT NULL DEFAULT 'index.html' COMMENT '默认页面文件名',
  `issend` smallint(6) NOT NULL DEFAULT 0 COMMENT '是否推送',
  `channeltype` smallint(6) DEFAULT 1 COMMENT '频道类型',
  `maxpage` smallint(6) NOT NULL DEFAULT -1 COMMENT '分页数量',
  `ispart` smallint(6) NOT NULL DEFAULT 0 COMMENT '是否是分区',
  `corank` smallint(6) NOT NULL DEFAULT 0 COMMENT '栏目权重',
  `tempindex` char(50) NOT NULL DEFAULT '' COMMENT '首页模板',
  `templist` char(50) NOT NULL DEFAULT '' COMMENT '列表模板',
  `temparticle` char(50) NOT NULL DEFAULT '' COMMENT '文章模板',
  `namerule` char(50) NOT NULL DEFAULT '' COMMENT '命名规则',
  `namerule2` char(50) NOT NULL DEFAULT '' COMMENT '第二命名规则',
  `modname` char(20) NOT NULL DEFAULT '' COMMENT '模块名称',
  `description` char(150) NOT NULL DEFAULT '' COMMENT '栏目描述',
  `keywords` varchar(60) NOT NULL DEFAULT '' COMMENT '关键词',
  `seotitle` varchar(80) NOT NULL DEFAULT '' COMMENT 'SEO标题',
  `moresite` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '多站点内容',
  `sitepath` char(60) NOT NULL DEFAULT '' COMMENT '站点路径',
  `siteurl` char(50) NOT NULL DEFAULT '' COMMENT '站点URL',
  `ishidden` smallint(6) NOT NULL DEFAULT 0 COMMENT '是否隐藏',
  `cross` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否跨栏目发布',
  `crossid` text DEFAULT NULL COMMENT '跨栏目ID',
  `content` text DEFAULT NULL COMMENT '栏目内容',
  `smalltypes` text DEFAULT NULL COMMENT '小分类'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='地区律师表';