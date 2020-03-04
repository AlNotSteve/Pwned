#!/bin/bash

set x

declutter(){
	rm breach.json
	rm semibreach.json
	rm breach.txt
	rm pasteacc.json
	rm semipaste.json
	rm pasteacc.txt
}

header(){
	
echo "  ___                     _   ___  ";
echo " | _ \__ __ ___ _  ___ __| | |__ \ ";
echo " |  _/\ V  V / ' \/ -_) _\` |   /_/ ";
echo " |_|   \_/\_/|_||_\___\__,_|  (_)  ";
echo "                                  ";
 
}

main(){
	clear
header
echo "Enter your Email Address (For eg xyz@mail.com)"
read EMAIL
echo "Enter HIBP API Key"
read HIBPKEY
echo ""
echo "Checking if you have been Pwned"
curl -s -o breach.json "https://haveibeenpwned.com/api/v3/breachedaccount/$EMAIL" -H "hibp-api-key:$HIBPKEY"
curl -s -o pasteacc.json "https://haveibeenpwned.com/api/v3/pasteaccount/$EMAIL" -H "hibp-api-key:$HIBPKEY"

clear
jq ".[]" breach.json > semibreach.json 
jq .Name semibreach.json > breach.txt
jq ".[]" pasteacc.json > semipaste.json 
jq .Name semipaste.json > pasteacc.txt
header
echo ""
echo ""
echo  -e "\e[1;97;44mYou Have Been Pwned at :\e[1;92;49m"
sed 's/\"//g' breach.txt
echo -e "\e[1;97;44mYou have been featured in these Pastes :\e[1;92;49m"
sed 's/\"//g' pasteacc.txt
#echo "Your Pwned Passwords are at :"
#sed 's/\"//g' pwnedpassword.txt

declutter
}

clear
main

