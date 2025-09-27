# Sample .profile for SuSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output


# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

if [ -x /usr/bin/fortune ] ; then
    echo
     # run fortune and display with boxes and lolcat
     #fortune | cowsay -ftux
     #figlet "`fortune`" | boxes -d spring | lolcat -a -s 100
     #toilet -f future -w 100 "`fortune`" | boxes -d spring | boxes -d unicornthink | boxes -d parchment | lolcat -a -s 50
     if timeout 1s xset q &>/dev/null ; then
         #ARRAY=("cividis" "cool" "cubehelix" "fruits" "inferno" "magma" "plasma" "rainbow" "rd-yl-gn" "sinebow" "spectral" "turbo" "viridis" "warm")
         #animStyle=${ARRAY[$(expr $RANDOM % 14)]}
         #toilet -f future -w $(expr $COLUMNS - $COLUMNS / 3) "`fortune -n 400`" | boxes -d spring | boxes -d unicornthink | boxes -d parchment | aa2u  | lolcrab -g $animStyle -a --speed 255 -d 2
         #toilet -f future -w $(expr $COLUMNS / 2) "`fortune -n 800`" | boxes -d spring | boxes -d unicornthink | boxes -d parchment | aa2u  
         #mbsync gmail &
         mbsync gmail > /dev/null &
         # Update notmuch
         notmuch new || true
         # Print new emails.
         notmuch show tag:unread,inbox || true
     # Only du lolcat if we are in tty
     else
         # Get email when we log in, but not in normal terminal, as that is too slow.
         #mbsync gmail ; true
         #toilet -f smmono12 -w $(expr $COLUMNS / 2) "`fortune -n 400`" | boxes -d spring | boxes -d unicornthink | boxes -d parchment | aa2u  | lolcat -a -s 50 || true
         true
     fi
    echo
fi


. ~/.bashrc

# include Mycroft commands
#source ~/.profile_mycroft
