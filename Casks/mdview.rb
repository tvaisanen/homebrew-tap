cask "mdview" do
  version "0.1.0"
  sha256 "4491b78e5fe9873e9123dbb6d6755ce0e0d7b36f40ad45c89fd6ba6fce7b0152"

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
