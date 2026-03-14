# level 0

**goal:** log into the game using SSH
**steps**:
1. connecting to server:
   ```ssh bandit0@bandit.labs.overthewire.org -p 2220```
2. authenticity of host: ```yes```
3. enter org's password when prompted: ```bandit0```

<br>
<br>

# level 0-->1

**goal:** log into bandit1 using password stores in readme file
**steps**:
1. view all files: ```ls```
2. displaying file content (the password): ```cat readme```
3. quit: ```exit```

pswd found: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If

<br>
<br>

# level 1-->2

**goal:** log into level1 and find password for the next level stored in a file called -
**steps**:
1. log into level 1: ```ssh bandit1@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If```
3. view all files: ```ls```
4. displaying file content (the password): ```cat ./-``` 
> 'cat -' doesnt work because linux expects keyboard input through that
5. quit: ```exit```

pswd found: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx

<br>
<br>

# level 2-->3

**goal:** log into level2 and find password for the next level stored in a file called --spaces in this filename--
**steps**:
1. log into level 2: ```ssh bandit2@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```263JGJPfgU6LtdEvgfWU1XP5yac29mFx```
3. view all files: ```ls```
4. displaying file content (the password): ```cat ./"--spaces in this filename--"``` 
> enclose in quotes
5. quit: ```exit```

pswd found: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx


<br>
<br>

# level 3-->4

**goal:** log into level3 and find password for the next level stored in a hidden file in the inhere directory
**steps**:
1. log into level 3: ```ssh bandit3@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx```
3. go to inhere directory: ```cd inhere```
4. display hidden file: ```ls -a```
> '-a' is to display 'all' files, even ones that start with '.'
4. displaying file content (the password): ```cat .  ..  ...Hiding-From-You``` 
5. quit: ```exit```

pswd found: 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ

<br>
<br>

# level 4-->5

**goal:** log into level4 and find password for the next level stored in the only human readable file in the inhere dr
**steps**:
1. log into level 4: ```ssh bandit4@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ```
3. go to inhere directory: ```cd inhere```
4. display files: ```ls```
5. check data type of all files: ```file ./*``` 
> './-file07: ASCII text': this is the human readable file
6. read file: ```cat  ./-file07```
7. quit: ```exit```

pswd found: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw


<br>
<br>

# level 5-->6

**goal:** log into level5 and find password for the next level stored in a file under inhere directory with 3 properties: human-readable, 1033 bytes in size, not executable
**steps**:
1. log into level 5: ```ssh bandit5@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw```
3. go to inhere directory: ```cd inhere```
4. display files: ```ls```
5. check file size of all files: ```find . -size 1033c``` 
> './maybehere07/.file2': file size is 1033 bytes
6. check if non executable: ```ls -l ./maybehere07/.file2```
>passes
7. read file: ```cat  ./maybehere07/.file2```
> its human readable. can also use ```file ./maybehere07/.file2```, it gives 'ASCII text, with very long lines (1000)', confirming human readable
8. quit: ```exit```

pswd found: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG


<br>
<br>

# level 6-->7

**goal:** log into level6 and find password for the next level stored somewhere on the server with 3 properties: owned by user bandit7, owned by group bandit6, 33 bytes in size

**steps**:
1. log into level 6: ```ssh bandit6@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```HWasnPhtq9AVKe0dmk45nxy20cvUa6EG```
3. display all files: ```ls -a```
4. find files owned by bandit7 while hiding permission denied: ```find / -user bandit7 2>/dev/null```
>displays 2 files
5. search details to narrow it down: ```find / -user bandit7 2>/dev/null | xargs ls -l | grep "bandit6"```
> '/run/user/11007'-rw-r----- 1 *bandit7 bandit6  33* Oct 14 09:26 /var/lib/dpkg/info/bandit7.password'. find owner, group and size.
7. read file: ```cat /var/lib/dpkg/info/bandit7.password```
8. quit: ```exit```

pswd found: morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj


<br>
<br>

# level 7-->8

**goal:** log into level7 and find password for the next level stored in the file data.txt next to the word millionth
**steps**:
1. log into level 7: ```ssh bandit7@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj```
3. display all files: ```ls```
4. find millionth, pswd is next to it: ```grep 'millionth' data.txt```
5. ```exit```

pswd found: dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc


<br>
<br>

# level 8-->9

**goal:** log into level7 and find password for the next level stored in the file data.txt and is the only line of text that occurs only once
**steps**:
1. log into level 7: ```ssh bandit8@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc```
3. display all files: ```ls```
4. find unique line: ```sort data.txt | uniq -u```
> sort places identical lines together, uniq -u filters out unique ones
5. ```exit```

pswd found: 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM


<br>
<br>

# level 9-->10

**goal:** log into level9 and find password for the next level stored in file data.txt in a human readable string, preceded by ‘=’ characters
**steps**:
1. log into level 7: ```ssh bandit9@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc```
3. display all files: ```ls```
4. find "=" characters: ```grep "==" data.txt```
5. now to ignore binary: ```strings data.txt | grep "=="```
6. ```exit```

pswd found: FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey


<br>
<br>

# level 10-->11

**goal:** log into level10 and find password in file data.txt which contains base64 encoded data
**steps**:
1. log into level 7: ```ssh bandit10@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey```
3. display all files: ```ls```
4. decode base64: ```base64 -d data.txt```
5. ```exit```

pswd found: dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr


<br>
<br>

# level 11-->12

**goal:** log into level11 and find password in file data.txt where all lowercase and uppercase letters have been rotated by 13 positions
**steps**:
1. log into level 7: ```ssh bandit11@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr```
3. display all files: ```ls```
4. read file and translate: ```cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'```
> this is rot13. if you are at A (1) and add 13, you get N (14). so A-M becomes N-Z and vice versa
5. ```exit```

pswd found: 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4

<br>
<br>

# level 12-->13

**goal:** log into level12 and find password in file data.txt which is a hexdump of a file that has been repeatedly compressed
**steps**:
1. log into level 12: ```ssh bandit12@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4```
3. display all files: ```ls```
4. create a folder: ```mktemp -d```
5. change directory: ```cd /tmp/tmp.sofk6pmcO8```
6. copy datafile here: ```cp ~/data.txt .```
7. rename: ```mv data.txt hexdump```
8. to work with file, convert it back to binary, reverse hexdump: ```xxd -r hexdump > binary```
9. checking file type: ```file binary```
> its gzip compressed
10. rename: ```mv binary binary.gz```
> keep unwrapping
11. ```gunzip binary.gz```
12. ```file binary```
13. ```mv binary binary.bz2```
14. ```bunzip2 binary.bz2```
15. ```file binary```
16. ```mv binary binary.gz```
17. ```gunzip binary.gz```
18. ```file binary```
19. ```mv binary binary.tar```
20. ```tar -xf binary.tar```
21. ```ls```
22. > created new file data5.bin
23. ```file data5.bin```
24. ```mv data5.bin data5.tar```
25. ```tar -xf data5.tar```
26. ```ls```
27. > created new file data6.bin
28. ```file data6.bin```
29. ```mv data6.bin data6.bz2```
30. ```bunzip2 data6.bz2```
31. ```ls```
32. ```tar -xf data6.tar```
33. ```ls```
34. ```file data8.bin```
35. ```mv data8.bin data8.gz```
36. ```gunzip data8.gz```
37. ```ls```
38. ```file data8```
39. > data8: ASCII text!!!!
40. ```cat data8```

pswd found: FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn



<br>
<br>

# level 13-->14

**goal:** log into level13 and find password in /etc/bandit_pass/bandit14 and can only be read by user bandit14
**steps**:
1. log into level 7: ```ssh bandit13@bandit.labs.overthewire.org -p 2220```
2. enter password found: ```FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn```
3. display all files: ```ls```
4. ```exit```
4. login with scp: ```scp -P 2220 bandit13@bandit.labs.overthewire.org:sshkey.private .```
5. warning said that permissions are too open so limited permissions: ```chmod 600 sshkey.private```
6. logging in using key instead of pswd: ```ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220```
7. getting pswd: ```cat /etc/bandit_pass/bandit14```
7. ```exit```

logged in as bandit14!
pswd: MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS


<br>
<br>


# level 14-->15

**goal:** so we're in level14 and password for next level can be retrieved by submitting password of the current level to port 30000 on localhost.
**steps**:
1. opening a tunnel to the service running on port 30000: ```nc localhost 30000```
2. sumbitting previous password gets us next password

pswd: 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo

<br>
<br>



# level 15 --> 16

**goal**: submit the current password to port 30001 on localhost using ssl/tls encryption.
**steps**:
1. log into level 15: ```ssh bandit15@bandit.labs.overthewire.org -p 2220```
2. enter password found: 8Z5bx6pYljS31SREuYST98S7627N60H9
3. connect using ssl: ```openssl s_client -connect localhost:30001```
4. paste current password and hit enter
5. ```exit```

password found: jUnVyS08A7Y7EnStandardSolution16

<br>
<br>


# Level 16 --> 17

**goal**: scan ports 31000-32000 to find which one speaks ssl and returns a password when given the current one
**steps**:
log into level 16: ```ssh bandit16@bandit.labs.overthewire.org -p 2220```
scan for open ports:```nmap -p 31000-32000 localhost```
connect to the ssl port: ```openssl s_client -connect localhost:31790```
> paste current password; a private ssh key will be returned.
save key to a file: ```nano /tmp/mykey``` 
set permissions: ```chmod 600 /tmp/mykey```
log into next level: ```ssh -i /tmp/mykey bandit17@localhost -p 2220```

<br>
<br>


# level 17 → 18

**goal**: find the line in passwords.new that is different from passwords.old.
**steps**:
1) log into level 17: ```ssh -i [keyfile] bandit17@bandit.labs.overthewire.org -p 2220```
2) compare files using diff: ```diff passwords.old passwords.new```
3) the password is the line marked with > (the one in .new)
4) quit: ```exit```

password found: xLYCjyCRN9SxxxxExamplePass18


<br>
<br>


# level 18 → 19

**goal**: log in to a shell that immediately exits upon login.
**steps**:
1) log into level 18: ```ssh bandit18@bandit.labs.overthewire.org -p 2220```
2) enter password: xLYCjyCRN9SxxxxExamplePass18
3) bypass the shell by sending a command directly: ```ssh bandit18@bandit.labs.overthewire.org -p 2220 "cat readme"```
4) ```exit```

password found: muS2169NAnVStandardSolution19

<br>
<br>


# level 19 → 20

**goal**: use a setuid binary to read the password file of the next level.
**steps**:
1) log into level 19: ```ssh bandit19@bandit.labs.overthewire.org -p 2220```
2) enter password: muS2169NAnVStandardSolution19
3) check available files: ```ls -l```
4) execute the binary to read bandit20's password: ```./bandit20-do cat /etc/bandit_pass/bandit20```
5) quit: ```exit```

password found: 5pS26StandardSolutionExample20

<br>
<br>


# level 20 → 21
**goal**: use a setuid binary to connect to a listener you create.
**steps**:
1) log into level 20: ```ssh bandit20@bandit.labs.overthewire.org -p 2220```
2) enter password: 5pS26StandardSolutionExample20
3) open a listener in the background on any port: ```echo "current_password" | nc -l -p 1234 &```
4) run the setuid binary to connect to your listener: ```./suconnect 1234```
5) the binary will send the current password, verify it, and return the next password
6) quit: ```exit```
