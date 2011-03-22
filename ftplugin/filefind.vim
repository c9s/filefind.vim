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

fun! s:FilterFileList()
  if ! exists('b:filelist')
    let b:filelist = getline('1','$')
  endif
  let pattern = input('Pattern:','')
  let newlist = filter(copy(b:filelist),'v:val =~ "'.pattern.'"')
  silent 0,$delete
  cal setline(1,newlist)
  echo "Press 'u' for undo filtered result."
endf

fun! s:FileOpen()
  let file = getline('.')
  if filereadable( file ) 
    if has('macos')
      cal system( 'open ' . file . ' & ' )
    endif
  endif
endf

fun! s:FileFindInit()
  setlocal buftype=nofile bufhidden=wipe
  setlocal cursorline nonu
  setlocal modifiable
  syn match Command +^find\s.*$+
  hi link Command Function
  hi CursorLine ctermbg=yellow ctermfg=black
  nnoremap <buffer>  <Enter>   <C-w>gf
  nnoremap <buffer>  <C-k>     <C-w>f
  nnoremap <buffer>  <C-l>     <C-w>gf
  nnoremap <buffer>  O                  :cal <SID>FileOpen()<CR>
  nnoremap <buffer>  D                  :cal delete(getline('.'))<CR>dd
  nnoremap <buffer>  <C-x>G             :cal <SID>GrepFile(getline('.'))<CR>
  nnoremap <buffer>  <C-x><C-G>         :cal <SID>GrepFileList()<CR>
  nnoremap <buffer>  <C-x><C-F>         :cal <SID>FilterFileList()<CR>
  nnoremap <script><buffer>  ?  :cal <SID>Help()<CR>
endf
cal s:FileFindInit()
