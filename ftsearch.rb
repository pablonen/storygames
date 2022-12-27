#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'sqlite3'
require 'nokogiri'

require 'sg_db'

def populate_topics
  topics = Dir.glob('*.html', base: 'by_topic').map { |topic| topic.gsub('.html', '')}
  SGDB.insert_topics(topics)
end

def populate_posts
  db = SGDB.get_db
  Dir.glob('*.html', base: 'by_topic') do |topic_file|
    topic = topic_file.gsub('.html', '')
    topic_id = SGDB.find_topic(topic)

    page = File.read(File.join("by_topic",topic_file)).gsub('\n', '')
    doc = Nokogiri::HTML(page)

    posts = doc.css('.Item').each do |post|
      text = post.text.strip
      SGDB.insert_post(text, topic_id, db)
    end
  end
end

SGDB.create_index
populate_topics
populate_posts
