is_mac() { [[ $OSTYPE == darwin* ]] }

rainbow() {
    for code in {000..255}; do  
        print -P -- "$code: %F{$code}Blackjack%f \t $BG[$code]Blackjack %{$reset_color%}"
    done
}

zz() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}

if is_mac; then
    pman() { man $1 -t | open -f -a Preview } # open man pages in Preview

    cdf() { eval cd "`osascript -e 'tell app "Finder" to return the quoted form of the POSIX path of (target of window 1 as alias)' 2>/dev/null`" }
    vol() {
        if [[ -n $1 ]]; then osascript -e "set volume output volume $1"
        else osascript -e "output volume of (get volume settings)"
        fi
    }

    locate() { mdfind "kMDItemDisplayName == '*$@*'c" }
    mailapp() {
        if [[ -n $1 ]]; then msg=$1
        else msg=$(cat | sed -e 's/\\/\\\\/g' -e 's/\"/\\\"/g')
        fi
        osascript -e 'tell application "Mail" to make new outgoing message with properties { Content: "'$msg'", visible: true }' -e 'tell application "Mail" to activate'
    }
    quit() {
        for app in $*; do
            osascript -e 'quit app "'$app'"'
        done
    }
    relaunch() {
        for app in $*; do
            osascript -e 'quit app "'$app'"';
            sleep 2;
            open -a $app
        done
    }
    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
    alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
    alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
fi

