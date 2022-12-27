require "test_helper"

class TopicParserTest < ActiveSupport::TestCase
  test "parses topic" do
    topic, discussion_message, author, posted_at, *posts = TopicParser.parse_file(file_fixture("12.html"))

    assert_equal topic, "Mindshare: Can it be pushed or must it be pulled?"
    assert discussion_message.start_with?("Stealing"), discussion_message
    assert_equal author, "chadu"
    assert_equal posted_at.year, 2006
    assert_equal posted_at.month, 1
    assert_equal posted_at.day, 20
    assert_equal posted_at.hour, 1
    assert_equal posted_at.minute, 8
    assert_equal posts.first[:author], "Matt"
    assert_equal posts.last[:author], "chadu"
    assert_equal posts.last[:posted_at].day, 23
    assert posts.last[:message].start_with? "I'm curious"
  end
end
