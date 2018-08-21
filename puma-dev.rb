class PumaDev < Formula
  desc "A tool to manage rack apps in development with puma"
  homepage "https://github.com/puma/puma-dev"
  url "https://github.com/puma/puma-dev/releases/download/v0.12/puma-dev-v0.12-darwin-amd64.zip"
  sha256 "fd0537d48e86aba9b7a3036c7ba1b23b67528cec4e6b41537261a628908d2f97"
  version '0.12'

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

      To update to the latest release:
        puma-dev -install
    EOS
  end
end

