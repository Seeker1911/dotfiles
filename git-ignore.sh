 #just ran into this after initializing a Visual Studio project _before_
 #adding a .gitignore file (like an idiot).  
 ## I felt real dumb commiting a bunch of files I didn't need to, so the
 #commands below should do the trick.  The first two commands
 ## came from the second answer on this post:
 #http://stackoverflow.com/questions/7527982/applying-gitignore-to-committed-files

 # See the unwanted files:
 git ls-files -ci --exclude-standard

 # Remove the unwanted files: 
 git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached

 # Commit changes
 git commit -am "Removed unwanted files marked in .gitignore"

 # Push
 git push origin master # or whatever branch you're on
