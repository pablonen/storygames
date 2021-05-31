#!/usr/bin/env ruby

require 'nokogiri'

def parse_by_topics
  Dir.glob('storygames/*.html') do |file|
    page = File.read(file).gsub('\n','')
    doc = Nokogiri::HTML(page)

    doc.xpath('//script').remove 

    topic = doc.at_css('h1').text.gsub('?','').gsub('/',' ').gsub('!', '')

    css_link = Nokogiri::XML::Node.new('link', doc)
    css_link['href'] = '/sg.css'
    css_link['rel'] = 'stylesheet'
    head = Nokogiri::XML::Node.new('head',doc)
    head.add_child(css_link)
    doc.at_css('html').add_child(head)

    meta = Nokogiri::XML::Node.new('meta', doc)
    meta['charset'] = "utf-8"

    doc.at_css('head').add_child(meta)
    filename = File.join('by_topic', topic+'.html')
    puts filename
    File.new(filename, 'w+').write(doc.to_html)
  end
end

def create_index
  # create an index file
  topics = Dir.glob('by_topic/*.html') 

  index = Nokogiri::HTML::DocumentFragment.parse <<-EOHTML
  <body>
    <p>Archive of the website once at story-games.com/forums</p>
    <ol id="topics">

    </ol>
  </body>
  EOHTML
  topiclist = index.at_css('#topics')

  topics.each do |topic|
    li_elem = Nokogiri::XML::Node.new('li', index)
    a_elem = Nokogiri::XML::Node.new('a', index)
    a_elem['href'] = topic
    a_elem.content = File.basename(topic)

    li_elem.add_child(a_elem)

    topiclist.add_child(li_elem)
  end

  File.write('index.html', index.to_html)
end

