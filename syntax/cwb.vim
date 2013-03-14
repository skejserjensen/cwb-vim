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
syn keyword Keywords 0 tau

syn keyword Functions agent branchingeq ccs checkprop checkpropold clear closure cong contraction cwb deadlocks deadlocksobs derivatives dfstrong dftrace dfweak diveq diverges echo eq findinit findinitobs freevars game globalmc graph help init input localmc logic mayeq maypre min musteq mustpre normalform obs output pb pre precong prefixform print prop quit random relabel save set sim size sort stable states statesexp statesobs strongeq strongpre testeq testpre toggle transitions twothirdseq twothirdspre vs  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Matchs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Multiple matches is needed as a line as valid line can have whitespace or a comment after semicolon
syn match SyntaxError "[^;]\s*$"
syn match SyntaxError "[^;]\s*[\*]"

"Comments are hightlighted after syntax errors as it hides errors in lines consiting only of comemnts
syn match Comment "*.*$"

"Ensures thats ticks and are only highlighted if used to indicate coname
syn match Operators "'\ze\w"

"Arangment of these should be kept, as the escapes in BO are requiered but overwrites \ in operators
syn match BlockOperators "[ \[\] () {} ]"
syn match Operators "[. + | = \ @ $ :]"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Regions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight link Keywords Keyword
highlight link Functions Function 
highlight link SyntaxError Error 
highlight link Comment Comment 
highlight link Operators Operator 
highlight link BlockOperators Constant 

let b:current_syntax = "cwb"

