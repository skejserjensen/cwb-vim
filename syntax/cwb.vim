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

syn keyword Functions agent branchingeq ccs checkprop checkpropold clear closure cong contraction cwb deadlocks deadlocksobs derivatives dfstrong dftrace dfweak diveq diverges echo eq findinit findinitobs freevars game globalmc graph help init input localmc logic mayeq maypre min max musteq mustpre normalform obs output pb pre precong prefixform print prop quit random relabel save set sim size sort stable states statesexp statesobs strongeq strongpre testeq testpre toggle transitions twothirdseq twothirdspre vs  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Matchs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Multiple matches is needed as a line as valid line can have whitespace or a comment after semicolon
syn match SyntaxError "[^;]\s*$"
syn match SyntaxError "[^;]\s*[\*]"

"Comments are highlighted after syntax errors as it hides errors in lines consisting only of comments
syn match Comment "*.*$"

"Ensures thats ticks and are only highlighted if used to indicate coname
syn match Operators "'\ze\w"

"Arangment of these should be kept, as the escapes in BO are required but overwrites \ in operators
syn match BlockOperators "[ \[\] () {} ]"
syn match Operators "[. + | = \ @ $ :]"

"HACK: added to ensure that a missing semicolon is highligted with Syntax Error
" and not overwritten by BlockOperators if last char is a ending brace
syn match SyntaxError ")[^;]*$"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Regions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"String are highlighted last to override highlighting all keywords inside strings
syn region Strings start=/"/ end=/"/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight link Keywords Keyword
highlight link Functions Function 
highlight link SyntaxError Error 
highlight link Comment Comment 
highlight link Operators Operator 
highlight link BlockOperators Constant 
highlight link Strings String 

let b:current_syntax = "cwb"

