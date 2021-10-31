class PumaDev < Formula
  desc 'A tool to manage rack apps in development with puma'
  homepage 'https://github.com/puma/puma-dev'
  version '0.17.0'

  base_url = "https://github.com/puma/puma-dev/releases/download/v#{version}/puma-dev-#{version}"

  if OS.mac? and Hardware::CPU.arm?
    url "#{base_url}-darwin-arm64.zip"
    sha256 '7f04b54d6df97c32e957da8cd1d96892f7e62821735ca26a1f23f02f2923ab89'
  elsif OS.mac?
    url "#{base_url}-darwin-amd64.zip"
    sha256 '4ba244c2824f56dae38495a9011e1400b612491940603e45c6bfb56f388528a0'
  elsif OS.linux?
    url "#{base_url}-linux-amd64.tar.gz"
    sha256 '14678808ddab26ecaf7f33c3e4851a40d6dbd9710dbde91bb9fd7772f0a6edb4'
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
