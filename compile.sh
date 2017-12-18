#!/bin/bash

###################################################################################################################################
##### Script works correctly in Ubuntu 14.04/16.04                                                                            #####
##### To install this plugin execute in jenkins machine these commands:                                                       #####
#####                                                                                                                         #####
##### wget --no-cache -N https://goo.gl/rLBxv6 -P /var/lib/jenkins/plugins --content-disposition && service jenkins force-reload #####
###################################################################################################################################

#=== Change in here!!!
URL=https://github.com/wesleits/scm-html-parameter.git
NAME="Weslei Teixeira da Silveira"
EMAIL="wesleiteixeira@hotmail.com.br"
#=====================

#=== Others
MESSAGE=$1
cd `dirname "$0"`
#================

function urlencode() 
{
  local LANG=C i c e=''
  for ((i=0;i<${#1};i++))
  do
    c=${1:$i:1}
    [[ "$c" =~ [a-zA-Z0-9\.\~\_\-] ]] || printf -v c '%%%02X' "'$c"
    e+="$c"
  done
  echo "$e"
}

function pullAndCommit 
{
  local BACKUP_BRANCH=backup_`date +%s`

  if [[ -z "$MESSAGE" ]]
  then
    MESSAGE="scripts updated"
  fi 

  git checkout -b $BACKUP_BRANCH
  git add -A
  git commit -m "$MESSAGE"
  git fetch --all
  git checkout -f master
  git merge

  if [[ -n "$isFirstTime" ]]
  then
    git checkout $BACKUP_BRANCH -- .
  else
    git merge -X theirs $BACKUP_BRANCH
  fi

  git branch -D $BACKUP_BRANCH
  git add -A
  git commit -m "$MESSAGE"
  git push
}  

if [ ! -d ".git" ]
then
  #=== Install pre requisites
  sudo apt-get update
  sudo apt-get -y install wget
  sudo apt-get -y install software-properties-common
  sudo apt-get -y install vim

  #=== Install git
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get -y install git

  #=== Install JDK 8
  sudo add-apt-repository -y ppa:webupd8team/java
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
  sudo apt-get update
  sudo apt-get install -y oracle-java8-installer
  sudo apt-get install -y oracle-java8-set-default

  #=== Install Maven
  sudo apt-get -y install maven

  #== initialize repository
  echo -e "Is the first time that you runs this script. We go configure her now!\n"
  
  while true
  do 
    read -p "Type your git username: " USERNAME
    read -p "Type your git password: " PASSWORD

    REMOTE=${URL//https\:\/\//https\:\/\/`urlencode $USERNAME`\:`urlencode $PASSWORD`\@}
  
    git init
    git remote show "$REMOTE" >&- 2>&-
    if [[ $? -eq 0 ]]
    then
      break
    else
      echo -e "Wrong username and/or password!!!\n"
    fi
  done
  
  git config --global core.editor "vim"
  git remote add origin "$REMOTE"
  git config user.name "$NAME"
  git config user.email "$EMAIL"
  
  isFirstTime="yes"
  pullAndCommit
fi

sed -i "s|<version>.*-SNAPSHOT</version>|<version>`date +%s`-SNAPSHOT</version>|g" pom.xml
rm -rf ./scm-html-parameter.hpi
rm -rf ./target
mvn clean
mvn package -DskipTests  # needs JDK 8 to compile plugin!!!!!!

#=== only push if the maven package does not to return some error
if [ $? -eq 0 ]
then
  cp ./target/scm-html-parameter.hpi ./

  pullAndCommit
fi

read