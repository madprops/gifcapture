#!/usr/bin/env ruby
delay = 33
quality = 75
interval = 0.777
imgformat = "jpg"
rootdir = "/home/yo/Downloads/pics/caps"
unixtime = Time.now.to_i
dirname = "#{rootdir}/#{unixtime}"
names = []

unless Dir.exist?(dirname)
  Dir.mkdir(dirname)
end

points = `xrectsel`
sleep(0.1)

for i in 1..5 do
  name = "#{dirname}/#{i}.#{imgformat}"
  names.push(name)
  `import -window root -crop "#{points}" #{name}`
  sleep(interval)
end

flat = names.join(" ")
`convert -delay #{delay} -loop 0 #{flat} -quality #{quality} #{dirname}/result.gif`
`notify-send "GIF created in #{dirname}"`