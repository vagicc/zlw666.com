数据库迁移使用说明

# diesel是Rust的ORM(对象关系映射器)和查询构建器
# diesel为PostgreSQL、Mysql及SQLite提供了开箱即用的支持

diesel数据库迁移使用说明
diesel是Rust的ORM(对象关系映射器)和查询构建器
diesel为PostgreSQL、Mysql及SQLite提供了开箱即用的支持
英文在线文档：https://lib.rs/crates/diesel_cli
diesel-cli命令行工具（创建、迁移）：

安装diesel-cli工具(postgres)：cargo install diesel_cli --no-default-features --features postgres
PostgreSQL错误解决的：sudo apt-get install libpq-dev

安装diesel-cli工具(mysql)：cargo install diesel_cli --no-default-features --features mysql
mysql错误解决：sudo apt-get install libmysqlclient-dev

cargo run出错: collect2: fatal error: ld terminated with signal 9 [killed]
error: linking with `cc` failed: exit status: 1
  |
  = note: "cc" "-m64" "/tmp/rustcFes1DZ/symbols.o" "/var/www/manage/target/debug/deps/manage-682f74564e79a272.10dzx97ru7szmvm.rcgu.o" "/var/www/manage/target/debug/deps/manage-682f74564e79a272.114hpvqg5miobw6d.rcgu.o" "/var/www/manage/target/
  = note: collect2: fatal error: ld terminated with signal 9 [Killed]
          compilation terminated.
          

warning: `manage` (bin "manage") generated 63 warnings
error: could not compile `manage` due to previous error; 63 warnings emitted
 
原因:基本都是在ld的时候，内存不足的错误
解决:     (https://zhuanlan.zhihu.com/p/36769900)
    1.为虚拟机至少预留100G硬盘存储
    2.将ld链接器，修改为gold链接器: 
                                cd /usr/bin    
                                rm ld
                                cp -d gold ld

在cargo项目根目录下添加.env文件,加下如下条进行连接配置：
postgres数据库：
DATABASE_URL=postgres://postgres:llxxs@127.0.0.1:5432/linksnap
mysql数据库：
DATABASE_URL=mysql://[user[:password]@]host/database_name

在Cargo.toml中添加依赖项：
diesel = { version="2.1.5",features=["extras","postgres","r2d2"] }
dotenv = "0.15.0"

运行"diesel setup"命令生成"migrations"目录与"diesel.toml"文件并且会创建数据库，
并且在数据库里生成一张“__diesel_schema_migrations”的表，我们不用理会这张表，它主要用来记录diesel的操作的迁表操作：
elapse@elapse-PC:/luck/Language/Rust/warp-wiki$ diesel setup
Creating migrations directory at: /luck/Language/Rust/warp-wiki/migrations
Creating database: warpwiki
elapse@elapse-PC:/luck/Language/Rust/warp-wiki$

创建admins表迁移，运行创建表迁移命令（diesel migration generate 表名）：
elapse@elapse-PC:/luck/Language/Rust/warp-wiki$ diesel migration generate admins
Creating migrations/2021-05-13-071702_admins/up.sql
Creating migrations/2021-05-13-071702_admins/down.sql
elapse@elapse-PC:/luck/Language/Rust/warp-wiki$ 
命令运行后会生成两个空的迁移文件up.sql和down.sql,
迁移文件只是普通的SQL,接着在up.sql上面添加CREATE TABLE,同时在down.sql添加相应的DROP TABLE

执行表迁移命令（diesel migration run）：
elapse@elapse-PC:/luck/Language/Rust/warp-wiki$ diesel migration run
Running migration 2021-05-13-071702_admins
elapse@elapse-PC:/luck/Language/Rust/warp-wiki$
命令执行完后，会在数据库中生成表，同时在项目中生成src/schema.rs文件。 然后在“main.rs”里加入如下行
mod schema;

#[macro_use]
extern crate diesel;

以便后面的代码能使用，mod是加入schema模块，后面两行是展开diesel宏.这样子，在代码里就可以使用数据库了。
再在src目录下新建“models”文件夹，并在里面新增mod.rs文件，“main.rs”再加入“mod models;”。
以后就把操作数据库的代码放在该文件夹里。

注意使用MYSQL与postgres时，在Cargo.toml中添加依赖项分别不同，请注意对比如下：
# 这条是用postgres数据库
diesel = { version="2.1.5",features=["extras","postgres","r2d2","with-deprecated","numeric","chrono"] }
# 这条是用mysql数据库
diesel = { version="2.1.5",features=["extras","mysql","r2d2","with-deprecated","numeric","chrono"] }


迁移时执行：diesel setup

同时会在src/schema.rs中添加相应的(table!宏)表结构.


运行时出错：error while loading shared libraries: libmariadb.so.3: cannot open shared object file: No such file or directory
解决： sudo ln -s /usr/local/mysql/lib/libmariadb.so.3 /usr/lib/libmariadb.so.3

-------------------------“重做”应用的迁移--------
应用迁移：diesel migration run  
恢复迁移：diesel migration revert
“重做”应用的迁移：
          diesel migration revert
          diesel migration run
重做（等同于上面两条）：diesel migration redo
上面命令，只能运行、还原或重做一次迁移
重做所有的迁移：diesel database reset 
diesel database reset 这条命令执行后会删除数据库，然后按照迁移文件创建数据库和表等。
-----------------------------------------------

不会使用时，可以查看diesel源码里的示例：
查询条件看：src/expression_methods/global_expression_methods.rs
事务查看：
    src/connection/mod.rs  事务写在一个函数的示例
    src/doctest_setup.rs
    src/connection/transaction_manager.rs  事务
    src/pg/transaction.rs   pg数据库特有的事务