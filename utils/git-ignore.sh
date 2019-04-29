# Removes those pesky files you forgot to put into gitignore
 ## came from the second answer on this post:
 #http://stackoverflow.com/questions/7527982/applying-gitignore-to-committed-files
 #expects a branch name
if [ -z $1 ];
    echo "must provide branch argument"
    exit
fi

 # See the unwanted files:
 git ls-files -ci --exclude-standard

 # Remove the unwanted files:
 git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached

 # Commit changes
 git commit -am "Removed unwanted files marked in .gitignore"

 # Push
 git push origin $1
