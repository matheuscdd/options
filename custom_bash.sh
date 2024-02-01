yor='yor@192.168.1.150'
alias github="git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/.git$//'"
alias copypwd="pwd | xclip -selection clipboard"
alias python="python3.10"
alias vactive="source .venv/bin/activate"
alias bat=batcat
alias vmup="VBoxManage startvm 'ubuntu_server' --type headless && Loader && ssh $yor"
alias vmdown='echo "VM "ubuntu_server" is down" && VBoxManage controlvm "ubuntu_server" acpipowerbutton'
alias vm="ssh yor@192.168.1.150"
alias update_firefox='wget "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" -O Firefox-dev.tar.bz2 && sudo tar xjf  Firefox-dev.tar.bz2 -C /opt/ && rm -r Firefox-dev.tar.bz2'
alias ..="cd .."
alias selsh="docker exec -it portal_stream_selenium_test-web-1 python manage.py"
alias porsh="docker exec -it portal_stream-web-1 python manage.py"
alias copy="xclip -selection clipboard"
alias selup="docker compose -f docker-compose.dev.test.selenium.yml -p portal_stream_selenium_test up"
alias porup="docker compose -f docker-compose.dev.yml up"
mkcd() {
  mkdir -p "$1" && cd "$1"
}
sf() {
    local curr=$(git rev-parse --abbrev-ref HEAD)
    local _date=$(date +%Y-%m-%d-\>%H_%M)
    local new="sf_$curr-$_date"
    git branch "$new"
    echo "$new"
}
Loader() {
  for i in $(seq 0 0.1 600); do
    echo -ne "\rVM \"ubuntu_server\" is loading...$i%" 
    sleep 0.1
  done
  tput cnorm 
  echo ''
}
export BAT_THEME="GitHub"
