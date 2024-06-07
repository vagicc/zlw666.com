use serde::Deserialize;
// use serde_json::{Map, Value};

#[derive(Deserialize, Debug, Clone)]
pub struct KimiResponse {
    pub id: Option<String>,
    pub object: Option<String>,
    pub created: Option<i64>,
    pub model: Option<String>,
    pub choices: Option<Vec<Choices>>,
    pub usage: Option<Usage>,
    pub error:Option<Error>,
}

#[derive(Deserialize, Debug, Clone)]
pub struct Error{
    pub message:String,
    pub r#type:String,
}

#[derive(Deserialize, Debug, Clone)]
pub struct Usage {
    pub prompt_tokens: i32,
    pub completion_tokens: i32,
    pub total_tokens: i32,
}

#[derive(Deserialize, Debug, Clone)]
pub struct Choices {
    pub index: i32,
    pub message: Message,
    pub finish_reason: String,
}

#[derive(Deserialize, Debug, Clone)]
pub struct Message {
    pub role: String,
    pub content: String,
}
