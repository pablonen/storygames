require "test_helper"

class AuthorTest < ActiveSupport::TestCase
   test "finds messages written by eero tuovinen" do
     TopicPersister.crawl_file(file_fixture("eero_tuovinen_message_topic_8867.html"))

     eero_documents = PgSearch.multisearch("eero").where(searchable_type: "Author")

     assert_not_empty eero_documents
   end
end
