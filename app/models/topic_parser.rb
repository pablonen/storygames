class TopicParser
  DISCUSSION_SELECTOR = ".Discussion"
  COMMENT_SELECTOR = ".ItemComment"
  TOPIC_SELECTOR = "h1"

  def self.parse_file(filename)
    document = Nokogiri::HTML5(File.read(filename))
    topic = parse_discussion_topic(document.at_css(TOPIC_SELECTOR))
    discussion = document.at_css(DISCUSSION_SELECTOR)

    discussion_message = parse_discussion_message(discussion)
    discussion_author = parse_discussion_author(discussion)
    discussion_posted_at = parse_discussion_message_posted_at(discussion)

    posts = parse_posts(document)

    [topic, discussion_message, discussion_author, discussion_posted_at, *posts]
  end

  def self.parse_discussion_message(discussion_element)
    discussion_element.css('br').remove
    discussion_element.at_css('.Message').text.strip
  end

  def self.parse_discussion_author(discussion_element)
    discussion_element.at_css('a.Username').text
  end

  def self.parse_discussion_topic(discussion_element)
    discussion_element.text
  end

  def self.parse_discussion_message_posted_at(discussion_element)
    time = discussion_element.at_css('time').attr('datetime')
    DateTime.parse(time)
  end

  def self.parse_posts(document)
    posts = document.css(COMMENT_SELECTOR).map do |post_data|
      comment = {}
      comment[:author] = parse_discussion_author(post_data)
      comment[:posted_at] = parse_discussion_message_posted_at(post_data)
      comment[:message] = parse_discussion_message(post_data)
      comment
    end
    posts
  end
end
