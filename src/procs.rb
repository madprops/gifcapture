def mkdir()
  unless Dir.exist?($dirname)
    Dir.mkdir($dirname)
  end
end

def capture()
  points = `xrectsel`
  sleep(0.1)
  matches = points.match(/(\d+)x(\d+)\+(\d+)\+(\d+)/)
  width = matches[1].to_i
  height = matches[2].to_i
  x = matches[3].to_i
  y = matches[4].to_i

  for i in 1..$num_images
    name = "#{$dirname}/#{i}.#{$image_ext}"
    `scrot -o #{name} -a #{x},#{y},#{width},#{height}`

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