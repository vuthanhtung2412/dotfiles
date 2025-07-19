echo "=== Mise installations ==="
du -sh ~/.local/share/mise/ 2>/dev/null && mise list

echo ""
echo "=== Rust ==="
du -sh ~/.cargo/ ~/.rustup/ 2>/dev/null

echo ""
echo "=== Go ==="
du -sh ~/go/ ~/.cache/go-build/ 2>/dev/null

echo ""
echo "=== Node.js ==="
du -sh ~/.npm/ ~/.pnpm-store/ ~/.cache/pnpm/ 2>/dev/null

echo ""
echo "=== Python ==="
du -sh ~/.cache/pip/ ~/.pyenv/ 2>/dev/null

echo ""
echo "=== Docker ==="
docker system df

echo ""
echo "=== Homebrew ==="
du -sh $(brew --prefix) 2>/dev/null

echo ""
echo "=== /dev folder ==="
du -sh ~/dev/*
