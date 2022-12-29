require "test_helper"

class TopicTest < ActiveSupport::TestCase
  test "finds In a Wicked Age topics" do
    TopicPersister.crawl_file(file_fixture("iawa_topic_1_no_brackets_5814.html"))
    TopicPersister.crawl_file(file_fixture("iawa_topic_2_brackets_6392.html"))
    iawa_documents = PgSearch.multisearch("iawa")

    assert_not_empty iawa_documents
    assert_equal 2, iawa_documents.size
  end
end
