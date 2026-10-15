-- ==========================================================================
-- Keymaps
-- ==========================================================================

-- --------------------------------------------------------------------------
-- Umum
-- Leader dinonaktifkan agar Space tidak memicu aksi bawaan, plus redo dan
-- restart Neovim.
-- --------------------------------------------------------------------------
vim.keymap.set({ "n", "v" }, "<leader>", "<nop>", { desc = "Disable leader key default" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })
-- Undo/redo gaya VSCode, bisa dipakai juga dari insert mode.
-- (Overrides default <C-z> = suspend di normal mode.)
vim.keymap.set({ "n", "i" }, "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })
vim.keymap.set({ "n", "i" }, "<C-S-z>", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set("n", "<leader>re", ":restart<CR>", { silent = true, desc = "Restart Neovim" })

-- --------------------------------------------------------------------------
-- Perpindahan antar split
-- Pindah fokus ke split kiri/bawah/atas/kanan, dan memutar susunan split.
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Move to right split" })
vim.keymap.set("n", "<leader>rr", ":wincmd r<CR>", { silent = true, desc = "Rotate split buffers" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { silent = true, desc = "Vertical split" })

-- --------------------------------------------------------------------------
-- Buffer
-- Navigasi, menutup, menyimpan, dan keluar dari buffer.
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
-- Navigasi split dari dalam terminal mode pakai Ctrl.
-- <C-\><C-n> keluar dulu dari terminal mode, baru pindah fokus ke split.
vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:wincmd h<CR>", { silent = true, desc = "Move to left split (terminal)" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n>:wincmd j<CR>", { silent = true, desc = "Move to below split (terminal)" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n>:wincmd k<CR>", { silent = true, desc = "Move to above split (terminal)" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n>:wincmd l<CR>", { silent = true, desc = "Move to right split (terminal)" })
vim.keymap.set("n", "<C-c>", ":bwipeout<CR>", { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true, noremap = true, desc = "Save current file" })
-- Simpan tanpa harus keluar dari insert mode
vim.keymap.set("i", "<C-s>", "<cmd>write<cr>", { desc = "Save file (insert mode)" })
vim.keymap.set({ "n", "t" }, "<leader>q", ":q<cr>", { silent = true, noremap = true, desc = "Quit current buffer" })

-- --------------------------------------------------------------------------
-- Clipboard
-- Yank/paste lewat register sistem, dan paste tanpa merusak isi register.
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without replacing register" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- --------------------------------------------------------------------------
-- Pergerakan & centering
-- Scroll dan hasil pencarian selalu berhenti di tengah layar.
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<S-k>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "<S-j>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })
-- Ke akhir baris (gaya Emacs/readline), bisa dari normal maupun insert mode.
vim.keymap.set({ "n", "i" }, "<C-e>", "<End>", { desc = "Go to end of line" })
-- Ke huruf pertama di awal baris (gaya Emacs/readline). Insert pakai <C-o>
-- karena tak ada key insert bawaan untuk "first non-blank".
vim.keymap.set("n", "<C-a>", "^", { desc = "Go to first character of line" })
vim.keymap.set("i", "<C-a>", "<C-o>^", { desc = "Go to first character of line" })
-- Pilih seluruh buffer (gaya VSCode Ctrl+A). <Esc> dulu supaya aman
-- dipanggil dari visual mode (kalau tidak, `V` malah membatalkan seleksi).
vim.keymap.set({ "n", "v" }, "<leader>a", "<Esc>ggVG", { silent = true, desc = "Select all" })

-- --------------------------------------------------------------------------
-- Menggeser baris (visual mode)
-- Pindahkan baris yang diseleksi naik/turun tanpa kehilangan seleksi.
-- --------------------------------------------------------------------------
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- --------------------------------------------------------------------------
-- Duplikasi & pindah baris (gaya VSCode)
-- Shift+Alt+↑/↓ = duplikat, Alt+↑/↓ = pindah (berlaku untuk baris maupun selection).
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<A-S-Down>", ":t.<CR>", { silent = true, desc = "Duplicate line down" })
vim.keymap.set("n", "<A-S-Up>", ":t-1<CR>", { silent = true, desc = "Duplicate line up" })
vim.keymap.set("v", "<A-S-Down>", "y`>p", { silent = true, desc = "Duplicate selection down" })
vim.keymap.set("v", "<A-S-Up>", "y`<P", { silent = true, desc = "Duplicate selection up" })

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Varian insert: tanpa ini Alt+Panah dipecah nvim jadi <Esc>+Panah,
-- sehingga buang ke normal mode dan cuma scroll kursor. <C-o> jalankan
-- satu perintah normal lalu balik ke insert.
vim.keymap.set("i", "<A-S-Down>", "<C-o>:t.<CR>", { silent = true, desc = "Duplicate line down" })
vim.keymap.set("i", "<A-S-Up>", "<C-o>:t-1<CR>", { silent = true, desc = "Duplicate line up" })
vim.keymap.set("i", "<A-Down>", "<C-o>:m .+1<CR><C-o>==", { silent = true, desc = "Move line down" })
vim.keymap.set("i", "<A-Up>", "<C-o>:m .-2<CR><C-o>==", { silent = true, desc = "Move line up" })

-- --------------------------------------------------------------------------
-- Hapus baris
-- <C-S-k> hapus satu baris penuh, berlaku di normal maupun insert mode.
-- (Insert pakai <C-o> supaya tetap berada di insert mode setelah dihapus.)
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<C-S-k>", "dd", { desc = "Delete line" })
vim.keymap.set("i", "<C-S-k>", "<C-o>dd", { desc = "Delete line" })

-- --------------------------------------------------------------------------
-- Membersihkan tampilan
-- Esc menghapus highlight pencarian dan semua penanda multicursor.
-- --------------------------------------------------------------------------
local multicursor_ns = vim.api.nvim_create_namespace("nvim.multicursor")
vim.keymap.set("n", "<Esc>", function()
	vim.cmd.nohlsearch()
	vim.api.nvim_buf_clear_namespace(0, multicursor_ns, 0, -1)
end, { desc = "Clear search highligts & multicursors" })

-- --------------------------------------------------------------------------
-- Lain-lain
-- Menjalankan project love2d dari buffer aktif.
-- --------------------------------------------------------------------------
vim.keymap.set("n", "<leader>lv", ":!love .<CR>", { silent = true, desc = "Run love2d project" })
