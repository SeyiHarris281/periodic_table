#! /bin/bash

# Script to accept atomic number, symbol, or element name. Return element type and properties.

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

FETCHDATA() {
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an arguement."
  fi
}

FETCHDATA