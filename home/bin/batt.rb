#!/usr/bin/env ruby
# encoding: utf-8
#
# Usage example:
#    /usr/bin/pmset -g batt | batt.rb
#
#battery = "🔋"
battery = "◒"
plug    = "⚡"

v= Hash.new()

ARGF.each do |a|
  if a.start_with? "Now"
    #test for the first line
    if a =~ /'(.*)'/
      v[:source] = $~[1]
    else
      v[:source] = ""
    end
  elsif a.start_with?" -"
    if a =~ /(\d{1,3})%;\s(.*);\s(\d+:\d{2}|\(no estimate\))/
      v[:percent] = $~[1].to_i
      v[:state]   = $~[2]
      v[:time]    = $~[3]
      v[:hours]   = v[:time].split(':')[0]
      v[:mins]    = v[:time].split(':')[1]
    else
      v[:percent] = "0"
      v[:state]   = "unknown"
      v[:time]    = "unknown"
    end
  end
end

if v[:source]== "Battery Power"
  outstring = "#{battery} #{v[:percent]}% #{v[:time]}"
else
  outstring = "#{plug} #{v[:percent]}%"
end

puts outstring
