""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CWB.vim - Interacting with The Edinburgh Concurrency Workbench from within vim
" Author: Søren Kejser Jensen <devel@kejserjensen.dk>
" Maintainer: Søren Kejser Jensen <devel@kejserjensen.dk>
" URL: kejserjensen.dk 
" Licence: This script is released under the Vim License.
" Acknowledgement: The layout used for this file was original from the AutoClose.vim plug-in
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets the filetype of .cwb file to cwb so syntax is loaded correctly
autocmd BufRead,BufNewFile *.cwb set filetype=cwb

