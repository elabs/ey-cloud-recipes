#
# Cookbook Name:: ffmpeg
# Attributes:: default
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ffmpeg_install_method(:source)
ffmpeg_prefix("/usr/local")
ffmpeg_git_repository("git://git.videolan.org/ffmpeg.git")
ffmpeg_compile_flags([
  "--disable-debug",
  "--enable-pthreads",
  "--enable-nonfree",
  "--enable-gpl",
  "--disable-indev=jack",
  "--enable-libx264",
  "--enable-libfaac",
  "--enable-libmp3lame",
  "--enable-libtheora",
  "--enable-libvorbis",
  "--enable-libvpx",
  "--enable-libxvid",
  "--enable-libfaad"
])

# default[:ffmpeg][:install_method] = :source
# default[:ffmpeg][:prefix] = "/usr/local"
# default[:ffmpeg][:git_repository] = "git://git.videolan.org/ffmpeg.git"
# default[:ffmpeg][:compile_flags] = [
#   "--disable-debug",
#   "--enable-pthreads",
#   "--enable-nonfree",
#   "--enable-gpl",
#   "--disable-indev=jack",
#   "--enable-libx264",
#   "--enable-libfaac",
#   "--enable-libmp3lame",
#   "--enable-libtheora",
#   "--enable-libvorbis",
#   "--enable-libvpx",
#   "--enable-libxvid",
#   "--enable-libfaad"
# ]

# JW 07-06-11: Hash of commit or a HEAD should be used - not a tag. Sync action of Git
# provider will always attempt to update the git clone if a tag is used.
ffmpeg_git_revision("39fe8033bbf94cac7935d749849fdf67ba8fc16a")
# default[:ffmpeg][:git_revision]   = "39fe8033bbf94cac7935d749849fdf67ba8fc16a" # tag n0.11.1
