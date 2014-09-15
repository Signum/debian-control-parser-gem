debian-control-parser-gem
=========================

Parses Debian control files

Installation
------------
	gem install debian-control-parser

Sample application to parse control files with multiple paragraphs
------------------------------------------------------------------
```ruby
require 'debian_control_parser'

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

parser = DebianControlParser.new(data)
parser.paragraphs do |paragraph|
  paragraph.fields do |name,value|
    puts "Name=#{name} / Value=#{value}"
  end
end

```

Sample application to parse control files with just one paragraph
-----------------------------------------------------------------
```ruby
require 'debian_control_parser'

data=<<EOF
Foo: bar
Answer-to-Everything: 42
EOF

parser = DebianControlParser.new(data)
parser.fields do |name,value|
  puts "Name=#{name} / Value=#{value}"
end

```

What do I need this Gem for?
----------------------------
If you need to parse control files used by Debian and its derivatives like
Ubuntu or Linux mint you can use this gem. Control files are used in various
places like the Packages (list of binary packages), Sources (list of source
packages) or Release (information about a release, the supported architectures
and their software packages).

Why did you write it?
---------------------
I needed a parser for the rewrite of the
[debshots](https://www.debian.org/doc/debian-policy/ch-controlfields.html)
which is a rewrite of the web application tha runs
[screenshots.debian.net](https://screenshots.debian.net/) and similar
web sites.

Where is the layout of Debian control files defined?
----------------------------------------------------
You can find the formal specification of the layout of control files
in the [Debian Policy Manual](https://www.debian.org/doc/debian-policy/ch-controlfields.html).

What is so special about this Gem?
----------------------------------
I'm aware that there is at least one other parser for control files. But it reads
the entire file into memory. This is not always feasible because some control files
grow very large and require a lot of RAM to parse.

This class works as an iterator and lets you parse paragraphs and fields one by one.
Only paragraphs are read into memory because they are usually smaller.

What are paragraphs and fields?
-------------------------------
Certain control files like "Packages" are split into several blocks that
are seperated by newlines.

Example with three paragraphs:

```
Name10: Value10
Name11: Value11

Name20: Value20
Name21: Value21

Name30: Value30
Name31: Value31
```

Each of these paragaphs consists of fields that have a name and value each.
