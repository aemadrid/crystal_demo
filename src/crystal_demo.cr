require "http/server"
require "json"

Signal::INT.trap { puts "Caught Ctrl+C..."; exit }
Signal::TERM.trap { puts "Caught kill..."; exit }

# mods = [
#   HTTP::ErrorHandler.new,
#   HTTP::LogHandler.new,
#   HTTP::CompressHandler.new,
# ]
content_type = "application/json"
hsh = {
  "version" => 3,
  "status" => "ok",
  "message" => "Hello World!",
  "language" => "cr",
  "env" => {
    "pod_name" => ENV.fetch("POD_NAME", "missing"),
  }
}

json = hsh.to_json

# server = HTTP::Server.new(mods) do |context|
server = HTTP::Server.new do |context|
  context.response.content_type = content_type
  context.response.print json
end
address = server.bind_tcp "0.0.0.0", 8080

puts "Listening on http://#{address}"
server.listen
