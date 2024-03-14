class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://api.github.com/repos/defang-io/defang/tarball/v0.5.7"
  sha256 "3e7753e8f6073e316909f40b114032638e54a1121468ca204483fe3baba62f26"
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
