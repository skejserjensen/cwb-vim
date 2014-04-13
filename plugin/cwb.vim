""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CWB.vim - Interacting with The Edinburgh Concurrency Workbench from within Vim
" Author: Søren Kejser Jensen <devel@kejserjensen.dk>
" Maintainer: Søren Kejser Jensen <devel@kejserjensen.dk>
" URL: kejserjensen.dk 
" Licence: This script is released under the Vim License.
" Acknowledgement: The layout used for this file was original from the AutoClose.vim plug-in
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prevents cwb.vim from being loaded more then once in the same Vim instance
if exists("loaded_cwb")
    finish
endif
let g:loaded_cwb = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=0 -bar OpenInCWB call s:OpenInCWB()
command! -nargs=0 -bar OpenAndRunCommandInCWB call s:OpenAndRunCommandInCWB()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exported Functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Opens CWB, load's the currently opened file, and quits CWB properly after the script has run
function! s:OpenInCWB()

    call s:CheckConfiguration()
    
    let s:outputCWB = system(s:expectPath . ' -c ''spawn "' . s:cwbPath . '"; expect "Command:";  send "input \"' 
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

    " The command SIM is much simpler to run in a terminal emulator as it is interactive
    " The SIM command can be run both with and without parentheses so the regex checks for both
    let s:simCommand = matchstr(s:command, 'sim\((\w\+);*\| \w\+\);*$')
    if !empty(s:simCommand)
        call s:RunSimInCWB(s:command)
        return
    endif

    " Runs the command directly in CWB followed by semicolon as CWB requires one or more after each command
    let s:outputCWB = system(s:expectPath . ' -c ''spawn "' . s:cwbPath . '"; expect "Command:"; send "input \"' 
        \ . expand('%:p') . '\";\r"; expect "Command:"; send "' . s:command . ';\r"; expect "Command:"; 
        \ send "quit;\r"; interact'' ')

    call s:WriteOutputToSplit(s:outputCWB)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Performs the extra operations needed if user run the interactive SIM command
function! s:RunSimInCWB(simCommand)

    " We check for accesses to a graphical terminal here, as it is only needed
    " by this function, so it should be optional for the rest of the plug-in
    if strlen(s:terminalCommand) == 0
        echoerr "ERROR: path of the systems terminal emulator is not set."
        return
    endif

    " A terminal is opened with CWB running, the input file loaded, and SIM
    " mode engaged. Using a terminal for running the SIM command is simpler 
    " then sending commands between Vim and Expect, if it is possible at all.
    call system(s:terminalCommand . " " . s:expectPath . ' -c ''spawn "' . s:cwbPath .  '"; expect "Command:"; send "input \"' 
                \ . expand('%:p') . '\";\r"; expect "Command:"; send "' . a:simCommand . ';\r"; interact'' ')
endfunction

" Find a suitable terminal emulator if one is installed on the system
function! s:FindTerminalEmulator()

    " We try and find the emulator ourself instead of rallying on $TERM, as
    " the emulator currently set as default might not have the -e / -x flag
    for term in ['urxvt', 'xterm', 'gnome-terminal', 'xfce4-terminal', 'konsole']
        let s:terminalPath = system('which '. term)

        " A suitable terminal emulator is found on the system so no need to continue
        if strlen(s:terminalPath) != 0
            break
        endif 
    endfor
    
    " Strings from the system shell have a null byte at the end, which Vim does not like
    let s:terminalPath = strpart(s:terminalPath, 0, strlen(s:terminalPath)-1)

    " xfce4-terminal uses -x to the rest of the command as input, everyone else uses -e
    if strlen(s:terminalPath) == 0
        return ""
    elseif s:terminalPath =~ "xfce4-terminal"
        return s:terminalPath . " -x"
    else
        return s:terminalPath . " -e"
    endif
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup And Configuration
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
    " Strings from the system shell have a null byte at the end, which Vim does not like
    let s:expectPath = system('which expect')
    let s:expectPath = strpart(s:expectPath, 0, strlen(s:expectPath)-1)
endif

" Lets the user define where their terminal is located and what flags must be used
if exists("g:TerminalCommand") && type(g:TerminalCommand) == type("")
    let s:terminalCommand = g:TerminalCommand
    unlet g:TerminalCommand
else
    let s:terminalCommand = s:FindTerminalEmulator()
endif

" Lets the user define the name of the buffer used for output
if exists("g:CWBOutputBuffer") && type(g:CWBOutputBuffer) == type("")
    let s:cwbOutputBuffer = g:CWBOutputBuffer
    unlet g:CWBOutputBuffer
else
    let s:cwbOutputBuffer = "__cwb_output__"
endif

