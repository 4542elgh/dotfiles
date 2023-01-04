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

nmap('n', 'nzz')
nmap('N', 'Nzz')

nmap('<', '<<')
nmap('>', '>>')

nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')

----------------------------------------------------------------------------------
-- Yank/Delete in line without newline
----------------------------------------------------------------------------------
nmap("yil", '^vg_y')
nmap("dil", '^vg_d')

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
-- nmap('<Leader>c', ':let @/=\'\'<CR>')
nmap('<Leader>c', ':lua vim.notify("Try using the default keybinding < C-l >", vim.log.levels.ERROR)<CR>')

----------------------------------------------------------------------------------
-- Put register text into Ex mode
----------------------------------------------------------------------------------
nmap("<Leader>y", ':<C-R>"')

----------------------------------------------------------------------------------
-- Why not put ESC in a more comfortable place
----------------------------------------------------------------------------------
imap("jj", "<Esc>")

----------------------------------------------------------------------------------
-- Escape terminal mode with same mapping
----------------------------------------------------------------------------------
tnoremap("jj", "<C-\\><C-n>")
tnoremap("<Esc>", "noob")
