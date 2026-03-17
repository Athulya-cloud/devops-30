# How To Do Everything (Baby Steps Edition)

> Open this file whenever you're stuck. Every step is spelled out. No shame. No Googling needed.

---

## Your Daily Routine (Copy-paste this every day)

```bash
# Step 1: Open your project
cd ~/devops-30

# Step 2: See today's task
gh issue view <DAY_NUMBER>
# Example: gh issue view 14    (this is Day 02's issue — see cheat sheet below)

# Step 3: Do the task (each day's issue tells you exactly what)

# Step 4: Save your work
git add .
git commit -m "Day XX: short description of what you did"
git push

# Step 5: Close the issue
gh issue close <ISSUE_NUMBER>
```

That's it. Every day. 5 steps.

---

## Issue Number Cheat Sheet

The issue numbers don't match the day numbers (GitHub quirk). Use this:

| Day | Issue # | Command to view |
|-----|---------|----------------|
| Day 01 | #1 | `gh issue view 1` |
| Day 02 | #14 | `gh issue view 14` |
| Day 03 | #2 | `gh issue view 2` |
| Day 04 | #15 | `gh issue view 15` |
| Day 05 | #16 | `gh issue view 16` |
| Day 06 | #3 | `gh issue view 3` |
| Day 07 | #17 | `gh issue view 17` |
| Day 08 | #18 | `gh issue view 18` |
| Day 09 | #19 | `gh issue view 19` |
| Day 10 | #4 | `gh issue view 4` |
| Day 11 | #5 | `gh issue view 5` |
| Day 12 | #20 | `gh issue view 20` |
| Day 13 | #21 | `gh issue view 21` |
| Day 14 | #22 | `gh issue view 22` |
| Day 15 | #6 | `gh issue view 6` |
| Day 16 | #23 | `gh issue view 23` |
| Day 17 | #24 | `gh issue view 24` |
| Day 18 | #7 | `gh issue view 7` |
| Day 19 | #8 | `gh issue view 8` |
| Day 20 | #9 | `gh issue view 9` |
| Day 21 | #10 | `gh issue view 10` |
| Day 22 | #25 | `gh issue view 25` |
| Day 23 | #11 | `gh issue view 11` |
| Day 24 | #12 | `gh issue view 12` |
| Day 25 | #26 | `gh issue view 26` |
| Day 26 | #13 | `gh issue view 13` |
| Day 27 | #27 | `gh issue view 27` |
| Day 28 | #28 | `gh issue view 28` |
| Day 29 | #29 | `gh issue view 29` |
| Day 30 | #30 | `gh issue view 30` |

---

## How To: Save Your Work (git add, commit, push)

### "I wrote a new file"
```bash
# 1. Check what changed
git status

# 2. Add your new file
git add week-1-linux/day-02-bandit.md
#      ^ replace with YOUR file path

# 3. Commit (save a snapshot)
git commit -m "Day 02: bandit level notes"
#                       ^ short description

# 4. Push to GitHub
git push
```

### "I changed an existing file"
```bash
# Same exact steps
git status                    # See what changed
git add .                     # Add everything that changed
git commit -m "Day 03: added permission notes"
git push
```

### "I want to add everything at once"
```bash
git add .                     # The dot means "everything"
git commit -m "Day 04: health check script"
git push
```

### "git push says rejected / failed"
```bash
git pull --rebase             # Grab any remote changes first
git push                      # Try again
```

---

## How To: Work With Issues

### See today's task
```bash
gh issue view 14              # Replace 14 with the issue number from the cheat sheet above
```

### See all open issues (what's left to do)
```bash
gh issue list
```

### Close an issue (mark day as done)
```bash
gh issue close 14             # Replace 14 with the issue number
```

### See closed issues (what you've completed)
```bash
gh issue list --state closed
```

### Reopen if you closed by mistake
```bash
gh issue reopen 14
```

---

## How To: Create Files and Folders

### Create a new folder
```bash
mkdir week-1-linux/scripts     # Creates a folder inside week-1-linux
```

### Create a new file
```bash
touch week-1-linux/day-02-bandit.md    # Creates an empty file
```

### Then open it in VS Code (or any editor)
```bash
code week-1-linux/day-02-bandit.md     # VS Code
open week-1-linux/day-02-bandit.md     # Default app
nano week-1-linux/day-02-bandit.md     # Terminal editor (simple)
```

---

## How To: Docker (OrbStack)

### Start a Linux container
```bash
docker run -it ubuntu bash
# You're now INSIDE Linux. Type 'exit' to leave.
```

### Run something in the background
```bash
docker run -d -p 8080:80 nginx
# -d = background
# -p 8080:80 = your port 8080 maps to container port 80
# Open http://localhost:8080 in your browser
```

### See what's running
```bash
docker ps
```

### Stop everything
```bash
docker stop $(docker ps -q)
```

### Remove all stopped containers (cleanup)
```bash
docker rm $(docker ps -aq)
```

---

## How To: Write Markdown Notes

Your daily notes go in `.md` files. Here's the syntax:

```markdown
# Day 02: Bandit Notes

## What I learned
- `cat` reads a file
- `find / -name "filename"` searches everywhere
- `grep "word" file.txt` finds a word in a file

## Commands I used
```
ssh bandit0@bandit.labs.overthewire.org -p 2220
cat readme
```

## What confused me
- Permissions still feel weird
- Will revisit on buffer day
```

---

## How To: Take a Screenshot and Add It

### Take screenshot on Mac
- **Whole screen:** Cmd + Shift + 3
- **Select area:** Cmd + Shift + 4
- File saves to Desktop

### Move it to your project
```bash
mv ~/Desktop/Screenshot*.png week-1-linux/day-07-screenshot.png
git add week-1-linux/day-07-screenshot.png
git commit -m "Day 07: system monitor output"
git push
```

---

## How To: Check Your Progress

### See your GitHub contribution graph
Go to: https://github.com/Athulya-cloud

### See how many days you've completed
```bash
gh issue list --state closed | wc -l
```

### See what's left
```bash
gh issue list --state open | wc -l
```

---

## Panic Buttons

### "I broke something and I don't know what"
```bash
git status          # Shows what changed
git diff            # Shows exactly what's different
```

### "I want to undo my last change (haven't committed yet)"
```bash
git checkout -- filename.txt    # Undo changes to one file
```

### "I committed but I shouldn't have"
```bash
git log --oneline -5            # See recent commits
# Then ask Claude for help. Don't panic-run commands.
```

### "Docker is eating all my RAM"
```bash
docker stop $(docker ps -q)     # Stop all containers
docker system prune              # Clean up unused stuff
```

### "I don't understand today's task"
Ask Claude: "break down Day X into baby steps for me"
That's what I'm here for. No shame.

---

## Terminal Shortcuts (Save Your Wrists)

| Shortcut | What it does |
|----------|-------------|
| **Tab** | Autocomplete file/folder names |
| **Up arrow** | Previous command |
| **Ctrl + C** | Cancel/stop current command |
| **Ctrl + L** | Clear screen |
| **Ctrl + A** | Jump to start of line |
| **Ctrl + E** | Jump to end of line |
| **Cmd + K** | Clear terminal (Ghostty) |

---

*Last updated: 2026-03-18*
*You've got this. One day at a time.*
