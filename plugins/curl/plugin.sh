# Easily make REST-like requests from the command line
alias delete='curl --silent -i -XDELETE'
alias get='curl --silent -i -XGET'
alias post='curl --silent -i -XPOST'
alias put='curl --silent -i -XPUT'

# Easy Ajax requests
alias xdelete='delete -H "X-Requested-With: XMLHttpRequest"'
alias xget='get -H "X-Requested-With: XMLHttpRequest"'
alias xpost='post -H "X-Requested-With: XMLHttpRequest"'
alias xput='put -H "X-Requested-With: XMLHttpRequest"'
