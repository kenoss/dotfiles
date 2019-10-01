set encoding=utf-8     " internal encoding
scriptencoding utf-8

" エンコーディング {{{
set termencoding=utf-8 " ターミナルのエンコーディング
set fileencoding=utf-8 " 新規ファイルのエンコーディング
" ファイルエンコーディング
if ! (has('gui_macvim') && has('kaoriya'))
  set fileencodings=ucs-bom,utf-8,eucjp,cp932,ucs-2le,latin1,iso-2022-jp
endif
" }}}

" タブ {{{
set expandtab       " タブをスペースに展開する
set tabstop=2       " 画面上でタブ文字が占める幅
set softtabstop=2   " タブキーやバックスペースキーでカーソルが動く幅
set shiftwidth=2    " 自動インデントや <<, >> でずれる幅
set smarttab        " スマートなタブ切り替え
" }}}

" 検索 {{{
set ignorecase " 検索時に大文字・小文字を区別しない
set smartcase  " 検索パターンの大文字・小文字自動認識
set hlsearch   " 検索パターンを強調表示
set incsearch  " インクリメンタルサーチ
" }}}

" 画面表示 {{{
if ($COLORTERM ==# 'truecolor') || ($COLORTERM ==# '24bit')
  set termguicolors
else
  set t_Co=256
endif

set ambiwidth=single     " 文字幅の指定が曖昧なときは半角と見なす
set showcmd              " コマンド、及び選択範囲の表示
set noshowmode           " 【挿入】【ビジュアル】といった文字列を画面最下段に表示しない
set showmatch            " 対応する括弧を自動的に装飾して表示
set display=truncate     " 画面最下部で切り詰められたら @@@ と表示する
set laststatus=2         " ステータスラインは常に表示
set number               " 現在行の行番号を表示する
set numberwidth=4        " 行番号の幅は 3 桁
set list                 " 空白の可視化
set listchars=tab:░\ ,trail:␣,eol:⏎,extends:→,precedes:←,nbsp:¯
set showtabline=1        " tabline をタブが 2 つ以上あるときだけ表示する
set colorcolumn=141      " 141 桁目をハイライト
set cmdheight=2          " 画面最下段のコマンド表示行数
" }}}

" インデントと整形 {{{
set autoindent         " 自動インデント
set smartindent        " スマートなインデント
set textwidth=0        " 自動改行はオフ
set formatoptions+=nmM " テキスト整形オプション
set wrap               " ウィンドウの幅が足りないときは折り返す
set breakindent        " 折り返し時にインデントする
set showbreak=→\       " 折り返したときに行頭にマークを表示する
set nofixendofline     " 保存時に最終行の改行を修正しない
" 括弧付きの連番を認識する
set formatlistpat=^\\s*\\%(\\d\\+\\\|[-a-z]\\)\\%(\\\ -\\\|[]:.)}\\t]\\)\\?\\s\\+
" }}}


" keyboard wait {{{
set timeout         " キーのタイムアウト時間設定
set timeoutlen=300
set ttimeoutlen=10
" }}}


filetype plugin indent on
syntax on

set cursorline
set paste
