class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/defang-io/defang/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "5ebcb20416a94f5ba2d47e9c87871300bc144b6cc3d805460215f05c7de678f9"
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
