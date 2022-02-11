class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.18.2'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac? and Hardware::CPU.arm?
    url "#{base_url}-darwin-arm64.zip"
    sha256 '624b8dbe99e60905419ad659c129a4bfbf937383104821c117bb4926be2ca511'
  elsif OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 '7db1442c073b21de797e4e9d353b7b8427cfea6df68ac6b146912db1ca799d05'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 '23473eae5b4f5610fa289c601a59aecbd7fd3e4d1d1864acee099400b3279dd5'
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
