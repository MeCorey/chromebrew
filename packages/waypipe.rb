require 'package'

class Waypipe < Package
  description 'A proxy for Wayland protocol applications. WARNING: different versions are incompatible'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.8.6'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bedb1ee7e35eb794158e28ac9f3c7a6c1590bd63c49d8f1edac2eef0cb445ac',
     armv7l: '9bedb1ee7e35eb794158e28ac9f3c7a6c1590bd63c49d8f1edac2eef0cb445ac',
     x86_64: '30f1226d52c91d34235fcbd58fd5405e586f0e37350f7d1ea43b6a485e2bc01d'
  })

  depends_on 'speexdsp' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libdrm' => :build
  depends_on 'libva' # R
  depends_on 'lz4' # R
  depends_on 'mesa' # R
  depends_on 'zstd' # R

  def self.build
    system "CC=clang LD=mold meson setup #{CREW_MESON_OPTIONS.gsub('-ffat-lto-objects', '').gsub('-fuse-ld=mold', '')} \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
