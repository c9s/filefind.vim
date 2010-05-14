
fun! s:Detect()
  let line = getline(1)
  if line =~ '^find' || filereadable(line)
    setfiletype filefind
  endif
endf

au StdinReadPost * call s:Detect()
