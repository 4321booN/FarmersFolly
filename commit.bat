git status
git add .
git status
set /p commitMessage=Commit Message:
git commit -m "%commitMessage%"
git push