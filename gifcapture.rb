#!/usr/bin/env ruby
delay = 33
quality = 80
interval = 0.777
imgformat = "jpg"
rootdir = "/home/yo/Downloads/pics/caps"
dirname = "#{rootdir}/#{Time.now.to_i}"
$consonants = ("a".."z").to_a - ["a", "e", "i", "o", "u"]
$vowels = ["a", "e", "i", "o", "u"]

def tagname(num)
  word = ""

  num.times do
    word += "#{$consonants.sample}#{$vowels.sample}"
  end

  return word
end

unless Dir.exist?(dirname)
  Dir.mkdir(dirname)
end

points = `xrectsel`
sleep(0.1)
names = []

for i in 1..5
  name = "#{dirname}/#{i}.#{imgformat}"
  names.push(name)
  `import -window root -crop "#{points}" #{name}`
  sleep(interval)
end

flat = names.join(" ")
output = "#{dirname}/#{tagname(3)}.gif"
`convert -delay #{delay} -loop 0 #{flat} -quality #{quality} #{output}`
`notify-send "GIF saved as #{output}"`