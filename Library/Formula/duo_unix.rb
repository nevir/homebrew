require "formula"

class DuoUnix < Formula
  homepage "https://www.duosecurity.com/docs/duounix"
  url "https://dl.duosecurity.com/duo_unix-1.9.13.tar.gz"
  sha1 "96120910cbaa75c3a59e4c12006738b267c3e9f0"
  revision 1

  bottle do
    cellar :any
    revision 1
    sha1 "0511973efe89292865a034e3f0e6c35717061f8c" => :yosemite
    sha1 "77933fb49091788f90db88f0d41963889652ab6f" => :mavericks
    sha1 "68ccaf5aeb4811f2f7c548c676f7a15957768dd5" => :mountain_lion
  end

  depends_on "openssl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--includedir=#{include}/duo",
                          "--with-openssl=#{Formula["openssl"].opt_prefix}",
                          "--with-pam=#{lib}/pam/"
    system "make", "install"
  end

  test do
    system "#{sbin}/login_duo", "-d", "-c", "#{etc}/login_duo.conf",
                                "-f", "foobar", "echo", "SUCCESS"
  end
end
