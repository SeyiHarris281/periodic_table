#! /bin/bash

# Script to accept atomic number, symbol, or element name. Return element type and properties.

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

FETCHDATA() {
  if [[ $1 =~ ^[[:digit:]]+$ ]]
  then
    echo -e "\nYou entered atomic num $1.\n"
  elif [[ $1 =~ ^[[:alpha:]][[:alpha:]]?$ ]]
  then
    echo -e "\nYou entered element symbol $1.\n"
  elif [[ $1 =~ ^[[:alpha:]]+$ ]]
  then
    echo -e "\nYou entered element name $1.\n"
  else
    echo -e "Please provide an element as an argument."
  fi
    
}

FETCHDATA $1