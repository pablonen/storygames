class TopicPersister
  def self.crawl_file(filename)
    topic, topic_message, topic_author, topic_posted_at, *posts = TopicParser.parse_file(filename)

    author = Author.create( name: topic_author )
    topic = Topic.create( author: author, filename: filename, topic: topic )

    posts.each do |post|
      post_author = Author.find_or_create_by( name: post[:author] )
      Post.find_or_create_by( message: post[:message], author: post_author , topic: topic, posted_at: post[:posted_at] )
    end

    topic 
  end
end
