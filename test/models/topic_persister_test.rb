require "test_helper"

class TopicPersisterTest < ActiveSupport::TestCase
  test "persists topic" do
    t = TopicPersister.crawl_file(file_fixture("12.html"))
    assert_equal t.author.name, "chadu"
    assert t.topic.start_with? "Mindshare:"
    assert_equal t.posts.size, 12
    assert_equal t.posts.last.author.name, "chadu"
    assert t.posts.last.message.start_with? "I'm curious"
    assert_equal t.posts.last.topic, t
    assert_equal t.posts.pluck(:author_id).uniq.size, 7
  end
end
