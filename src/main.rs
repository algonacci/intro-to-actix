use actix_web::{get, web, App, HttpServer, Responder};
use serde::Serialize;

#[derive(Serialize)]
struct ApiResponse {
    status: Status,
    data: Option<String>,
}

#[derive(Serialize)]
struct Status {
    code: u16,
    message: String,
}

#[get("/")]
async fn hello_world() -> impl Responder {
    let response = ApiResponse {
        status: Status {
            code: 200,
            message: "Success fetching the API".to_string(),
        },
        data: None,
    };
    web::Json(response)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Retrieve the port from the environment variable or use a default
    let port = std::env::var("PORT").unwrap_or_else(|_| "8080".to_string());
    let server_address = format!("0.0.0.0:{}", port);

    HttpServer::new(|| App::new().service(hello_world))
        .bind(&server_address)?
        .run()
        .await
}
