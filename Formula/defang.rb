class Defang < Formula
  desc "Samples and the Defang CLI source code"
  homepage "https://defang.io"
  url "https://github.com/defang-io/defang/archive/refs/tags/v0.4.61.tar.gz"
  sha256 "e80e424c32f9d1b4439c4f8ed0b0328ce7f3d004f2227e79fbb42b6d18c9aa58"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    system "false"
  end
end
