#!/usr/bin/env ruby
interval = 0.777
framerate = 3.33
num_images = 3
image_ext = "png"
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

for i in 1..num_images
  name = "#{dirname}/#{i}.#{image_ext}"
  names.push(name)
  `import -window root -crop "#{points}" #{name}`

  if i == num_images
    break
  end

  sleep(interval)
end

files = "#{dirname}/%d.#{image_ext}"
output = "#{dirname}/#{tagname(3)}.gif"
`ffmpeg -framerate #{framerate} -i #{files} #{output} -y`
`notify-send "GIF saved as #{output}"`