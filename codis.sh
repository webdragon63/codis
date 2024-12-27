#!/bin/bash

clear
VERMILION='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

echo -e "${VERMILION}                                 ┏━╸┏━┓╺┳┓╻┏━┓"
echo -e "${WHITE}                                 ┃  ┃ ┃ ┃┃┃┗━┓"
echo -e "${GREEN}                                 ┗━╸┗━┛╺┻┛╹┗━┛"
echo -e "${BLUE}  Ａ  ＭＵＬＴＩＴＨＲＥＡＤＥＤ  ＣＯＮＴＥＮＴ  ＤＩＳＣＯＶＥＲＹ  ＴＯＯＬ"
echo -e "${BLUE}                        ＦＲＯＭ  ＷＥＢＤＲＡＧＯＮ６３"
echo -e "${CYAN}--------------------------------------------------------------------------------"
echo -e "${BLUE}"

read -p "URL to discover >>" U
read -p "Wordlist to use >>" W
rm content_discovered.txt
unbuffer python3 src/co-dis.py -u $U -w $W | tee /dev/tty | tee -a content_discovered.txt
echo -e "${WHITE}Process completed. Results saved as content_discovery.txt"
