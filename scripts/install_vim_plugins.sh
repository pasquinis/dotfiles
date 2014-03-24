#!/bin/bash

apt-get install -y git
cd ~
#### make a backup

mv ~/.vim ~/vim_`date +%y%m%d%H%M%S`
mkdir .vim

#### install pathogen
cd ~
ln -s ~/.vim/vimrc .vimrc
rm -Rf pathogen
git clone git://github.com/tpope/vim-pathogen.git pathogen
mv pathogen/autoload ~/.vim/autoload
call
cat > ~/.vim/vimrc <<END

call pathogen#infect('bundle/{}')
call pathogen#helptags()
call pathogen#infect()

END


cd .vim
git init
git add .
git commit -m "Initial commit"


###### install fugitive, for see git branch into statusline
cd ~/.vim
git submodule add git://github.com/tpope/vim-fugitive.git bundle/fugitive
git submodule init && git submodule update

###### install git-gutter for see git diff into the file
cd ~/.vim
git submodule add git://github.com/airblade/vim-gitgutter.git bundle/vim-gutter
git submodule init && git submodule update

#### install Solarize
cd ~/.vim
git submodule add  git://github.com/altercation/vim-colors-solarized.git bundle/solarized
git submodule init && git submodule update

cat >> ~/.vim/vimrc <<END

"solarized modification
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

END

echo export TERM="xterm-256color" >> ~/.bashrc


### install SuperTab
cd ~/.vim
git submodule add https://github.com/ervandew/supertab.git bundle/supertab
git submodule init && git submodule update


###### install CTRLP as suggested by Simone Pasquini
cd ~/.vim
git submodule add https://github.com/kien/ctrlp.vim.git bundle/ctrlp
git submodule init && git submodule update

cat >> ~/.vim/vimrc <<END

set runtimepath^=~/.vim/bundle/ctrlp
let g:ctrlp_custom_ignore = '\.git$\|\.tmp$\|\.work$'

END

vim -c ':helptags ~/.vim/bundle/ctrlp/doc|q!'



###### install Syntastic to check syntax inline
cd ~/.vim
git submodule add https://github.com/scrooloose/syntastic.git bundle/syntastic
git submodule init && git submodule update

cat >> ~/.vim/vimrc <<END

let g:syntastic_php_checkers=['php']

END

vim -c ':Helptags|q!'

###### install Powerline
#cd ~/.vim
#git submodule add https://github.com/Lokaltog/vim-powerline.git bundle/powerline
#git submodule init && git submodule update
#
#cat >> ~/.vim/vimrc <<END
#let g:Powerline_symbols='fancy'
#END


###### install vim-airline
cd ~/.vim
git submodule add https://github.com/bling/vim-airline.git  bundle/vim-airline
git submodule init && git submodule update

cat >> ~/.vim/vimrc <<END

"Airline setup
let g:airline_powerline_fonts = 0
let g:airline_symbols = {}
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='bubblegum'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#tab_nr_type = 1

END


###### install vim-changed
cd ~/.vim
git submodule add https://github.com/taku-o/vim-changed.git bundle/vim-changed
git submodule init && git submodule update

#cat >> ~/.vim/vimrc <<END
#let g:Powerline_symbols='fancy'
#END

###### install vim-puppet
cd ~/.vim
git submodule add https://github.com/rodjek/vim-puppet.git bundle/vim-puppet
git submodule init && git submodule update

###### install vim-markdown
cd ~/.vim
git submodule add https://github.com/plasticboy/vim-markdown.git bundle/vim-markdown
git submodule init && git submodule update

###### install vim-scala
cd ~/.vim
git submodule add https://github.com/derekwyatt/vim-scala.git bundle/vim-scala
git submodule init && git submodule update

###### configure .vimrc with custom settings
cat >> ~/.vim/vimrc <<END
set autoindent
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set incsearch
set hlsearch
set ignorecase
set smartcase
set encoding=utf-8
set showcmd
set comments=sr:/*,mb:*,ex:*/
set wildmenu
set wildmode=longest,full
set wildignore=.svn,.git
set nocompatible
set laststatus=2

"enable autoremove of trailing dots
set list listchars=tab:»·,trail:·
autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

END
