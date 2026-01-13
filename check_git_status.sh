#!/bin/bash

# Git Upload Troubleshooting Script
# This script helps identify why files aren't uploading to GitHub

echo "🔍 Checking Git Status..."
echo "================================"

# Check current branch
echo "📌 Current Branch:"
git branch --show-current

# Check remote
echo ""
echo "📌 Remote Repository:"
git remote -v

# Check if there are uncommitted changes
echo ""
echo "📌 Uncommitted Changes:"
git status --short

# Check if there are unpushed commits
echo ""
echo "📌 Commits Not Pushed to GitHub:"
git log origin/main..HEAD --oneline

# Check last few commits
echo ""
echo "📌 Last 5 Commits:"
git log --oneline -5

# Check if .gitignore is working
echo ""
echo "📌 Ignored Files (should include build/):"
git status --ignored | grep build/

echo ""
echo "================================"
echo "✅ Analysis Complete"
echo ""
echo "💡 To push your changes to GitHub, run:"
echo "   git push origin main"
echo ""
echo "⚠️  If the build/ folder is showing as modified:"
echo "   git restore build/"
echo "   (This will discard build changes - they should be ignored)"
