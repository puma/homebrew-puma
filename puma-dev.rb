class PumaDev < Formula
  desc "A tool to manage rack apps in development with puma"
  homepage "https://github.com/puma/puma-dev"
  url "https://github.com/puma/puma-dev/releases/download/v0.14/puma-dev-0.14-darwin-amd64.zip"
  sha256 "cabc83df06afa0deb97acbe2f8454bf2a7784bbb74a4b3160fbbb630788b97d7"
  version '0.14'

  def install
    bin.install "puma-dev"
  end

  test do
    require 'open3'
    puma_dev_bin = "#{bin}/puma-dev"
    ::Open3.popen3("#{puma_dev_bin} -h") do |_, _, stderr|
      assert_equal "Usage of #{puma_dev_bin}:", stderr.readlines.first.strip
    end
  end

  def caveats
    <<~EOS
      Setup dev domains:
        sudo puma-dev -setup

      Install puma-dev as a launchd agent (required for port 80 usage):
        puma-dev -install
    EOS
  end
end

