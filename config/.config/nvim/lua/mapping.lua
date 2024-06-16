--================================================================================
--     __  ______    ____  ____  _____   _____________
--    /  |/  /   |  / __ \/ __ \/  _/ | / / ____/ ___/
--   / /|_/ / /| | / /_/ / /_/ // //  |/ / / __ \__ \ 
--  / /  / / ___ |/ ____/ ____// // /|  / /_/ /___/ / 
-- /_/  /_/_/  |_/_/   /_/   /___/_/ |_/\____//____/  
--================================================================================
----------------------------------------------------------------------------------
-- The remap you dont know you need
----------------------------------------------------------------------------------
nmap(';', ':')

----------------------------------------------------------------------------------
-- Quick navigation
----------------------------------------------------------------------------------
nmap('dA', 'd$')
nmap('dI', 'd^')
nmap('yA', 'y$')
nmap('yI', 'y^')

nmap('n', 'nzz')
nmap('N', 'Nzz')

nmap('<', '<<')
nmap('>', '>>')

nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')

----------------------------------------------------------------------------------
-- Yank/Visual/Delete in line without newline
----------------------------------------------------------------------------------
nmap("yil", '^vg_y')
nmap("dil", '^vg_d')
nmap("vil", '^vg_')

----------------------------------------------------------------------------------
-- Buffer window switching
----------------------------------------------------------------------------------
nmap("<C-j>", '<C-w><Down>')
nmap("<C-k>", '<C-w><Up>')
nmap("<C-h>", '<C-w><Left>')
nmap("<C-l>", '<C-w><Right>')

----------------------------------------------------------------------------------
-- Buffer wide substitute
----------------------------------------------------------------------------------
nmap("<Leader>s", ':%s/<C-R>"//g')
nmap("<Leader>S", ':%s///g')

----------------------------------------------------------------------------------
-- Visual block substitute
----------------------------------------------------------------------------------
vmap("<Leader>s", ':s/<C-R>"//g')

----------------------------------------------------------------------------------
-- Clear last search highlight
----------------------------------------------------------------------------------
-- Should use default key binding <C-l>
nmap('<Leader>c', ':let @/=\'\'<CR>')

----------------------------------------------------------------------------------
-- Close quick fix
----------------------------------------------------------------------------------
nmap('<Leader>cc', ':cclose<CR>')

----------------------------------------------------------------------------------
-- Put register text into Ex mode
----------------------------------------------------------------------------------
nmap("<Leader>y", ':<C-R>"')

----------------------------------------------------------------------------------
-- Why not put ESC in a more comfortable place
----------------------------------------------------------------------------------
-- imap("jj", "<Esc>")

----------------------------------------------------------------------------------
-- Escape terminal mode with same mapping
----------------------------------------------------------------------------------
-- tnoremap("jj", "<C-\\><C-n>")
-- tnoremap("<Esc>", "noob")

----------------------------------------------------------------------------------
-- LSP
----------------------------------------------------------------------------------
nmap("ga", vim.lsp.buf.code_action)
nmap("gd", vim.lsp.buf.definition)
nmap("gr", vim.lsp.buf.references)
