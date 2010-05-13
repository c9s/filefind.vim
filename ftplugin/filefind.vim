" FileFind Plugin
"
" Author: Cornelius <cornelius.howl@gmail.com>
" GistID: 400094
"
" File find helper for these bash/zsh functions:
"
" function f() {
"     echo "find . -type f -iname \"*$1*\""
"     find . -type f -iname "*$1*"
" }
" 
" function fv() {
"     echo "find . -type f -iname \"*$1*\"\n""`find . -type f -iname "*$1*"`" | vim -
" }
"
" Usage:
"
"   fv  pattern
"   f pattern | vim -
"



fun! s:FileFindInit()
  setlocal buftype=nofile bufhidden=wipe
  setlocal cursorline nu
  setlocal nomodifiable
  syn match Command +^find+
  hi link Command Function
  hi CursorLine ctermbg=yellow ctermfg=black
  nnoremap <buffer>  <Enter>   <C-w>gf
  nnoremap <buffer>  D         :cal delete(getline('.'))<CR>dd
endf

au filetype FileFind :cal s:FileFindInit()
