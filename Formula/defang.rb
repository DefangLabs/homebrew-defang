class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://api.github.com/repos/defang-io/defang/tarball/v0.5.5"
  sha256 "2c451504926cdc938f5cf25674e8c464fb74b11494b33e607fc05cc2eedccb92"
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
