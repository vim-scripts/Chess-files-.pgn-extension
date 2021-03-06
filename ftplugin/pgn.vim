setlocal nonumber norelativenumber
setlocal foldmethod=syntax
setlocal autoindent
setlocal nocursorline

iabbrev oo  O-O
iabbrev OO  O-O
iabbrev 00  O-O
iabbrev ooo O-O-O
iabbrev OOO O-O-O
iabbrev 000 O-O-O

inoremap <buffer> > 1-0
inoremap <buffer> < 0-1

imap <buffer> \pw ♙
imap <buffer> \pb ♟

imap <buffer> \rw ♖
imap <buffer> \rb ♜

imap <buffer> \nw ♘
imap <buffer> \nb ♞

imap <buffer> \bw ♗
imap <buffer> \bb ♝

imap <buffer> \qw ♕
imap <buffer> \qb ♛

imap <buffer> \kw ♔
imap <buffer> \kb ♚

function! s:ChessBoard(show)

   let board = "8   ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜   1   ♖ ♘ ♗ ♔ ♕ ♗ ♘ ♖\n"
      \      . "7   ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟   2   ♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙\n"
      \      . "6                     3\n"
      \      . "5                     4\n"
      \      . "4                     5\n"
      \      . "3                     6\n"
      \      . "2   ♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙   7   ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟\n"
      \      . "1   ♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖   8   ♜ ♞ ♝ ♚ ♛ ♝ ♞ ♜\n"
      \      . "\n"
      \      . "    a b c d e f g h       h g f e d c b a"

   if 'echo' == a:show

      echo board
   else
      execute "normal i0\<c-d>{\<esc>"
      execute "normal o\<esc>"
      execute 'normal o' . board . "\<esc>"
      execute "normal o0\<c-d>}\<esc>"
   endif

endfunction

command! ChessBoardEcho  call<sid>ChessBoard('echo')
command! ChessBoardPrint call<sid>ChessBoard('print')

command! -range ChessNormalize <line1>,<line2>substitute/\s\+\ze\d\+\./\r/eg

" command! -range=% Figures call tr(
" substitute/\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=\ze[a-h][1-8]/♙/gc
" substitute/[a-h][1-8]/♟/gc
" substitute/\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=R/♖/gc
" substitute/R/♜/gc
" substitute/\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=N/♘/gc
" substitute/N/♞/gc
" substitute/\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=B/♗/gc
" substitute/B/♝/gc
" substitute/\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=Q/♕/gc
" substitute/Q/♛/gc
" substitute/\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=K/♔/gc
" substitute/K/♚/gc

function! s:NumberIncrement()

   let line_number =
      \search('^[[:space:]]*[[:digit:]]\+[[:space:]]*\.\%(.\{-1,}\%([[:digit:]]\+[[:space:]]*\.\|1-0\|½-½\|1/2-1/2\|0-1\|\%(\d\..\{-}\)\@<=\*\)\)\@!',
      \'bcn',
      \line('.') - 1)

   if line_number

      let curr_line = getline(line_number)
      let curr_line = substitute(curr_line, '^[[:space:]]\+', '', '')
      let next_move_number = strpart(curr_line, 0, stridx(curr_line, '.')) + 1
      return next_move_number . '. '
   else
      return ''
   endif

endfunction

inoremap <cr> <cr><c-r>=<sid>NumberIncrement()<cr>
nnoremap o       o<c-r>=<sid>NumberIncrement()<cr>
