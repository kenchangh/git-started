# Name: Maverick Chan
# Email: guanhao3797@gmail.com
#!/bin/bash
# Generates basic files like README, LICENSE & .gitignore
# To start repository

echo -e "\nProject title?"
read title

# Gets the size of the title
# Corresponds with a header of same length
title_size=${#title}

header=""

for i in $(seq "$title_size"); do
  header=$header"="
done

# First section, added $title
readme=$(cat <<- EOF
$title
$header

Table of Content
----------------
- [Introduction](#intro)
- [Installation](#install)
- [Usage](#usage)
- [License](#license)
- [Support](#support)

Introduction <a name='intro'></a>
--------------------------------

Installation <a name='install'></a>
----------------------------------

Usage <a name='usage'></a>
-------------------------

License <a name='license'</a>
----------------------------

Support <a name='support'></a>
------------------------------
If you have any questions/concerns, please feel free to contact me.
My email address is guanhao3797@gmail.com

**Will update the README when project is more substantial.**
	
EOF
)

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

