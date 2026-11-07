#!/usr/bin/env ruby

begin
  gem 'video_transcoding'
rescue Gem::MissingSpecError => e
  $stderr.puts "*** Please run $ gem install video_transcoding"
  exit(1)
end

require 'fileutils'

ext = ".mkv"

def move_file(src, dest)
  FileUtils.mv(src, dest) or
    raise "Move failed: #{src} #{dest}"
end

Dir["*#{ext}"].sort.each do |input_file|
  base = File.basename(input_file, ext)
  output_file = [ base, " - output", ext].join
  backup_file = [ base, " - orig", ext].join

  cmd = ['transcode-video', input_file, '-o', output_file]
  puts "#" * 80
  puts "##  TRANSCODING: #{input_file}"
  puts "##  => #{cmd.join(' ')}"
  puts "#" * 80
  system(*cmd) or
    raise "Unable to transcode video"
  move_file(input_file, backup_file)
  move_file(output_file, input_file)
  puts "\n\n"
end

