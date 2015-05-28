require 'formula'

class Fdkaac < Formula
  version '0.3.0a'
  homepage 'https://github.com/pneuman/fdkaac'
  #url 'https://github.com/pneuman/fdkaac/archive/f56c705be53c1d7f1bdc4b5e97553224fbe9006a.zip'
  url 'https://github.com/pneuman/fdkaac.git', :using => :git, :revision => 'f56c705be53c1d7f1bdc4b5e97553224fbe9006a'
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
