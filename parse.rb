#!/usr/bin/env ruby

require 'nokogiri'
require 'cgi'

Dir.glob('storygames/*.html') do |file|
  page = File.read(file)
  topic = Nokogiri::HTML(page).at_css('h1').text.gsub('?','').gsub('/',' ').gsub('!', '')

  filename = File.join('by_topic', topic+'.html')
  puts filename
  File.new(filename, 'w+').write(page)
end

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
