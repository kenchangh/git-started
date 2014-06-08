git-started() {
  echo -e "\nEnter your new GitHub repository's name: "
  read repo_name
  
  echo 'Sending requests to GitHub to create repository...'
  curl -u 'guanhao97:9f733ad9a8cca515a8c8ad3a67a6f1a9c6ec488b' https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
  
  if [[ ! -f ~/Desktop/$repo_name ]]; then
    echo "Making repository now..."
    mkdir ~/Desktop/$repo_name
  fi
    
  cd ~/Desktop/$repo_name
  
  git init
  bash ~/Desktop/git-started/repogenerator.sh
  git add --all :/
  
  echo -e "\nEnter your commit message: "
  read message
  
  git commit -m "$message"

  git remote add origin git@github.com:maverick97/$repo_name.git

  echo -e "\nPushing to GitHub..."
  git push -u origin master
}

