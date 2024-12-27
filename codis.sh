#!/bin/bash

clear
VERMILION='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

echo -e "${VERMILION}                             ._____________________."
echo -e "${VERMILION}                             |    ${WHITE}┏━╸┏━┓╺┳┓╻┏━┓    ${VERMILION}|"
echo -e "${WHITE}                             |    ┃  ┃ ┃ ┃┃┃┗━┓    |"
echo -e "${WHITE}                             |    ┗━╸┗━┛╺┻┛╹┗━┛    |"
echo -e "${GREEN}                             |_____________________|"
echo -e "${CYAN}                                         Made by: ${WHITE}Webdragon63"
echo -e "${WHITE}________________________________________________________________________________"
echo -e "${BLUE}  Ａ  ＭＵＬＴＩＴＨＲＥＡＤＥＤ  ＣＯＮＴＥＮＴ  ＤＩＳＣＯＶＥＲＹ  ＴＯＯＬ"
echo -e "${WHITE}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo -e "${GREEN}"

read -p "URL to discover >>" U
read -p "Wordlist to use >>" W
echo -e "${CYAN}"
rm content_discovered.txt | unbuffer python3 src/co-dis.py -u $U -w $W | tee /dev/tty | tee -a content_discovered.txt
echo -e "${WHITE}Process completed. Results saved as content_discovery.txt"
