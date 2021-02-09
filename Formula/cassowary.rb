class Cassowary < Formula
  desc "Modern cross-platform HTTP load-testing tool written in Go"
  homepage "https://github.com/rogerwelin/cassowary"
  url "https://github.com/rogerwelin/cassowary/archive/v0.12.1.tar.gz"
  sha256 "091bc850ec0e1a83d9e909650e4f011a6176c62b1059a99815e795b79362d861"
  license "MIT"
  head "https://github.com/rogerwelin/cassowary.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3a66cf898e85a56861cbfc4073e73a29b8c222a0cb921ae92fffe56694a4b250"
    sha256 cellar: :any_skip_relocation, big_sur:       "2329ffcb5f5f4777ec17661461c25a650e60c02bacfe0f7ebc738e1217c7fa27"
    sha256 cellar: :any_skip_relocation, catalina:      "83d6b17ca128c3830cec6e8ef31452e2f303f92f1fd9090d48711b639cb9c76e"
    sha256 cellar: :any_skip_relocation, mojave:        "f6ac1ec8b86f43a9e64b407d9797d47a6e74200ebd3caf90fa9d856c8860772a"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X main.version=#{version}", *std_go_args, "./cmd/cassowary"
  end

  test do
    system("#{bin}/cassowary", "run", "-u", "http://www.example.com", "-c", "10", "-n", "100", "--json-metrics")
    assert_match "\"base_url\":\"http://www.example.com\"", File.read("#{testpath}/out.json")

    assert_match version.to_s, shell_output("#{bin}/cassowary --version")
  end
end
