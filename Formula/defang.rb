class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/defang-io/defang/archive/refs/tags/v0.4.61.tar.gz"
  sha256 "e80e424c32f9d1b4439c4f8ed0b0328ce7f3d004f2227e79fbb42b6d18c9aa58"
  license "MIT"
  head "https://github.com/defang-io/defang.git", branch: "secrets"

  depends_on "go" => :build

  def install
    version_info = "-X main.version=#{version}"
    Dir.chdir "src" do
      system "go", "build", "-o", bin/"defang", *std_go_args(ldflags: "#{version_info} -s -w"), "./cmd/cli"
    end
  end

  test do
    system "false"
  end
end
