require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

require "http"

get("/") do
  url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("KEY")}"
  @raw_response = HTTP.get(url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  erb(:homepage)
end

get("/:first_symbol") do
  @symbol=params.fetch("first_symbol")
  url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("KEY").chomp}"
  @raw_response = HTTP.get(url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  erb(:stepone)

end

get("/:first_symbol/:to_currency") do
@from = params.fetch("first_symbol")
@to = params.fetch("to_currency")
@urltwo = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("KEY").chomp}&from=#{@from}&to=#{@to}&amount=1"

@raw_response =HTTP.get(@urltwo)
@string_response = @raw_response.to_s
@parsed_response = JSON.parse(@string_response)
@amount=@parsed_response.fetch("result")
erb(:steptwo)
end
