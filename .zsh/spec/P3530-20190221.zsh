#
# Configuration for WSL on Ai Laptop
#

# modify LS_COLORS only for WSL increasing visibility for OW and ST+OW directories
# Each color code is ATTR;TEXT;BG
# Attribute codes: 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes: 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes: 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

# Default
# LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

# node development
which nodenv > /dev/null && \
    eval "$(nodenv init -)"

export LS_COLORS=$LS_COLORS:'ow=4;34'

# Redirect X application to the XServer running in Windows

# for WSL1 this one
#export DISPLAY=:0.0

# f or WSL2 ip of the windows itself is different 
export DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0"

# connect to Docker Daemon running on Windows (make sure it's exposed on tcp://localhost:2375
#export DOCKER_HOST=localhost:2375

# add docker to the list of plugins
plugins+=(docker docker-compose)

setopt auto_cd
cdpath=($HOME/Projects $HOME/Projects/PULSE $HOME/Projects/ULP /mnt/c/Users/esharapov /mnt/c/Users/esharapov/Personal)

# well for whatever reason 'time hg.exe st' is 100 times haster than 'time hg st' in WSL
# plus it skips those file mode changes on Windows file system. We still want to use WSL hg for everything else
# WSL2 which we switched to is ok speedwise as long as you don't use Windows filesystem
# alias hgst="hg.exe st"

# just ridiculous that I am getting issues related to daemon for
# gradlew running when i use command line in WSL so here we will
# create a function gradlew that would take care of trying to stop
# daemons
gradlew () {
    # try to stop gradle daemons until no daemons are running
    while  [ "$(./gradlew --stop)" != "No Gradle daemons are running." ]
    do
        ./gradlew --stop; sleep 1;
    done
    # now run ./gradlew as usual
    ./gradlew $*
}

