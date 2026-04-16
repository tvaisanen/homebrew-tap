cask "mdview" do
  version "0.1.0"
  sha256 "6307f1413c0271c6a9cef2fc47c365dab5c484ac3bc6a1c8029e1afbaf4e289c"

  url "https://github.com/tvaisanen/markdownviewer/releases/download/v#{version}/MarkdownViewer.zip"
  name "MarkdownViewer"
  desc "Markdown viewer for macOS with Mermaid diagram support"
  homepage "https://github.com/tvaisanen/markdownviewer"

  depends_on macos: ">= :sonoma"

  app "MarkdownViewer.app"

  postflight do
    # Install mdview CLI from release
    mdview_url = "https://github.com/tvaisanen/markdownviewer/releases/download/v#{version}/mdview"
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
