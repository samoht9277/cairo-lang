class CairoLang@v2.0.0-rc0 < Formula
  desc "Cairo Language v2.0.0-rc0"
  version "v2.0.0-rc0"
  depends_on "rust"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v2.0.0-rc0.tar.gz"
  sha256 "6b7879b4e3e93107d6fdfef5a164822acb9a176ef4741c288e11e97935b2b535"
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
