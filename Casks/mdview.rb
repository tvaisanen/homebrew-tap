cask "mdview" do
  version "0.3.0"
  sha256 "8443c6c3d7581710e8f22e236f2fe1434e54d7720c0af3bd62482e4742d7b738"

  url "https://github.com/slantedt/sigla-dist/releases/download/v#{version}/MarkdownViewer.zip"
  name "MarkdownViewer"
  desc "Markdown viewer for macOS with Mermaid diagram support"
  homepage "https://github.com/slantedt/sigla-dist"

  depends_on macos: ">= :sonoma"

  app "MarkdownViewer.app"

  postflight do
    # Install mdview CLI from release
    mdview_url = "https://github.com/slantedt/sigla-dist/releases/download/v#{version}/mdview"
    binary_path = "#{HOMEBREW_PREFIX}/bin/mdview"
    system_command "curl", args: ["-fsSL", "-o", binary_path, mdview_url]
    system_command "chmod", args: ["+x", binary_path]
  end

  uninstall_postflight do
    binary_path = "#{HOMEBREW_PREFIX}/bin/mdview"
    File.delete(binary_path) if File.exist?(binary_path)
  end

  zap trash: [
    "~/Library/Preferences/com.slantedt.markdownviewer.plist",
  ]
end
