" File: twiliocall.vim
" Author: Shintaro Abe
" Last Change: 21-Mar-2014.
" Version: 0.1
" WebPage: 
" Description: 
" Usage:
"
"   :TwilioCall {to} {msg}

if &cp || (exists('g:loaded_twiliocall_vim'))
  finish
endif
let g:loaded_twiliocall_vim = 1

let s:save_cpo = &cpo
set cpo&vim

exe "command!" "-nargs=*" 'TwilioCall' "call twiliocall#call_new_message(<f-args>)"


let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:

