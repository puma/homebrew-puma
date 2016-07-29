class PumaDev < Formula
  desc "A tool to manage rack apps in development with puma"
  homepage "https://github.com/puma/puma-dev"
  url 'https://github.com/puma/puma-dev/releases/download/v0.4/puma-dev-v0.4-darwin-amd64.zip'
  sha256 '5760e40f2a8891c7f5155df204250b44f92e925eb980215eea6f9d966a25f811'
  version '0.4'

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
    <<-EOS.undent
      Setup dev domains:
        sudo puma-dev -setup

      Install puma-dev as a launchd agent (required for port 80 usage):
        puma-dev -install
    EOS
  end
end

