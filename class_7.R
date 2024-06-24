#Class 7

#Computational Rigor and Reproducibility 

#Keep project notes about what is going on, where the files are, where you left off, etc. 
#Have 2 backup copies of code/data/etc. 

#Tools ----
#GitHub - Documenting code/version control
#Storing big data/files - Longleaf
#Keeping Rstudio Organized - RStudio Projects 

#Version Control ----
#use git and Github - add unique identifiers to versions of one file with 
#notes about what you're changing 

#also note, git is not the same as Github

#git is a software - track file modifications
# will tell you what was added or deleted

#Github provides a graphical interface - host a copy of that file, can partially act
# as a copy of your code 
# can collaborate on Github
# do not store data or figures here 
# rules of thumb - save only the code, don't store data, don't store figures, powerpoints, etc. 

#You are a manager, git is the secretary, Github is the presentation (it projects
# what git is doing so you and your collaborators can see it)

#Storing Data ----
#Use longleaf for big data sets
#Use your computer for small data sets

#You can link GitHub with longleaf using SSH
#You're home directory of longleaf doesn't have lots of storage 
#You're project directory of longleaf does have lots of storage

#Let's put this into practice
#First, we are going to make a git repo (repository)
# any project stored in this repo will have the changes tracked, but we will tell
# it not to track the changes

#Go to GitHub > Your repositories > New > Name it, Public, check add a README file, 
# under the add .gitmore add "R" > make it 
# make a clone in your longleaf: on github > H2L2Code_2024 > code > copy SSH key 
# go into terminal > type cd ~ hit enter, then paste the SSH key, hit enter 
# go into files on Rstudio (lower right panel) and your GitHub folder should be there 

#Now, we can add more subfolders to the main folder 
# like data/ or outputs/ or scripts/
# readme.md = markdown formatting, plain-text file about what is in the folder

#Using RStudio Projects ----
#your working directory is the office, but R doesn't know where the office is - 
# so you have to tell it 
# you can tell it by saying the absolute path which starts with ~/ or C:/ 
# for example, ~/Documents/project_A/scripts/cleaning.R
# or you can tell it with a relative path which starts with ./ 

#Workflow for using git ----
#Once you've made all the changes you want to make > staging area > say that these are
# the changes I want you to note (this way it doesn't track every comma, just the 
# "final" version at the end of the session)
#Then, you push all the changes to remote repo

#when working by yourself: modify files on local machine, save changes > stage changes 
# (git add .) > commit stages changes, including a not (git commit -m "note to self") >
# push commits to the romaote branche (git push origin main)

#if you don't want to use the command line: Git tab (in upper right) > 
# select stage changes (use the checkboxes to pick) > review the diff > add a comment
# of the changes in commit > push it to the GitHub software 

#this is also how you can work from multiple computers - you can push the data to Github
# on one computer, change computers, and then pull it onto the new computer

#Rules of thumb ----
#commit often
#have clear commit notes
#commit at the end of each day at minimum 








