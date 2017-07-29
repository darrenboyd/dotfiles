#!/usr/bin/env ruby

LEFT = '1'
UPDATE_TIME = 10 # more like 3600

def press_key(window_id, key)
  print "Pressing: #{key}"
  upper = ('A'..'Z').include?(key)
  cmd = [ 'xdotool' ]
  cmd << 'key' << key
  system  *cmd
  puts "."
  sleep(rand(0.01..0.2))
end

def click(window_id, left, top)
  puts "Clicking at: #{left},#{top}"
  system *[
    'xdotool',
    'mousemove', '--sync', '--window', window_id.to_s, left.to_s, top.to_s,
  ]
  sleep(0.4)
  system *[
    'xdotool',
    'click', '--window', window_id.to_s, LEFT
  ]
  sleep(1)
end

#################
puts "Cleaning up any apps that might still be running"
pids = `pgrep --full shroud-of-the-avatar-launcher`.split
if pids.empty?
  # Get everything updated
  puts "Starting updater"
  pid = fork do
    exec "/usr/games/shroud-of-the-avatar-launcher"
  end
  Process.detach(pid)
  sleep(3)
  $stdout.flush
  puts '**************** Press Enter When Update is Finished ******************'
  $stdout.flush
  gets
elsif pids.size > 1
  puts "Too many launcher pids found"
  exit
else
  pid = pids.first.to_i
end

# Get rid of the launcher
puts "Kill the launcher"
Process.kill('TERM', pid)

# Run the game manually
puts "Starting game"
pid = fork do
  exec *[
    "/usr/local/games/shroud-of-the-avatar-launcher/Shroud of the Avatar.x86_64",
    '-single-instance',
    '-logFile',
    "/home/darren/.config/unity3d/Portalarium/Shroud of the Avatar/sota_log.txt"
  ]
end
Process.detach(pid)

puts "PID: #{pid}"
sleep(20) # takes a while to startup
window = `xdotool search --pid #{pid}`.chomp
puts "WINDOW: #{window}"

# Figure out position
str = `xdotool getwindowgeometry #{window}`.split.join(" ")
md = %r{Position: (\d+)\,(\d+).*Geometry: (\d+)x(\d+)}.match(str)
_,left,top,width,height = md.to_a

left   = Integer(left)
top    = Integer(top)
width  = Integer(width)
height = Integer(height)

puts "  #{left},#{top}"
puts "  #{width}x#{height}"

mid = width/2

# Get focus
system *[
  'xdotool',
  'windowfocus', '--sync', window.to_s,
  'windowraise', window.to_s,
  'mousemove', '--sync', '--window', window.to_s, mid.to_s, '10',
  'click', '--window', window, LEFT
]

#####################
puts "Hit enter twice to get to Play Online"
press_key(window, 'Return')
sleep(5)
press_key(window, 'Return')
sleep(15)

#####################
puts "Click on 'Play Online'"
click(window, mid, 400)
sleep(5)

#####################
puts "Click in pasword field"
click(window, mid-30, 415)

#####################
puts "Paste in password, and hit Return"
IO.popen('xsel -b', 'w') { |p| p.write(ENV['SOTA_PASSWORD']) }
sleep(1)
press_key(window, 'ctrl+v')
sleep(0.5)
press_key(window, 'Return')
sleep(10)

#####################
puts "Click Resume"
click(window, mid, 500)

#####################
# puts "Wait to get all signed-in"
# sleep(120)

#####################
# puts "Kill the game"
# Process.kill('HUP', Integer(pid))

# Click "Exit"
# click(window, mid-50, 500)
