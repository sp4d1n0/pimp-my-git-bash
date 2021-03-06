if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title

PS1="$PS1"'\n'                # new line
# Color Shema
# Username
PS1="$PS1"'\[\033[0;37m\]'  	# Black Background, White Text
PS1="$PS1"'$ \u'             	# The Username

# At sign
PS1="$PS1"'\[\033[0;37m\]'	   # Black Background, White Text
PS1="$PS1"'@'             		 # at sign

# Host Name
PS1="$PS1"'\[\033[0;37m\]'   	 # Black Background, White Text
PS1="$PS1"'\h '             	 # Hostname

# Split arrow
PS1="$PS1"'\[\033[0;30;44m\]'  # Cyan Background, Black Text
PS1="$PS1"''             	  # The Arrow Symbol itself

# PWD
PS1="$PS1"'\[\033[7;34;40m\]' #
PS1="$PS1"' \w '              # current working directory

# Split arrow
PS1="$PS1"'\[\033[0;34;40m\]' # change color white
PS1="$PS1"''             	  # user@host<space>

# Rest
PS1="$PS1"'\e[0m'

if test -z "$WINELOADERNOEXEC"
then
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"

	if test -f "$COMPLETION_PATH/git-prompt.sh"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-prompt.sh"
		#PS1="$PS1"'\[\033[36m\]'  # change color to cyan
		PS1="$PS1"'\[\033[33m\]'  # change color to yellow

		# Check for repository folder
		# we will leave this for now, cuz it's not working right :(
		if git rev-parse --git-dir > /dev/null 2>&1; then
				:
					# We will add the Icon here, if we are in a git repository.
					# I guess this will be better handled in a function later on...
				  # PS1="$PS1"' '  # change color to yellow
		else
			  : # do nothing
		fi

		# Continue git bash scritp
		PS1="$PS1"'`__git_ps1`'   # bash function
    PS1="$PS1"
	fi
fi

# Everyting done, lets get back to white
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $
MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
