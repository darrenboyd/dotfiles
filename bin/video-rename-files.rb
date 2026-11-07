#!/usr/bin/env ruby

require 'fileutils'

main_title = ARGV.first or raise "Usage: #{$0} <title>"

DISC_RE = /SEASON_(\d+)_DISC_(\d+)_t(\d+)/i
actual_track_idx = 0
files = {}

Dir["*.mkv"].sort.each do |input_file|
  if md = DISC_RE.match(input_file)
    _, season_idx, disc_idx, track_idx = md.to_a
    season_idx = Integer(season_idx)
    disc_idx = Integer(disc_idx) - 1
    track_idx = Integer(track_idx)

    actual_track_idx += 1

    output_file = "%s - s%02de%02d - X.mkv" % [ main_title, season_idx, actual_track_idx ]
    files[input_file] = output_file
  end
end

in_width = files.keys.inject(0) { |w,f| f.size > w ? f.size : w }
puts(files.map { |x| "%#{in_width}s  =>  %s" % x })
puts "Hit enter to continue"
$stdin.gets

files.each do |in_file, out_file|
  FileUtils.mv(in_file, out_file)
end

# transcode-video  <input> -o <output>
# better quality
# transcode-video --big  <input> -o <output>
