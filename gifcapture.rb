#!/usr/bin/env ruby
unixtime = Time.now.to_i
rootdir = "/home/yo/Downloads/pics/caps/"
dirname = "#{rootdir}/#{unixtime}"

unless Dir.exist?(dirname)
  Dir.mkdir(dirname)
end

points = `xrectsel`
split = points.split("+")
geometry = split[0].split("x")
width = geometry[0]
height = geometry[1]
x = split[1]
y = split[2]
names = []

for i in 1..5 do
  name = "#{dirname}/#{i}.jpg"
  names.push(name)
  `import -window root -crop "#{points}" #{name}`
  sleep(0.777)
end

flat = names.join(" ")
`convert -delay 33 -loop 0 #{flat} -quality 75 #{dirname}/result.gif`
`notify-send "GIF created"`