#!/bin/bash

DATE=$(date "+%Y-%m-%d %H:%M")
CURDIR=${PWD##*/}

os()
{
if [[ "$OSTYPE" =~ ^linux ]]; then
    DISTRIB=$(grep NAME /etc/*release |head -1 | cut -d"="  -f2)
    echo "To install atom for $DISTRIB visit: https://github.com/atom/atom"
fi
}

filename()
{
# creating filename for new pelican page
while true; do
    echo -e "\e[36mEnter FileName. For example "my_new_post""
    echo -e "\e[0m"
    read fname
        if [[ -z "$fname" ]] ; then
            echo -e "\e[31mFilename cannot be empty"
            echo -e "\e[0m"
        else
            break
            fi
done
}

title()
{
echo -e "\e[36mEnter Title:"
echo -e "\e[0m"
read subj

if [[ -z "$subj" ]] ; then
    echo -e "\e[31mTitle is Empty! Do you want to continious?"
    echo -e "\e[0m"
    read -p "Continue (y/n)?" choice
             case "$choice" in 
             y|Y ) echo "";;
             n|N ) title ;;
             * ) title;;
    esac
fi

}

category()
{
echo -e "\e[36mEnter Category:"
echo -e "\e[0m"
read cat

if [[ -z "$cat" ]] ; then
    echo -e "\e[31mCategory is Empty! Do you want to continious?"
    echo -e "\e[0m"
    read -p "Continue (y/n)?" choice
             case "$choice" in
             y|Y ) echo "" ;;
             n|N ) category ;;
             * ) echo "please choose "y" or "n"";;
    esac
fi

}

generate()
{
FILE=$fname".md"
echo "Title: "$subj > $FILE
echo "Date: "$DATE >> $FILE
echo "Category: "$cat >> $FILE
}

open_atom()
{
check_atom=$(which atomi > /dev/null 2>&1)
val=$?
if [[ $val -ne 0 ]] ; then
    echo "Atom is not installed" 
    os
else
atom $FILE
fi
}

func()
{
filename
title
category
generate
open_atom
}
main()
{
echo -e "\e[32mLet's Create a New Post"
echo -e "\e[0m"
DIRECTORY="content"
if [[ -d "$DIRECTORY" ]] ; then
  cd $DIRECTORY
  func
elif  [[ $CURDIR -eq $DIRECTORY ]] ; then
  func
else
  echo "content folder is not found"
  exit 0  
fi

}

main
