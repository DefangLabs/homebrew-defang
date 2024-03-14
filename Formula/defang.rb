class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://api.github.com/repos/defang-io/defang/tarball/v0.5.6"
  sha256 "0ae7ed099bbbea09ade7b054a1f392da510f5cd984a13c762602f08d9607fb83"
  license "MIT"
  head "https://github.com/defang-io/defang.git", branch: "main"

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
