class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/DefangLabs/defang/archive/refs/tags/v3.9.0.tar.gz"
  sha256 "7c5929183cba069b6d772663a2bcded1562e7d6a48ebd56816d06e55aae4b22e"
  license "MIT"
  head "https://github.com/DefangLabs/defang.git", branch: "main"

  depends_on "go@1.24" => :build

  def install
    version_info = "-X main.version=#{version}"
    Dir.chdir "src" do
      system "go", "build", *std_go_args(ldflags: "#{version_info} -s -w"), "./cmd/cli"
    end

    # Install shell completions (using the binary we just built to generate them)
    system "./src/bin/completions.sh", bin/"defang"
    bash_completion.install "defang.bash" => "defang"
    zsh_completion.install "defang.zsh" => "_defang"
    fish_completion.install "defang.fish"
  end

  test do
    system bin/"defang", "--version"
  end
end
