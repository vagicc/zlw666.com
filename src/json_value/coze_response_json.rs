use serde::Deserialize;
// use serde_json::{Map, Value};

#[derive(Deserialize, Debug, Clone)]
pub struct CozeResponse {
    pub messages: Vec<Messag>,
}

#[derive(Deserialize, Debug, Clone)]
pub struct Messag {
    pub role: String, //发送消息的角色。user：用户输入内容，该类型用于构建上下文时表示该信息时用户的输入 assistant：Bot 返回的内容
    /*
    标识消息类型，主要用于区分 role=assistant 时 Bot 返回的消息。
    answer：Bot 最终返回给用户的消息内容
    function_call： Bot 对话过程中决定调用 function_call 的中间结果
    tool_response：function_call 调用工具后返回的结果
    follow_up：如果在 Bot 上配置打开了 Auto-Suggestion 开关，则会返回 flow_up 内容
     */
    pub r#type: String,  //注意关键字作为json的键时 ,
    pub content: String, //消息内容。
    /*
    消息内容的类型。
    text 文本类型，Bot 返回 type=answer 时采用 markdown 语法返回。
     */
    pub content_type: String,
}
