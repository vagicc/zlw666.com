-- Your SQL goes here
CREATE TABLE `qa_questions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) NOT NULL UNIQUE COMMENT '问题标题',
  `content` TEXT DEFAULT NULL COMMENT '问题详细描述',
  `user_id` INT NOT NULL DEFAULT 0 COMMENT '用户ID',
  `user_name` VARCHAR(50) DEFAULT NULL COMMENT '提问用户名',
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
 

