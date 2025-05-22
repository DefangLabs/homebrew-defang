class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/DefangLabs/defang/archive/refs/tags/v1.1.24.tar.gz"
  sha256 "35173d8d2ae8f9536ba37afbfdc3280da8a7099d4647b9ffe22e0a03dc0e5c08"
  license "MIT"
  head "https://github.com/DefangLabs/defang.git", branch: "main"

  depends_on "go" => :build

  def install
    version_info = "-X main.version=#{version}"
    Dir.chdir "src" do
      system "go", "build", "-o", bin/"defang", "-buildvcs=false", *std_go_args(ldflags: "#{version_info} -s -w"), "./cmd/cli"
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
