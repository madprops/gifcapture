$dirname = "#{$rootdir}/#{Time.now.to_i}"
$consonants = ("a".."z").to_a - ["a", "e", "i", "o", "u"]
$vowels = ["a", "e", "i", "o", "u"]

def mkdir()
  unless Dir.exist?($dirname)
    Dir.mkdir($dirname)
  end
end

def capture()
  geometry = `slurp -f "%wx%h+%x+%y"`.strip
  sleep(0.1)

  for i in 1..$num_images
    name = "#{$dirname}/#{i}.#{$image_ext}"
    `spectacle -f -b -n -o #{name}`
    `magick #{name} -crop #{geometry} +repage #{name}`

    if i == $num_images
      break
    end

    sleep($interval)
  end
end

def tagname(num)
  word = ""
  num.times do
    word += "#{$consonants.sample}#{$vowels.sample}"
  end
  return word
end

def render()
  files = "#{$dirname}/*.#{$image_ext}"
  file_path = "#{$dirname}/#{tagname(3)}.gif"
  `magick -delay #{$delay} -loop 0 #{files} -quality #{$quality} #{file_path}`
  return file_path
end

def notify(file_path)
  system("notify-send", "GIF saved as #{file_path}")
end

def opendir()
  system("xdg-open", $dirname)
end