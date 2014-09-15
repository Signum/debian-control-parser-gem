#!/usr/bin/env ruby

require './debian_control_parser'

data=<<EOF
Foo: bar
Answer-to-Everything: 42
EOF

p = DebianControlParser.new(data)
puts p.class
p.fields.each do |field,value|
    puts field
    puts value
    puts "--------------"
end

puts p.fields.class
p.fields do |field,value|
    puts field
    puts value
    puts "--------------"
end

