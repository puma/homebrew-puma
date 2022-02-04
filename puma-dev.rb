class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.18.1'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac? and Hardware::CPU.arm?
    url "#{base_url}-darwin-arm64.zip"
    sha256 '99f91f0a09d8e1ac049d43e1c6a7d68d9a8b20638da7e8d70eb331ff2f5de9ff'
  elsif OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 '6a500b81bc580880921e461656ff360e494dd886c5978224fe9f9873782edbf5'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 'a77b3bde34c0daad3a7608e2d575dbe6759c8312533d00ef05c72c8dd9691df1'
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
