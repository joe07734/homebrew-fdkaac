require 'formula'

class Fdkaac < Formula
  version '0.3.0b'
  homepage 'https://github.com/pneuman/fdkaac'
  #url 'https://github.com/pneuman/fdkaac/archive/f56c705be53c1d7f1bdc4b5e97553224fbe9006a.zip'
  # url 'https://github.com/pneuman/fdkaac.git', :using => :git, :revision => '99501bb1a60568b8abbf4015dea9e5da6866a998'
  url 'https://github.com/joe07734/fdkaac.git', :using => :git, :revision => 'bf98e1bee0f07f29ddf284aa743fbb7f4c6ec0fd'
  sha256 ''

  env :std

  option 'with-sndfile', 'Build with libsndfile support'
  option 'with-samplerate', 'Build with libsamplerate support (also requires libsndfile)'

# Always use newer versions of these tools
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'libtool' => :build

  depends_on 'gettext'

  depends_on 'fdk-aac'
  depends_on 'libsndfile' if build.include? 'with-sndfile'
  depends_on 'libsamplerate' if build.include? 'with-samplerate'

  def install
    args = [
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}"
    ]
    args << "--with-sndfile" if build.include? 'with-sndfile'
    args << "--with-samplerate" if build.include? 'with-samplerate'

    system "autoreconf -i"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "fdkaac"
  end
end
