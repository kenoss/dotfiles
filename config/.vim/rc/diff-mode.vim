scriptencoding utf-8


" only for diff mode/vimdiff
if &diff
  set foldlevel=1
  nnoremap q :<C-u>qa<CR>
endif
