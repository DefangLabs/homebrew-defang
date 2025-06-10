class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/DefangLabs/defang/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f9b03eb803572904dd35a0cd00ab862bb0e28327fbdaacf210f7dc1e016ec1bc"
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
