require "cuba"
require "cuba/render"

Cuba.plugin(Cuba::Render)
Cuba.use Rack::Session::Cookie, secret: "foobar"

Cuba.define do
  @page = {}

  on root do
    res.write(view("home"))
  end
end