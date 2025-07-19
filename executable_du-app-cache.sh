#!/bin/bash
echo "=== User Caches ==="
du -sh ~/Library/Caches/* 2>/dev/null | sort -hr | head -20

echo ""
echo -e "=== Application Support ==="
du -sh ~/Library/Application\ Support/* 2>/dev/null | sort -hr | head -10

echo ""
echo -e "=== Container Caches ==="
du -sh ~/Library/Containers/*/Data/Library/Caches/* 2>/dev/null | sort -hr | head -10
