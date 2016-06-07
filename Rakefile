require 'pathname'

LINK_FILES = %w(tm_properties irbrc irbrc.d railsrc railsrc.d aprc
                bash_profile bash_profile.d bashrc
                emacs.d
                editrc inputrc ackrc gitignore rvmrc slate psqlrc)
INSERT_FILES = %w(gemrc gitconfig)

def stop_error(message)
  puts "ERROR: #{message}"
  exit(1)
end

BACKUP_DIR=File.join(ENV['HOME'], 'dotfiles-bak')

def move_target(target)
  if @our_backup_dir.nil? && File.exist?(BACKUP_DIR)
    stop_error("Backup directory exists: #{BACKUP_DIR}")
  end
  if @our_backup_dir.nil?
    puts "Creating backup directory #{BACKUP_DIR}"
    FileUtils.mkdir(BACKUP_DIR)
    @our_backup_dir = true
  end
  puts "Moving #{target} to #{BACKUP_DIR}"
  FileUtils.mv(target, "#{BACKUP_DIR}/")
end

def safe_symlink(target, link)
  puts "Linking #{link} => #{target}"
  if File.exist?(link) && Pathname.new(link).realpath.to_s != target
    puts "Moving #{link} to backup directory"
    move_target(link)
  end
  if !File.exist?(link)
    File.symlink(target, link)
    puts
  end
end

desc "Install all dotfiles"
task :install do
  home = ENV['HOME']
  pwd = File.dirname(__FILE__)

  LINK_FILES.each do |file|
    safe_symlink("#{pwd}/#{file}", "#{home}/.#{file}")
  end

  INSERT_FILES.each do |file|
    insert = File.read("#{pwd}/#{file}").strip
    lines = insert.split("\n")

    matcher = Regexp.new(Regexp.escape(lines.first) + '.*?' + Regexp.escape(lines.last), Regexp::MULTILINE)

    contents = File.exists?("#{home}/.#{file}") ? File.read("#{home}/.#{file}") : ''

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

  FileUtils.touch("#{home}/.psqlrc.local")

  puts "Use ~/.bash_profile.d/local.sh for machine specific bash settings."
  puts "Use ~/.psqlrc.local for machine specific psql settings."

end

task :default => :install
