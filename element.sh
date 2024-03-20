#! /bin/bash

# Script to accept atomic number, symbol, or element name. Return element type and properties.

PSQL="psql -U freecodecamp -d periodic_table -t --no-align -c"

FETCHDATA() {
  if [[ $1 =~ ^[[:digit:]]+$ ]]
  then
    USE_ATOMIC_NUM $1

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

USE_ATOMIC_NUM() {

  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")

  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
    TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING (type_id) WHERE atomic_number = $1")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
}

FETCHDATA $1