use crate::common::get_env;

// 每个文件要用mod引入才能使用
mod common;
mod filters;
mod format_logger;
mod handlers;
mod routes;
mod template;

#[tokio::main]
async fn main() {
    // env_logger::init();
    let log_level = crate::format_logger::get_log_level();
    // 自定义日志输出格式
    env_logger::Builder::new()
        .format(crate::format_logger::formatlog)
        .filter(None, log_level)
        .target(env_logger::Target::Stdout) //添加这行可以重定向日志
        .init();

    log::info!("info: 日志样式");
    log::debug!("debug: 高度测试");
    log::warn!("warn: o_O");
    log::error!("error: much error");

    //取得https证书等
    let cert_path = get_env("cert_path");
    let key_path = get_env("key_path");
    let ip_addr = get_env("ip_address");
    println!("这是用rust开始写www.gust.cn网站!");
    println!("监听IP： {}", ip_addr);
    let socket_addr: std::net::SocketAddr = ip_addr.as_str().parse().unwrap();

    let routes = filters::all_routes();

    warp::serve(routes)
        .tls()
        .cert_path(cert_path)
        .key_path(key_path)
        // .run(([127, 0, 0, 1], 3030))
        .run(socket_addr)
        .await;
}
