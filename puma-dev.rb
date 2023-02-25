class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.18.3'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac? and Hardware::CPU.arm?
    url "#{base_url}-darwin-arm64.zip"
    sha256 '3df8b238ae8318d2591cbd69b372e304d6f8f39455d1a298420f53a31ad50cc7'
  elsif OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 '413c73504bbf4ac150cb76dd7433d86aa76b0f3bdd76d9ff2e0c3a29927557ae'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 'f817a38fb7138e0008923f994612bded0e6e55e69755f08be0b661b896b47ad2'
  end

  def install
    bin.install 'puma-dev'
  end

  test do
    require 'open3'
    puma_dev_bin = "#{bin}/puma-dev"
    ::Open3.popen3("#{puma_dev_bin} -h") do |_, _, stderr|
      assert_equal "Usage of #{puma_dev_bin}:", stderr.readlines.first.strip
    end
  end

  def caveats
    if OS.mac?
      <<~EOS
      Setup dev domains:
        sudo puma-dev -setup

      Install puma-dev as a launchd agent (required for port 80 usage):
        puma-dev -install
      EOS
    elsif OS.linux?
      <<~EOS
        You may want to have a look at

          https://github.com/puma/puma-dev#linux-support

        for more information on how to optimize puma-dev (i.e. port 80 support & root certificate)
      EOS
    end
  end
end
