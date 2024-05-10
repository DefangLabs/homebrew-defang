class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/defang-io/defang/archive/refs/tags/v0.5.13.tar.gz"
  sha256 "efdf339856cbe367d4d675f25cfbebcff2e16b1774316cbf3384a91a27d297df"
  license "MIT"
  head "https://github.com/defang-io/defang.git", branch: "main"

  depends_on "go" => :build

  def install
    version_info = "-X main.version=#{version}"
    Dir.chdir "src" do
      system "go", "build", "-o", bin/"defang", *std_go_args(ldflags: "#{version_info} -s -w"), "./cmd/cli"
    end

    # Install shell completions (using the binary we just built to generate them)
    system "./src/bin/completions.sh", bin/"defang"
    bash_completion.install "defang.bash" => "defang"
    zsh_completion.install "defang.fish" => "_defang"
    fish_completion.install "defang.zsh"
  end

  test do
    system bin/"defang", "version"
  end
end
