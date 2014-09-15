#!/usr/bin/env ruby

require './debian_control_parser'

data=<<EOF
Foo: bar
Answer-to-Everything: 42

Ding: dong
Zingo: zongo
Multi:
 several lines
 in a paragraph
 are of course allowd
Final: field
EOF

p = DebianControlParser.paragraphs(data)
#puts p.class
p.each do |paragraph|
  puts paragraph
  puts paragraph.each
  puts "--------------"
  paragraph.each do |k,v|
    puts "Key=#{k} / Value=#{v}"
  end
end

puts "==============================="

fields = DebianControlParser.fields(data)
fields.each do |k,v|
  puts "Key=#{k} / Value=#{v}"
end
