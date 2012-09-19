remote_file "/usr/local/bin/ffmpeg" do
  source "http://streamio-system-downloads.s3.amazonaws.com/ubuntu-12.04/ffmpeg-0.11.1"
  checksum "0a31df19446917301976d90cace9145f"
  mode 0755
  owner "root"
  group "root"
end

remote_file "/usr/local/bin/qt-faststart" do
  source "http://streamio-production-us.s3.amazonaws.com/system-downloads/qtfaststart.py"
  checksum "cbfbb84b05988e37f45b23a32bfbb40c"
  mode 0755
  owner "root"
  group "root"
end

remote_file "/etc/ffmpeg.tar.gz" do
  source "http://streamio-production-us.s3.amazonaws.com/system-downloads/ffmpeg.tar.gz"
  checksum "1499b44e745db478fb61c155a2fd272f"
  mode 0755
  owner "root"
  group "root"
  not_if { File.directory?("/etc/ffmpeg") }
end

bash "untar ffmpeg presets" do
  user "root"
  cwd "/etc"
  code "tar xvfz ffmpeg.tar.gz && rm ffmpeg.tar.gz"
  only_if { File.exists?("/etc/ffmpeg.tar.gz") }
end

user_dirs = Dir.glob("/home/*")

raise "No user dirs found for .ffmpeg presets which can cause havoc later on!" if user_dirs.empty?

user_dirs.each do |path|
  link "#{path}/.ffmpeg" do
    to "/etc/ffmpeg"
    not_if { File.symlink?("#{path}/.ffmpeg") }
  end
end