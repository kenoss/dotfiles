scriptencoding utf-8


nnoremap ; :
nnoremap : ;


" Turn off dangerous key maps {{{
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" }}}


" Emacs compatible keymap {{{
inoremap <C-g> <Esc>
cnoremap <C-g> <C-c>

noremap! <C-n> <Down>
noremap! <C-p> <Up>
noremap! <C-f> <Right>
noremap! <C-b> <Left>
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-h> <Del>

noremap <C-f> <Right>
noremap <C-b> <Left>
" }}}


" hjkl move {{{
noremap J <PageDown>
noremap K <PageUp>

noremap <Space>h ^
noremap <Space>l $
" }}}


" Search {{{
nnoremap <Space>/ *
" }}}


" Window {{{
nnoremap s <Nop>
nnoremap ss <Nop>

nnoremap sq :<C-u>q<CR>
" create tab
nnoremap sc :<C-u>tabnew<CR>
" move tab focus
nnoremap sn gt
nnoremap sd gT
" split window
nnoremap s' :<C-u>split<CR>
nnoremap s" :<C-u>vsplit<CR>
" move window focus
nnoremap st <C-w>w
nnoremap sh <C-w>W
" window arrangement
nnoremap s= <C-w>=
nnoremap ss' <C-w>_
nnoremap ss" <C-w>|
" }}}
