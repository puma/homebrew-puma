class PumaDev < Formula
  desc "A tool to manage rack apps in development with puma"
  homepage "https://github.com/puma/puma-dev"
  url "https://github.com/puma/puma-dev/releases/download/v0.9/puma-dev-v0.9-darwin-amd64.zip"
  sha56 "802bdef7ff838f1f5d3a6bb5ea1f2ac9f066122ac8ad1fcc1b329b9e1e4be692"
  version '0.9'

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

      To update to the latest release:
        puma-dev -install
    EOS
  end
end

