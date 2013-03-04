""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CWB.vim - Interacting with The Edinburgh Concurrency Workbench from within vim
" Version: 0.1
" Author: Søren Kejser Jensen <harmster.skj@gmail.com>
" Maintainer: Søren Kejser Jensen <harmster.skj@gmail.com>
" URL: kejserjensen.dk 
" Licence: This script is released under the Vim License.
" Acknowledgement: The layout used for this file was original from the AutoClose.vim plug-in
" Last modified: 03/03/2013
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prevents cwb.vim from being loaded more then once in the same Vim instance
if exists("loaded_cwb")
    finish
endif
let g:loaded_cwb = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lets the user define where CWB is located
if exists("g:CWBPath") && type(g:CWBPath) == type("")
    let s:cwbPath = g:CWBPath
    unlet g:CWBPath
endif

" Lets the user define where expect is located
if exists("g:ExpectPath") && type(g:ExpectPath) == type("")
    let s:expectPath = g:ExpectPath
    unlet g:ExpectPath
else
    " Strings from the system shell have a null byte at the end, which vim does not like
    let s:expectPath = system('which expect')
    let s:expectPath = strpart(s:expectPath, 0, strlen(s:expectPath)-1)
endif

" Lets the user define the name of the buffer used for output
if exists("g:CWBOutputBuffer") && type(g:CWBOutputBuffer) == type("")
    let s:cwbOutputBuffer = g:CWBOutputBuffer
    unlet g:CWBOutputBuffer
else
    let s:cwbOutputBuffer = "__cwb_output__"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=0 -bar OpenInCWB call s:OpenInCWB()
command! -nargs=0 -bar OpenAndRunCommandInCWB call s:OpenAndRunCommandInCWB()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Opens CWB, load's the currently opened file, and quits CWB properly after the script has run
function! s:OpenInCWB()

    call s:CheckConfiguration()
    
    let s:outputCWB = system(s:expectPath . ' -c ''spawn "' . s:cwbPath . '"; expect "Command:"; send "input \"' 
        \ . expand('%:p') . '\";\r"; expect "Command:"; send "quit;\r"; interact'' ')

    call s:WriteOutputToSplit(s:outputCWB)
endfunction

" Opens CWB, load's the currently opened file, runs the input from user as a command, and quits CWB
function! s:OpenAndRunCommandInCWB()

    call s:CheckConfiguration()

    " Use of inputsave() and inputrestore() prevents input() from consuming mapping as input
    call inputsave()
    let s:command = input("Command: ")
    call inputrestore()

    " Runs the command directly in CWB followed by semicolon as CWB requires one or more after each command
    let s:outputCWB = system(s:expectPath . ' -c ''spawn "' . s:cwbPath . '"; expect "Command:"; send "input \"' 
        \ . expand('%:p') . '\";\r"; expect "Command:"; send "' . s:command . ';\r"; expect "Command:"; 
        \ send "quit;\r"; interact'' ')

    call s:WriteOutputToSplit(s:outputCWB)
endfunction


" Ensures that the configuration variables are set
function! s:CheckConfiguration()
    
    if !exists("s:cwbPath")
        echoerr "ERROR: path of the Edinburgh Concurrency Workbench is not set."
        finish
    endif 

    if strlen(s:expectPath) == 0
        echoerr "ERROR: path of expect is not set, and could not be found automatically."
        finish
    endif 

    if !exists("s:cwbOutputBuffer")
        echoerr "ERROR: a name for the output buffer was not defined."
        finish
    endif 

endfunction

" Creates a split and prints the contents of inputString to it
function! s:WriteOutputToSplit(inputString)

    " Get the number of the currently active buffer
    let bufnum = bufnr('%')
    
    " If the buffer already exists then we presume it is by an earlier call of this script and reuses it
    if (bufexists(s:cwbOutputBuffer) == 0)
        exec 'rightbelow vsplit! '.s:cwbOutputBuffer 
    else
        exec 'silent! bwipeout! '.s:cwbOutputBuffer 
        exec 'rightbelow vsplit! '.s:cwbOutputBuffer 
    endif

    call append(0, split(a:inputString, '\r\n'))

    " Switch focus back to previous buffer
    exec bufnum . 'wincmd w'

endfunction
