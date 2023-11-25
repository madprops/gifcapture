#!/usr/bin/env ruby

# CONFIG
$interval = 0.777
$delay = 33
$quality = 80
$num_images = 5
$image_ext = "png"
$rootdir = "/home/yo/Downloads/pics/caps"
$dirname = "#{$rootdir}/#{Time.now.to_i}"
# END CONFIG

def mkdir()
  unless Dir.exist?($dirname)
    Dir.mkdir($dirname)
  end
end

def capture()
  points = `xrectsel`
  sleep(0.1)
  split = points.split("+")
  geometry = split[0].split("x")
  width = geometry[0]
  height = geometry[1]
  x = split[1]
  y = split[2]

  for i in 1..$num_images
    name = "#{$dirname}/#{i}.#{$image_ext}"
    `scrot -o #{name} -a #{width},#{height},#{x},#{y}`

    if i == $num_images
      break
    end

    sleep($interval)
  end
end

def tagname(num)
  consonants = ("a".."z").to_a - ["a", "e", "i", "o", "u"]
  vowels = ["a", "e", "i", "o", "u"]
  word = ""

  num.times do
    word += "#{consonants.sample}#{vowels.sample}"
  end

  return word
end

def render()
  files = "#{$dirname}/*.#{$image_ext}"
  output = "#{$dirname}/#{tagname(3)}.gif"
  `convert -delay #{$delay} -loop 0 #{files} -quality #{$quality} #{output}`
  `notify-send "GIF saved as #{output}"`
end

# MAIN
mkdir()
capture()
render()