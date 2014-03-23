" 
" Version: 0.0.1
" Author: dictav
" License: MIT

if exists('g:autoloaded_twiliocall_vim')
  finish
endif
let g:autoloaded_twiliocall_vim = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo



let s:V = vital#of('twiliocall')
let s:HTTP = s:V.import('Web.HTTP')

function s:new_message(msg)
    let rtn = s:HTTP.request('GET','http://twimlbin.com/create', { 'client' : ['curl', 'wget'], 'maxRedirect' : 0 })
    for h in rtn['header']
        if h =~ '^Location:'
            let loc = split(h,' ')[-1]
            break
        endif
    endfor

    let token = split(loc, '/')[-1]

    unlet rtn
    unlet loc

    let url = "http://twimlbin.com/" . token

    let xml = '<?xml version="1.0" encoding="UTF-8"?><Response><Say language="ja-jp" voice="man">' . a:msg . '</Say></Response>'

    let data = { 'index' : token, 'twiml' : xml }

    let rtn = s:HTTP.request('POST', 'http://twimlbin.com/save_data', { 'data' : data, 'client' : ['curl','wget'] })

    unlet data

    if rtn['status'] == 200
        return url
    else
        return -1
    endif
endfunction

function! twiliocall#call_new_message(to, msg)
    let url = s:new_message(a:msg)

    if url == -1
        echo 'could not create twiml'
    endif

    echo 'Calling...'
    let base = 'https://api.twilio.com/2010-04-01/Accounts/'
    let call_url = base . g:twiliocall_sid . '/Calls.json'
    let data = { 'To' : a:to,
                \'From' : g:twiliocall_from,
                \'Url' : url, 
                \'Method' : 'GET', 
                \'FallbackMethod' : 'GET', 
                \'StatusCallbackMethod' : 'GET', 
                \'Record' : 'false'}
    let param = { 'username' : g:twiliocall_sid,
                \'password' : g:twiliocall_auth_token,
                \'data' : data,
                \'client' : ['curl','wget'] }
    let call_rtn = s:HTTP.request('POST', call_url, param)
endfunction


" vim:set et:
