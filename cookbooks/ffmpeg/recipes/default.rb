#
# Cookbook Name:: ffmpeg
# Recipe:: default
#

remote_file "/usr/local/bin/ffmpeg" do
  source "https://s3.amazonaws.com/shotbox-development-us/ffmpeg/ffmpeg_static-0.11.2"
  checksum "4aab0e9a4834af2073e8a17edb0cdc0c"
  mode 0755
  owner "root"
  group "root"
end

remote_file "/usr/local/share/ffmpeg_share.tar.gz" do
  source "https://s3.amazonaws.com/shotbox-development-us/ffmpeg/ffmpeg_share.tar.gz"
  checksum "660b74c2bacd178becf8676d7d597d1f"
  mode 0755
  owner "root"
  group "root"
  not_if { File.directory?("/usr/local/share/ffmpeg") }
end

bash "untar ffmpeg presets" do
  user "root"
  cwd "/usr/local/share"
  code "tar xzvf ffmpeg_share.tar.gz && rm ffmpeg_share.tar.gz"
  only_if { File.exists?("/usr/local/share/ffmpeg_share.tar.gz") }
end

user_dirs = Dir.glob("/home/*")

raise "No user dirs found for .ffmpeg presets which can cause havoc later on!" if user_dirs.empty?

user_dirs.each do |path|
  link "#{path}/.ffmpeg" do
    to "/usr/local/share/ffmpeg"
    not_if { File.symlink?("#{path}/.ffmpeg") }
  end
end
