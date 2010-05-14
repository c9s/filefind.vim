
fun! s:Detect()
  let line = getline(1)
  if line =~ '^find'
    setfiletype filefind
  endif
endf

au StdinReadPost * call s:Detect()
