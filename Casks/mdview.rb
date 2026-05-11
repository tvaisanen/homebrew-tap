cask "mdview" do
  version "0.2.6"
  sha256 "d9657bbc9069a0f9f40e7724b5a04d79e3df07ecad1c3ff967967eb8eb74bf08"

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
