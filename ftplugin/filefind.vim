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
fun! s:Help()
  redraw
  echo " G - grep file"
  echo " D - delete file"
  echo " <C-g> - grep from current filelist"
  echo " <Enter> - open file"
  return ""
endf

fun! s:GetCommand()
  return getline(1)
endf

fun! s:GetFileList()
  return getline(2,'$')
endf

fun! s:GrepFileList()
  let files = s:GetFileList()
  cal inputsave()
  let pattern = input( "pattern:" , "" )
  cal inputrestore()
  tabnew
  setlocal buftype=nofile bufhidden=wipe
  setlocal nomodifiable
  let output = system(printf('grep "%s" %s', pattern, join(files,' ') ))
  let output = substitute(output,"\r","","g")
  silent put=output
endf

fun! s:GrepFile(file)
  tabnew
  cal inputsave()
  let pattern = input( "pattern:" , "" )
  cal inputrestore()
  exec printf('vimgrep "%s" %s',pattern,a:file)
  6copen
endf

fun! s:FileFindInit()
  setlocal buftype=nofile bufhidden=wipe
  setlocal cursorline nonu
  setlocal modifiable
  syn match Command +^find\s.*$+
  hi link Command Function
  hi CursorLine ctermbg=yellow ctermfg=black
  nnoremap <buffer>  <Enter>   <C-w>gf
  nnoremap <buffer>  D         :cal delete(getline('.'))<CR>dd
  nnoremap <buffer>  G         :cal <SID>GrepFile(getline('.'))<CR>
  nnoremap <buffer>  <C-G>     :cal <SID>GrepFileList()<CR>
  nnoremap <script><buffer>  ?  :cal <SID>Help()<CR>
endf
cal s:FileFindInit()

