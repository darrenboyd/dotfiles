def require_rb_files_from(dir)
  Dir.glob(File.join(dir, '*.rb')) do |file|
    require file
  end
end

require_rb_files_from(File.join(ENV['HOME'], '.irbrc.d'))

if defined?(Rails) || ENV['RAILS_ENV']
  load File.join(ENV['HOME'], '.rails-console-rc')
end

IRB.conf[:BACK_TRACE_LIMIT]= 20
