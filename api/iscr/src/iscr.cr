require "kemal"

get "/" do
    "Hello"
end

macro user_view(fn)
    render "src/views/usersub.ecr", "src/views/layouts/user.ecr"
end

before_get "/user" do |env|
    puts "Setting resp type"
    env.response.content_type = "application/json"
end

get "/foo" do |env|
    puts env.response.headers["Content-Type"] # => "application/json"
    {"name": "Kemal"}.to_json
end

before_all "/foo" do |env|
    puts "Setting response content type"
    env.response.content_type = "application/json"
end

get "/users/:username" do
    user_view "subview"
end

get "/:name" do |env|
    name = env.params.url["name"]
    render "src/views/hello.ecr"
end

post "/" do
  "Hello World"
end

delete "/" do
    "Test"
end

Kemal.run
