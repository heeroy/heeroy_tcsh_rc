# $FreeBSD: src/share/skel/dot.cshrc,v 1.10.2.3 2001/08/01 17:15:46 obrien Exp $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
#

alias h		history 25
alias j		jobs -l
alias ls	ls -G
alias la	ls -a
alias lf	ls -alF
alias ll	ls -lA
#alias screen	screen -U
#alias vim	"env TERM=xterm-color vim"
alias vi	vim -p
alias grep	grep -i --color=auto
alias cls	clear
alias more	most
alias less	most
alias p		ping
alias mic	make install clean
alias spn	sudo shutdown -p now
alias ssh	ssh -2
alias s		ssh
alias k		kill
alias df  df -h
alias vmbsd8	ssh 192.168.1.122
alias dt	ssh dt

# A righteous umask
umask 22

set path = (/usr/local/sbin /usr/sbin /sbin /usr/local/bin /usr/bin /bin /usr/games /usr/X11R6/bin $HOME/bin)
set correct = cmd
set autolist
set fignore=(.o\~)

setenv  savehist "100 merge"
setenv	EDITOR	vim
setenv	PAGER	most
#setenv	MORE	-e
#setenv  PAGER   less
setenv	BLOCKSIZE	M
setenv  LSCOLORS        ExGxcxdxCxegDxabagacad
#setenv  CLICOLOR	true
#setenv  CLICOLOR_FORCE	true
#setenv CC /usr/bin/cc
#setenv CXX /usr/bin/c++
#setenv HTTP_PROXY http://proxy.cycu.edu.tw:3128/
#setenv HTTP_PROXY http://proxy.csie.ncu.edu.tw:80/
#setenv HTTPS_PROXY http://proxy.cycu.edu.tw:3128/
#setenv HTTPS_PROXY http://proxy.csie.ncu.edu.tw:80/
#setenv LC_CTYPE en_US.ISO8859-1
#setenv LC_CTYPE en_US.UTF-8
setenv LC_ALL en_US.UTF-8
setenv LANG en_US.UTF-8
#setenv LC_ALL zh_TW.UTF-8
#setenv LANG zh_TW.UTF-8
#setenv LC_CTYPE zh_TW.UTF-8
#setenv TERM screen-w
#setenv TERM xterm-color
setenv TERM xterm
#setenv TERM VT100
#setenv TERM VT220

if ($?prompt) then
	# An interactive shell -- set some stuff up
#	set fignore = (*.o\~)
	set filec
	set history = 100
	set savehist = 100
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif
	if ( ! $?WINDOW ) then
        set prompt = "%{[0;1;36m%}%n%{[m%}@%{[1;33m%}%m%{[m%}[%{[1;4;32m%}%c02%{[m%}]-%{[1m%}%T%{[m%}-%{[1;31m%}%#%{[m%} "
        set prompt2 = "%R-%# "
	else
		set prompt = "%{[m%}%{[1;36m%}%n%{[m%}@%{[1;33m%}%m%{[m%}[%{[1;4;32m%}%c02%{[m%}]-%{[1m%}%T%{[m%}-%{[1;35m%}W$WINDOW%{[m%}-%{[1;31m%}%#%{[m%} "
        set prompt2 = "%R-%# "
	
	endif
endif
#dmesg -a | grep 'authentication error' | tail -1
