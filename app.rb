require "cuba"
require "cuba/render"
require "ohm"

require_relative "models/topic"
require_relative "models/comment"



Cuba.plugin(Cuba::Render)
Cuba.use Rack::Session::Cookie, secret: "foobar"

Ohm.redis = Redic.new("redis://127.0.0.1:6379")

Cuba.define do
  @page = {}

  on get, "topics/:id" do |id|
    res.write(view("topics", topics: Topic[id]))
  end

  on post, "topics/:id" do |id|
    topics = Topic[id]
    comment = Comment.create(
      body: req.POST["body"],
      topic: topics
      )
    res.redirect("/topics/#{topics.id}")
  end
  
  on get, "preguntar" do
    res.write(view("new_topic"))
  end

  on post, "preguntar" do
    topic = Topic.create(
      title: req.POST["title"],
      body: req.POST["body"]
      )
    res.redirect("/topics/#{topic.id}")
  end
  
  
  on root do
    res.write(view("home", topics: Topic.all))
  end
end