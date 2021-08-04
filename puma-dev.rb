class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.16.2'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac? and Hardware::CPU.arm?
    url "#{base_url}-darwin-arm64.zip"
    sha256 'fc22a1aed4f31f9c6ee96750db5f1dcbeb0cf5171c7021a9963a08f48d7252aa'
  elsif OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 '2321ea4a60c7e3ef8c0723258476a26efc4732cbda06e4fed61055638817d819'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 'ae99a26beece5f7b311dbdc06f260bf1ca23a412788d88d1b62d2e810c7c9757'
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
