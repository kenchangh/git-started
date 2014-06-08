# Name: Maverick Chan
# Email: guanhao3797@gmail.com
#!/bin/bash
# Generates basic files like README, LICENSE & .gitignore
# To start repository

echo -e "\nProject title?"
read title

echo -e "\nProject subtitle?"
read subtitle

# Gets the size of the title
# Corresponds with a header of same length
title_size=${#title}
subtitle_size=${#subtitle}

header=""
subheader=""

for i in $(seq "$title_size"); do
  header=$header"="
done

for i in $(seq "$subtitle_size"); do
  subheader=$subheader"-"
done

echo -e "\nSoftware used? (Type 'done' to stop)"
read software

software_arr=()

while true; do
  # Breaks and ignores rest of loop on 'done'
  if [ "$software" == "done" ]; then
    break
  fi
  
  # Adds newly-read $software into array
  software_arr+=("$software")

  # Prompts for next software
  echo -e "\nAnymore?"
  read software
done

# Array of software
software_arr=("${software_arr[@]}")

# It's odd why I can't add newlines into $readme1
# So I'm adding them here
software_list="\n\n"

# Iterates through software array and makes nicely formatted list
for i in "${software_arr[@]}"; do
  # Concatenates previous item with next
  software_list=$software_list"- $i\n"
  
  # Makes assignment permanent
  set $software_list
done

# First section, added $title
readme1=$(cat <<- EOF
	$title
	$header

$subtitle
$subheader

###Table of Content
- [Introduction](#intro)
- [Installation](#install)
- [Usage](#usage)
- [Software Used](#software)
- [License](#license)
- [Support](#support)

	###Introduction<a name='intro'></a>

	###Installation<a name='install'></a>

	###Usage<a name='usage'></a>
	
	###Software Used<a name='software'></a>
	
EOF
)

readme2=$(cat <<- EOF

###License<a name='license'></a>
The following code is released under the MIT license. See above for it.

	###Support<a name='support'></a>
	If you have any questions/concerns, please feel free to contact me.
	My email address is guanhao3797@gmail.com

**Will update README once project is more substantial.**
EOF
)

# Concatenates first, second and software section into $readme
readme=$readme1$software_list$readme2

# Does pretty-printing of $readme with newlines
# Added newline for brevity
echo -e "\n$readme\n"

# Gets present working directory and stringifies it
pwd_="`pwd`"
if [ -f $pwd_/README.md ]; then
  echo -e "ERROR: You already have a README.md!\n"
else
  echo -e "$readme" > README.md
  echo "README.md generated."
fi

# Copies the LICENSE into repo
cp ~/Desktop/git-started/LICENSE $pwd_/LICENSE

# Checks what type of gitignore is needed and queries GitHub
echo "What .gitignore is needed? (Enter 'none' if not needed)"
read ignore_type

if [ "$ignore_type" == "none" ]; then
  echo "Okay, moving on..."

else
  ignore_type="${ignore_type^}"
  echo "Requesting for $ignore_type's .gitignore"
  wget -O .gitignore https://raw.githubusercontent.com/github/gitignore/master/$ignore_type.gitignore
fi

