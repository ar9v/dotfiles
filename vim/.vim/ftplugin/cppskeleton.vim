" Simple script to create a .cpp skeleton

" Fill in the lines..
" 
" setline() doesn't take newlines, hence the empty spaces
call setline(1, '#include <iostream>' )
call setline(2, 'using namespace std;')
call setline(3, ' ')
call setline(4, 'int main() {')
call setline(5, ' ')
call setline(6, '    return 0;')
call setline(7, '}')
