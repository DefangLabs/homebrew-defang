class Defang < Formula
  desc "Command-line interface for the Defang Opinionated Platform"
  homepage "https://defang.io"
  url "https://api.github.com/repos/defang-io/defang/tarball/v0.5.13"
  sha256 "51cb6763b6754b5af1506c31872bf31c0cf33429dea51fa1221e0047835324b3"
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
