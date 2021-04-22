class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.16.0'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 'fd95185d130068aac2216c01ba52fe51f9794f93bcb2927980aee93d8a2a4d8e'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 '5811f6feda333d011c8d6ca6c3bce07fa3ae27ba62d6f7cfb72099ff44e16b53'
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

