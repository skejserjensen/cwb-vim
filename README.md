# cwb.vim 
cwb.vim is very small plug-in for opening files and running commands in the Edinburgh Concurrency Workbench through Vim, as editing inside the program is so unpleasant that the bundled Emacs interactive mode is the official recommended way to use the program.

## Dependencies
The only dependence for the plug-in not including Vim and CWB itself, is the Expect program used for communicating with CWB, as CWB does not accept input directly from the command line.

## Installation
1. Installation
Either copy cwb.vim to your .vim/plugins directory, or install it using a plug-in manager like [vundle](http://github.com/gmarik/vundle)
 or [pathogen.vim](https://github.com/tpope/vim-pathogen).


2. Configuration
After the installation is completed, should a couple of variables be added to your .vimrc, although only the full path to CWB is strictly necessary, the values shown being assigned to the variables are the plug-ins default values.


```
"Path to CWB on your system, must be set for the plug-in to work.
let g:CWBPath = ""

"Path to expect on your system, it is only necessary to set this if your system do not have Which installed.
let g:ExpectPath = system("which expect")

"Name of buffer used for the output from CWB, the plug-in will clean and use the buffer if it allready exists.
g:CWBOutputBuffer = "__cwb_output__"
```

##Documentation   
The following is a listing of the commands made available by the plug-in and a short description of the functionality they provide. Cwb.vim also provides syntax highlighting for data files with the .cwb extension.

```
"Loads the file in the buffer into CWB and appends the ouput to a right vsplit
OpenInCWB

"Loads the file in the buffer into CWB, and executes an arbitrary command provided by the user 
OpenAndRunCommandInCWB

```
 
##License
The plug-in is licensed under the Vim License, a full version of this license should have been bundled with your Vim installation and can be accessed using the :help license command, it can also be found here [vim License](http://vimdoc.sourceforge.net/htmldoc/uganda.html).
