#!/bin/bash

while true
do
echo "Please enter the target address."
read -r lockVar
target1="$(cut -c 1-4 <<< "$lockVar")"
if [[ $target1 == "http" ]]; then
    echo "Please enter the target without http/https." 
else
var="$(nmap -sV -sC "$lockVar" |grep 'Not valid after')"
var1="$(cut -c 21-40 <<< "$var")"
lastvar1="$(date -d"$var1" +%Y%m%d)"

test="$(date -d 'now + 4 months')"
test2="$(date -d"$test" +%Y%m%d)"

currentdate="$(date)"
currentdate2="$(date -d"$currentdate" +%Y%m%d)"

if [[ $lastvar1 -ge $currentdate2 && $lastvar1 -le $test2 ]]; then
    echo "SSL certificate will expire soon" + "$var"
else
    echo "It seems that there is still time for the certificate to expire." + "$var"
fi  
break
fi

done
