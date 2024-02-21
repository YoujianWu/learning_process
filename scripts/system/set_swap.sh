#!/bin/sh

file="/swapfile"
if test -e "$file"; then
  echo "$file exist."
  read -p "Now we will delete it to make a new one [Y/N] : " choice
  case $choice in
  Y | y) 
	  sudo swapoff /swapfile
	  sudo rm /swapfile
	  sudo fallocate -l 2G /swapfile
	  sudo chmod 600 /swapfile
	  sudo mkswap /swapfile
	  sudo swapon /swapfile
	  ;; 
  N | n) 
	  exit 
	  ;; 
  esac  
else
  echo "$File does not exist. Now create new one"
  sudo fallocate -l 2G /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
fi
