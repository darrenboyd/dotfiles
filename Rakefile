require 'pathname'

LINK_FILES = %w(irbrc irbrc.d railsrc railsrc.d aprc bash_profile bash_profile.d editrc inputrc ackrc gitignore rvmrc)
INSERT_FILES = %w(gemrc gitconfig)

def stop_error(message)
  puts "ERROR: #{message}"
  exit(1)
end

def symlink(target, link)
  puts "Linking #{link} => #{target}"
  if File.exist?(link) && Pathname.new(link).realpath.to_s != target
    stop_error("File exists: #{link}")
  elsif !File.exist?(link)
    File.symlink(target, link)
    puts
  end
end

desc "Install all dotfiles"
task :install do
  home = ENV['HOME']
  pwd = File.dirname(__FILE__)

  LINK_FILES.each do |file|
    symlink("#{pwd}/#{file}", "#{home}/.#{file}")
  end
  
  INSERT_FILES.each do |file|
    insert = File.read("#{pwd}/#{file}").strip
    lines = insert.split("\n")

    matcher = Regexp.new(Regexp.escape(lines.first) + '.*?' + Regexp.escape(lines.last), Regexp::MULTILINE)

    if File.exist?("#{home}/.#{file}")
      contents = File.read("#{home}/.#{file}")
    else
      contents = ""
    end

    puts "Insert content into #{home}/.#{file}"
    output = 
      if contents =~ matcher
        contents.sub(matcher, insert)
      else
        puts "WARNING: This is the first time editing #{home}/.#{file} automatically, you should verify the contents."
        insert + "\n" + contents
      end
    
    File.open("#{home}/.#{file}", 'w') do |f|
      f.write(output)
    end
  end

  puts "Use ~/.bash_profile.d/local.sh for machine specific bash settings."

end