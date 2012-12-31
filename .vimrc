set nocompatible
filetype off
set encoding=utf-8
set number
colorscheme liquidcarbon
syntax on
set hidden
set wildmenu
set showcmd
set noswapfile
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
highlight zenkakuda ctermbg=7
match zenkakuda /　/

" python setting
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

set tabstop=4 
set shiftwidth=4 
set softtabstop=4
set expandtab
set laststatus=2

" NeoBundle
if has('vim_starting')
       set runtimepath+=~/.vim/bundle/neobundle.vim/
       call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'glidenote/memolist'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'honza/snipmate-snippets.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'panozzaj/vim-autocorrect'

"------------ memolist ------------
let g:memolist_path = "~/Dropbox/memo"

"------------- Unite ------------
" 入力モードで開始
let g:unite_enable_start_insert=0
" 最近開いたファイル
noremap :um :Unite file_mru -buffer-name=file_mru
" register
noremap :ur :Unite register -buffer-name=register
" buffer
noremap :ub :Unite buffer -buffer-name=buffer
"file current_dir
noremap :ufc :Unite file -buffer-name=file
noremap :ufcr :Unite file_rec -buffer-name=file_rec
"file file_current_dir
noremap :uff :UniteWithBufferDir file -buffer-name=file
noremap :uffr :UniteWithBufferDir file_rec -buffer-name=file_rec
"------------ neocomplcache -----------
" 補完ウィンドウの設定
set completeopt=menuone
" neocomplcache有効化

let g:neocomplcache_enable_at_startup = 1
" smart case機能(大文字が入力されるまで大文字小文字の区別無視)
let g:neocomplcache_enable_smart_case = 1
" underbar区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" 現在選択している候補を確定
inoremap <expr><C-y> neocomplcache#close_popup()
" 現在選択している候補をキャンセル
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <C-h>や<BS>を押したときに確実にポップアップを削除
inoremap <expr><C-h> neocomplcache

"---------- neosnippet -----------
" C-k to select and expand a snippet from Neocomplcache popup
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" Tab to select the next field to fill in snippet
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
      set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
"---------- vimwiki -----------
" wiki file path
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'path_html': '~/Dropbox/vimwiki/html'}]

"--------quickrun------------


"--------autocorrect-------
"auto correct有効化
noremap :s :set spell
"auto correct無効化
noremap :ns :set nospell
"-------vimfiler--------
"use VimFiler
noremap :e :VimFiler
"vimfiler in another window
noremap :es :VimFiler -split -simple -winwidth=35 -no-quit 
"------alias----------
"In insert mode: map C-c to Esc
imap <C-c> <Esc>
filetype plugin on
filetype indent on
