""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file for The Edinburgh Concurrency Workbench
" Author: Søren Kejser Jensen <harmster.skj@gmail.com>
" Maintainer: Søren Kejser Jensen <harmster.skj@gmail.com>
" URL: kejserjensen.dk 
" Licence: This script is released under the Vim License.
" Acknowledgement: The layout used for this file was original from the AutoClose.vim plug-in
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prevents cwb.vim from being loaded more then once in the same Vim instance
if exists("b:current_syntax")
    finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keywords 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn keyword Keywords agent branchingeq ccs checkprop checkpropold clear closure cong contraction cwb deadlocks deadlocksobs derivatives dfstrong dftrace dfweak diveq diverges echo eq findinit findinitobs freevars game globalmc graph help init input localmc logic mayeq maypre min musteq mustpre normalform obs output pb pre precong prefixform print prop quit random relabel save set sim size sort stable states statesexp statesobs strongeq strongpre testeq testpre toggle transitions twothirdseq twothirdspre vs  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Matchs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Regions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight link Keywords Keyword

let b:current_syntax = "cwb"

