class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://github.com/DefangLabs/defang/archive/refs/tags/v1.1.26.tar.gz"
  sha256 "348468717ed1e3683d4b38516516c5bfa71f6360889ce9c0a3dfac38607e28b4"
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
