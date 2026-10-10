#!/usr/bin/env bash
#
# install.sh - pasang dotfiles ini ke ~/.config
#
# Pemakaian:
#   ./install.sh          # symlink (default, disarankan)
#   ./install.sh --copy   # salin file
#   ./install.sh --help   # bantuan
#
set -euo pipefail

# Folder config yang dikelola repo ini (harus sama dengan whitelist di .gitignore)
DIRS=(alacritty kitty nvim fish ghostty herdr micro)

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

usage() {
  cat <<EOF
Pasang dotfiles ke: $CONFIG_DIR
Sumber            : $DOTFILES_DIR

Pemakaian:
  ./install.sh          symlink tiap folder config (default)
  ./install.sh --copy   salin isi folder (bukan symlink)
  ./install.sh --help   tampilkan bantuan ini

Config lama yang tertimpa akan di-rename menjadi: <folder>.bak.<tanggal>
EOF
}

MODE="link"
for arg in "$@"; do
  case "$arg" in
    --copy)    MODE="copy" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Opsi tidak dikenal: $arg" >&2; usage; exit 1 ;;
  esac
done

# Jangan jalankan kalau repo sudah berada tepat di dalam target config,
# karena symlink/copy tidak diperlukan dan bisa berisiko menimpa repo.
if [ "$DOTFILES_DIR" = "$CONFIG_DIR" ]; then
  echo "Repo sudah berada di $CONFIG_DIR, tidak perlu dipasang lagi."
  exit 0
fi

mkdir -p "$CONFIG_DIR"

echo "Mode: $MODE"
echo "Dari: $DOTFILES_DIR"
echo "Ke  : $CONFIG_DIR"
echo

for d in "${DIRS[@]}"; do
  src="$DOTFILES_DIR/$d"
  dst="$CONFIG_DIR/$d"

  if [ ! -e "$src" ]; then
    echo "lewati  $d (tidak ada di repo)"
    continue
  fi

  if [ "$MODE" = "copy" ]; then
    if [ -e "$dst" ]; then
      bak="$dst.bak.$(date +%Y%m%d-%H%M%S)"
      cp -a "$dst" "$bak"
      echo "backup  $d -> $bak"
    fi
    mkdir -p "$dst"
    cp -a "$src/." "$dst/"
    echo "copy    $d"
    continue
  fi

  # MODE=link
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok      $d sudah ter-symlink"
    continue
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    bak="$dst.bak.$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$bak"
    echo "backup  $d -> $bak"
  fi

  ln -s "$src" "$dst"
  echo "link    $d -> $src"
done

echo
echo "Selesai."
echo "Langkah berikutnya:"
echo "  1. Jalankan 'nvim' -> plugin (lazy.nvim) & LSP (Mason) dipasang otomatis."
echo "  2. Install font Nerd Font (mis. FiraCode) agar ikon tampil."
echo "  3. Pengguna non-CachyOS: komentari baris cachyos di fish/config.fish."
