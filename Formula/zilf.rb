class Zilf < Formula
  desc "Tools for working with the Zork Implementation Language from Infocom"
  
  # moved in 2021 https://bitbucket.org/jmcgrew/zilf/commits/f90774a9c5e219fd9c5da9ef112f3a40c5af1eb7
  #homepage "https://bitbucket.org/jmcgrew/zilf/"
  homepage "https://www.zilf.io/"
  url "https://www.ifarchive.org/if-archive/infocom/compilers/zilf/zilf-0.8.zip"
  sha256 "60b38260e868910095a6351e5c635ebf58e12dbd66de9677665664ccbd603286"
  #bottle :unneeded

  depends_on "mono"

  def install
    prefix.install "README.txt"
    libexec.install Dir["bin/*"]
    prefix.install Dir["doc", "library", "sample"]
    (bin/"zilf").write <<~EOS
      #!/bin/sh
      mono #{libexec}/zilf.exe -ip "#{prefix}/library" "$@"
    EOS
    (bin/"zapf").write <<~EOS
      #!/bin/sh
      mono #{libexec}/zapf.exe "$@"
    EOS
  end

  test do
    system "#{bin}/zilf", "-x", "#{prefix}/sample/cloak.zil"
  end
end
