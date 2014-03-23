TwilioCall.vim
==============

TwilioCall.vim makes a phone call using Vim via [twilio](http://twilio.com/).


Setup
-----

```
let g:twiliocall_from = '+xxxxxxxx'
let g:twiliocall_sid = 'your twilio account token'
let g:twiliocall_auth_token = 'your twilio auth token'
```

Usage
-----

```
  :TwilioCall +81xxxxxxxx "message"
```

