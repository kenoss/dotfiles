scriptencoding utf-8


" only for view mode
augroup vimrc-view-mode
  autocmd!
  autocmd VimEnter * if &readonly | nnoremap q :<C-u>qa<CR> | endif
augroup END
