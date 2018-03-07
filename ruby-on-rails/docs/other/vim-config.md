# Use and configure VIM 

## Install it and first steps

If you want to use [VIM](https://www.vim.org/) to edit files is very easy to install:

```bash
sudo apt-get install vim-gtk
```

Adding `-gtk` allow to use copy paste with `"+y` and `"+p` for ubuntu, otherwise is complecate to realize copy-paste from or to VIM.

After that you can start editing a file with the following command:


```bash
vim path_to_file
```

## How use .vimrc for configuration

VIM is fully configurable, for that you can edit `~/.vimrc` and use [Vundle](https://github.com/VundleVim/Vundle.vim) to manage plugin.
To install Vundle one line is required:

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```


Below is an example of configuration file:

```vim
set nocompatible      " Necessary
filetype off          " Necessary

" Add Vundle to runtime path and install
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manage your libraries
Plugin 'gmarik/Vundle.vim'  " Necessary
" Good looking bottom
Plugin 'vim-airline/vim-airline'
" Molokai theme
Plugin 'tomasr/molokai'
" For Ruby
Plugin 'vim-ruby/vim-ruby'
" Tab completion
Plugin 'ervandew/supertab'
" For Rails
Plugin 'tpope/vim-rails.git'
" Navigation tree
Plugin 'scrooloose/nerdtree'
" Syntax highlighting for slim (to edit html file easily)
Plugin 'slim-template/vim-slim'
" Syntax highlighting for javascript coffee
Plugin 'kchmck/vim-coffee-script'
" Fuzzy finder for vim (CTRL+P)
Plugin 'kien/ctrlp.vim'

call vundle#end()            " Necessary
filetype plugin indent on    " Necessary Enable filetype-specific indenting and plugins

" Now add other configuration

set autoindent " Auto indention should be on

"Ruby stuff
" ================

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml,markdown set ai sw=2 sts=2 et
augroup END
" ================

" Syntax highlighting and theme
syntax enable

" Configs to make Molokai look great
set background=dark
let g:molokai_original=1
let g:rehash256=1
set t_Co=256
colorscheme molokai

" Show trailing whitespace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Line numbers
set nu

" Shows current status of the file
set laststatus=2

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/* 

" For slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

"Opens and closes Nerdtree
map <C-t> :NERDTreeToggle<CR>

" Highlights the areas that you search for
set hlsearch
" Searches incremetally as you type.
set incsearch

" Bar line at 99 to see linelimit
set colorcolumn=99

" Some mapping command: set Space to : and hh to quit insert mode
nmap <Space> :
imap hh <Esc>

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Moving in buffer next previous and closing one
nmap <C-k> :bnext<CR>
nmap <C-j> :bprevious<CR>
nmap <C-e> :bp<BAR>bd#<CR>

" To split line on the cursor
nmap <C-m> i<CR><ESC>

" Don't be a noob, join the no arrows key movement
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
```

Now you need to install the plugin by running:

```bash
vim +PluginInstall +qall
```

## Links to personalize your VIM

In the part above, is an example of configuration and you should modify it to your preferences. Here some links to find other plugins:

- [VimAwesome](https://vimawesome.com/);
- [A blog which present a personal config](https://janjiss.com/walkthrough-of-my-vimrc-file-for-ruby-development/);

## How learn VIM

Here come the harder part. Learning vim could be painful, but when you handle it is so rewarding and some time you could feel superheros power.
Some links to learn it:

### Learn while playing

- [Fight ninja to while learning vim](https://www.shortcutfoo.com/app/dojos/vim)
- [Vim adventure](https://vim-adventures.com/) (1st nivel free);

### Some article with tips

- [Progressivly learn VIM](http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)
- [For week to start well with VIM](https://medium.com/actualize-network/how-to-learn-vim-a-four-week-plan-cd8b376a9b85);
- [Use buffer](https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/);

### Some cheatsheet

- [Here](https://devhints.io/vim);
- [And here](http://vim.wikia.com/wiki/Best_Vim_Tips);


## Conclusion

Enjoy it and do not be scared to start it.
