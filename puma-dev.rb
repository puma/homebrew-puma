class PumaDev < Formula
  desc "A tool to manage rack apps in development with puma"
  homepage "https://github.com/puma/puma-dev"
  url 'https://github.com/puma/puma-dev/releases/download/v0.5/puma-dev-v0.5-darwin-amd64.zip'
  sha256 "1f8baa5e49c6dd74fecf061b2a42de86b41f250dc8c2acd74f12d04572b3dfcc"
  version '0.5'

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

