class CairoLang@v2.1.0-rc1 < Formula
  desc "Cairo Language v2.1.0-rc1"
  version "v2.1.0-rc1"
  depends_on "rust"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v2.1.0-rc1.tar.gz"
  sha256 "ab715daa4f5a4151f85288ac25870db28725f34d95df23ab15a7ce0b733480d3"
  license "Apache-2.0"

  def install
    if !(File.file?("/opt/homebrew/bin/rustc") || File.file?("/Users/#{current_user}/.cargo/bin/rustc"))
      raise("Rust compiler not installed, please install it first!")
    end

    current_user = ENV["USER"]
    ENV.prepend_path "PATH", "/Users/#{current_user}/.cargo/bin/"

    if !(File.file?("/Users/#{current_user}/.cargo/bin/rustup"))
      puts "Rust compiler found but rustup, installing..."
      system("rustup-init -qy")
    end

    system("rustup override set stable")
    system("cargo build --all --release --manifest-path ./Cargo.toml")

    prefix.install Dir["./corelib/"]
    bin.install "./target/release/cairo-compile"
    bin.install "./target/release/cairo-format"
    bin.install "./target/release/cairo-language-server"
    bin.install "./target/release/cairo-run"
    bin.install "./target/release/cairo-test"
    bin.install "./target/release/sierra-compile"
    bin.install "./target/release/starknet-compile"
    bin.install "./target/release/starknet-sierra-compile"
  end
end
