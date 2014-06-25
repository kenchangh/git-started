git-started() {

  vars="$@"
  echo -e "\nEnter your new Git repository's name: "
  read repo_name

  if [[ " ${vars[*]} " == *" github "* || $# -eq 0 ]]; then
    echo 'Sending requests to GitHub to create repository...'
    curl -u 'guanhao97:9f733ad9a8cca515a8c8ad3a67a6f1a9c6ec488b' https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
  fi
  
  if [[ " ${vars[*]} " == *" repo "* || $# -eq 0 ]]; then
    if [[ ! -f ~/Desktop/$repo_name ]]; then
      echo "Making repository now..."
      mkdir ~/Desktop/$repo_name
      cd ~/Desktop/$repo_name
      
      git init
    fi
  fi
    
  if [[ " ${vars[*]} " == *" basic "* || $# -eq 0 ]]; then
    bash ~/Desktop/git-started/repogenerator.sh
  fi

  git add --all :/
  echo -e "\nAdded files to Git index"
  
  echo -e "\nEnter your commit message: "
  read message
  
  git commit -m "$message"

  git remote add origin git@github.com:maverick97/$repo_name.git

  echo -e "\nPushing to GitHub..."
  git push -u origin master
}

