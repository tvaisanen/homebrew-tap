# Reinstall mdview from tap (clears cache)
reinstall:
    rm -f "$(brew --cache --cask mdview 2>/dev/null)" 2>/dev/null || true
    brew untap tvaisanen/tap 2>/dev/null || true
    brew tap tvaisanen/tap
    brew install --cask mdview

# Test the installed cask
test:
    @echo "App:"
    @test -d /Applications/MarkdownViewer.app && echo "  /Applications/MarkdownViewer.app ✓" || echo "  NOT INSTALLED ✗"
    @echo "CLI:"
    @which mdview && mdview --version || echo "  mdview NOT FOUND ✗"
    @echo "Signing:"
    @codesign --verify --deep --strict /Applications/MarkdownViewer.app 2>&1 && echo "  Signed ✓" || echo "  NOT SIGNED ✗"
