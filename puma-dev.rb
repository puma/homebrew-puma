class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.16.1'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac? and Hardware::CPU.arm?
    url "#{base_url}-darwin-arm64.zip"
    sha256 'TODO'
  elsif OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 'cd399611ee350952b24ad8555d731253510e03fdd821b09b5ae7135faa24778c'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 'cbd1f5266b1a198d60b5fc26fc605abc938efc00fa90ceb1c36701e69272f72f'
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
