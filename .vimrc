" vi 互換モード無効
set nocompatible
" filetype sniff off
filetype off
" file encoding
set encoding=utf-8
" 行番号有効化
set number
" color type
colorscheme desert
" syntax毎のカラー変化有効化
syntax on
" カーソル位置 背景色変化
set cursorline
" 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden
" 外部でファイル変更された場合で読み直す
set autoread
" コマンドラインモードでTabキーによるファイル名保管をする
set wildmenu
" 対応する括弧を強調表示
set showmatch
" タイプ途中のコマンドを画面最下行に表示
set showcmd
" ファイル編集中にスワップファイルを作成しない
set noswapfile
" ファイル保存時にバックアップファイルを作らない
set nobackup
" 不可視文字の表示記号指定
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<
" undo使用可能回数
set undolevels=1000
" インサートモードから抜けると自動的にIMEをオフにする
set imdisable
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 画面上でタブ文字が占める幅
set tabstop=2
" 自動インデントでずれる幅
set shiftwidth=2
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2

" ステータスライン表示項目
set statusline=%F%m%r%h%w 
set statusline+=[%{strlen(&fenc)?&fenc:&enc}] 
set statusline+=[%{&ff}] 
set statusline+=[line\ %l\/%L] 
set statusline+=%{fugitive#statusline()}
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set statusline+=%<%f\ {fugitive#statusline()}
" 末尾n行にステータスラインを常時表示する
set laststatus=2

"全角スペース表示
highlight zenkakuda ctermbg=7
match zenkakuda /　/

" golang setting
autocmd BufNewFile,BufRead *.go set filetype=go
" gocode
set rtp+=$GOROOT/misc/vim
if $GOPATH != ''
	" gocode
	set rtp+=$GOPATH/src/github.com/nsf/gocode/vim
	" golint
	set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
	autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
endif
" 保存時自動で:Fmtを実行
auto BufWritePre *.go Fmt
" python setting
"autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" NeoBundle
if has('vim_starting')
       set runtimepath+=~/.vim/bundle/neobundle.vim/
       call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'honza/snipmate-snippets.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'panozzaj/vim-autocorrect'
NeoBundle 'klen/python-mode'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'jiangmiao/simple-javascript-indenter'

nnoremap <silent> vp :VimShellPop<CR>

"------------ memolist ------------
let g:memolist_path = "~/Dropbox/memo"

"------------- Unite ------------
" 入力モードで開始
let g:unite_enable_start_insert=0
" 最近開いたファイル
noremap :um :Unite file_mru -buffer-name=file_mru
" register
let g:vimshell_interactive_update_time = 10
noremap :ur :Unite register -buffer-name=register
" buffer
noremap :ub :Unite buffer -buffer-name=buffer
" tab
noremap :ut :Unite tab -buffer-name=tab
"file current_dir
noremap :ufc :Unite file -buffer-name=file
noremap :ufcr :Unite file_rec -buffer-name=file_rec
"file file_current_dir
noremap :uff :UniteWithBufferDir file -buffer-name=file
noremap :uffr :UniteWithBufferDir file_rec -buffer-name=file_rec
"------------ neocomplete & neocomplcache -----------
"if neobundle#get('neocomplete')
	" neocomplete用設定
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_ignore_case = 1
	let g:neocomplete#enable_smart_case = 1
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns._ = '\h\w*'
"elseif neobundle#get('neocomplcache')
	" neocomplcache用設定 let
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_ignore_case = 1
	let g:neocomplcache_enable_smart_case = 1
	if !exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns._ = '\h\w*'
	let g:neocomplcache_enable_camel_case_completion = 1
	let g:neocomplcache_enable_underbar_completion = 1
"endif
"---------- neosnippet -----------
" C-k to select and expand a snippet from Neocomplcache popup
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" Tab to select the next field to fill in snippet
"imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
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
noremap :ssp :set spell
"auto correct無効化
noremap :nssp :set nospell
"-------vimfiler--------
"use VimFiler
noremap :e :VimFiler
"vimfiler in another window
noremap :es :VimFiler -split -simple -winwidth=20 -no-quit 
"------alias----------
"In insert mode: map C-c to Esc
imap <C-c> <Esc>
filetype plugin on
filetype indent on
