class LibkrunAT1151 < Formula
  desc "Dynamic library providing KVM-based process isolation capabilities"
  homepage "https://github.com/containers/libkrun"
  version "1.15.1"
  url "https://github.com/containers/libkrun/releases/download/v1.15.1/libkrun-1.15.1-prebuilt-aarch64.tar.gz"
  sha256 "0ca2999968dbc469e9949d5a61f4399e339a51f3db7ff356aba3b8f13fc4c075"
  license "Apache-2.0"

  depends_on "rust" => :build
  depends_on "llvm" => :build
  # Upstream only supports Hypervisor.framework on arm64
  depends_on arch: :arm64
  depends_on "dtc"
  depends_on "libkrunfw"

  def install
    # krun_display build script uses libclang; point it at Homebrew's copy
    ENV["LIBCLANG_PATH"] = Formula["llvm"].opt_lib
    system "make", "BLK=1", "NET=1"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libkrun.h>
      int main()
      {
         int c = krun_create_ctx();
         return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lkrun", "-o", "test"
    system "./test"
  end
end
