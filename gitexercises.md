# git exercises

<br>
<br>


## 1. master


```bash
git start master
git verify
```

> cloned env and verified.

<br>
<br>

## 2. commit-one-file

```bash
git add A.txt
git commit -m "Add A.txt"
git verify
```

<br>
<br>


## 3. commit-one-file-staged


```bash
git reset
git add A.txt
git commit -m "commit only A.txt"
git verify
```
>unstage both then stage A/ git reset B.txt just unstages B.txt

<br>
<br>

## 4. ignore-them


```bash
echo "*.exe" >> .gitignore
echo "*.o" >> .gitignore
echo "*.jar" >> .gitignore
echo "libraries/" >> .gitignore

git add .gitignore
git commit -m "added gitignore file"
git verify
```

<br>
<br>


## 5. chase-branch

```bash
git merge escaped
git verify
```


<br>
<br>



## 6. merge-conflict


```bash
git merge another-piece-of-work
nano equation.txt
>edit file
git add equation.txt
git merge --continue
ggit verify
```


<br>
<br>


## 7. save-your-work

> going back to half-finished work yet.

```bash

git stash
nano bug.txt
>edit file
git add bug.txt
git commit -m "fixed the bug"
git stash pop
nano bug.txt
>add line
git add .
git commit -m "finally finished original work"
git verify
```

<br>
<br>

## 8. change-branch-history (imp)

> need to move commits so that they look like they started from the `hot-bugfix` branch.
```bash
git rebase hot-bugfix
git verify
```

<br>
<br>


## 9. remove-ignored


```bash
# remove it from the index (tracking) only
git rm ignored.txt
git commit -m "untrack ignored.txt"
git verify
```

<br>
<br>


## 10. case-sensitive-filename



```bash
git mv File.txt file.txt
git commit -m "renamed"
git verify
```

<br>
<br>


## 11. fix-typo


```bash
nano file.txt
>change file
git add file.txt
git commit --amend -m "add Hello world"
git verify
```

<br>
<br>


## 12. forge-date


```bash
git commit --amend --no-edit --date="1987-07-02"
git verify
```

<br>
<br>


## 13. fix-old-typo

```bash
git rebase -i HEAD~2
#for latest 2 commits
#opens in vim, change "pick" to "edit" 
nano file.txt
git add file.txt
git commit --amend -m "add Hello world"
git rebase --continue
git verify
```