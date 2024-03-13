#!/usr/bin/env ruby
#Matches a particular pattern
puts ARGV[0].scan(/^[0-9]{10}$/).join
