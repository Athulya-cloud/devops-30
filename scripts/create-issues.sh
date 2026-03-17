#!/bin/bash
# Creates all 30 GitHub Issues for the DevOps-30 challenge
# Run this AFTER creating the repo on GitHub
# Usage: ./scripts/create-issues.sh

set -e

REPO="devops-30"

echo "🚀 Creating GitHub Issues for DevOps-30..."
echo ""

# Check if gh is authenticated
if ! gh auth status &>/dev/null; then
    echo "❌ Not logged into GitHub CLI. Run: gh auth login"
    exit 1
fi

# Check if repo exists on GitHub
if ! gh repo view "$REPO" &>/dev/null; then
    echo "📦 Creating GitHub repo..."
    gh repo create "$REPO" --public --source=. --remote=origin --push
fi

echo "🏷️  Creating labels..."
gh label create "week-1-linux" --color "0E8A16" --description "Week 1: Linux + Scripting" --force
gh label create "week-2-docker" --color "1D76DB" --description "Week 2: Containers (Docker)" --force
gh label create "week-3-cicd" --color "D93F0B" --description "Week 3: CI/CD + GitOps" --force
gh label create "week-4-cloud" --color "7057FF" --description "Week 4: Cloud + Deploy + Observe" --force
gh label create "boss-fight" --color "FBCA04" --description "Boss fight — portfolio project" --force
gh label create "buffer" --color "C5DEF5" --description "Buffer/catch-up day" --force
gh label create "hands-on" --color "F9D0C4" --description "Hands-on exercise" --force

echo ""
echo "📝 Creating issues..."

# ============ WEEK 1: Linux + Scripting ============

gh issue create --title "Day 01: Your Terminal is Your IDE Now" --label "week-1-linux,hands-on" --body "$(cat <<'EOF'
## Day 1 — Linux Basics

**Time:** 30 min | **Theme:** Week 1 — Linux + Scripting

### Why
Every DevOps tool runs through the terminal. Fast here = fast everywhere.

### Tasks
- [ ] Open terminal, run `uname -a`
- [ ] Install OrbStack (if needed): `brew install orbstack`
- [ ] Spin up Linux container: `docker run -it ubuntu bash`
- [ ] Run: `ls`, `pwd`, `whoami`, `cat /etc/os-release`
- [ ] Create this repo on GitHub and push first commit

### Deliverable
First commit pushed to GitHub. Day 1 done.

### Scenario
> *Your manager says "SSH into staging and check logs." After today, you won't panic.*
EOF
)"

gh issue create --title "Day 02: Navigate + Manipulate Files" --label "week-1-linux,hands-on" --body "$(cat <<'EOF'
## Day 2 — File Navigation

**Time:** 30-45 min | **Theme:** Week 1 — Linux + Scripting

### Why
80% of DevOps troubleshooting is "find the file, read the file, change the file."

### Tasks
- [ ] Play [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) Levels 0-5
- [ ] Learn: `cat`, `file`, `find`, `du`, `grep`
- [ ] Save notes in `week-1-linux/day-02-bandit.md`

### Deliverable
Bandit notes pushed to repo.

### Scenario
> *Prod logs are 2GB. Can't open in VS Code. What do you do?* (`head`, `tail`, `grep`, `less`)
EOF
)"

gh issue create --title "Day 03: Permissions, Pipes, and Power" --label "week-1-linux,hands-on" --body "$(cat <<'EOF'
## Day 3 — Permissions & Pipes

**Time:** 30-45 min | **Theme:** Week 1 — Linux + Scripting

### Why
Linux permissions are why your deploy script fails with "Permission denied" at 2am.

### Tasks
- [ ] Bandit Levels 6-10
- [ ] Learn: `chmod`, `chown`, pipes (`|`), redirection (`>`, `>>`)
- [ ] Try: `cat /etc/passwd | grep root`
- [ ] Save notes in `week-1-linux/day-03-permissions.md`

### Deliverable
Notes pushed.

### Scenario
> *Deploy script won't execute. "Permission denied." Fix it.* (`chmod +x script.sh`)
EOF
)"

gh issue create --title "Day 04: Shell Scripting — Your First Automation" --label "week-1-linux,hands-on" --body "$(cat <<'EOF'
## Day 4 — Shell Scripting

**Time:** 30-45 min | **Theme:** Week 1 — Linux + Scripting

### Why
If you do something twice, script it. That's the entire DevOps philosophy.

### Tasks
- [ ] Write `week-1-linux/health-check.sh` (website health checker)
- [ ] Make it executable: `chmod +x health-check.sh`
- [ ] Run it on 3 URLs
- [ ] Commit the script + log file

### Deliverable
Working health-check script pushed to repo.

### Scenario
> *Team needs overnight uptime monitoring. You can't stare at it. What do you do?* Script it + cron.
EOF
)"

gh issue create --title "Day 05: BUFFER DAY" --label "week-1-linux,buffer" --body "$(cat <<'EOF'
## Day 5 — Buffer

Catch up on Days 1-4 or:
- [ ] Watch [Abhishek's Linux video](https://www.youtube.com/results?search_query=abhishek+veeramalla+linux+for+devops)
- [ ] Browse [r/devops](https://reddit.com/r/devops) top posts

No guilt if you rest. Buffer days are built into the plan.
EOF
)"

gh issue create --title "Day 06: Networking — Just Enough" --label "week-1-linux,hands-on" --body "$(cat <<'EOF'
## Day 6 — Networking Basics

**Time:** 30 min | **Theme:** Week 1 — Linux + Scripting

### Why
Every deployment is "put code on a server and let the internet reach it."

### Tasks
- [ ] Run: `curl -v https://tooljet.com`
- [ ] Run: `ping google.com -c 5`
- [ ] Run: `traceroute google.com`
- [ ] Check open ports in a container
- [ ] Write notes in `week-1-linux/day-06-networking.md`

### Deliverable
Networking notes pushed.

### Scenario
> *App deployed but users can't reach it. `curl` returns "Connection refused." What do you check?*
EOF
)"

gh issue create --title "Day 07: BOSS FIGHT — System Monitor Script" --label "week-1-linux,boss-fight" --body "$(cat <<'EOF'
## Day 7 — Boss Fight!

**Time:** 45 min | **Theme:** Week 1 — Linux + Scripting

### Why
Real DevOps engineers use variations of this script daily.

### Tasks
- [ ] Write `week-1-linux/system-monitor.sh` that reports:
  - Hostname + uptime
  - CPU usage
  - Memory usage
  - Disk usage
  - Public IP
  - Docker container status
- [ ] Run it and screenshot the output
- [ ] Bonus: integrate health-check from Day 4

### Deliverable
System monitor script + screenshot. **This is a portfolio piece.**

### 🏆 Week 1 Complete!
You know Linux. That alone puts you ahead of most people who "plan to learn DevOps someday."
EOF
)"

# ============ WEEK 2: Docker ============

gh issue create --title "Day 08: Why Containers Exist + First Container" --label "week-2-docker,hands-on" --body "$(cat <<'EOF'
## Day 8 — First Container

**Time:** 30 min | **Theme:** Week 2 — Docker

### Why
Before Docker, deploying meant "pray the server has the right Python version."

### Tasks
- [ ] Watch: [Docker in 100 Seconds](https://www.youtube.com/watch?v=Gjnup-PuquQ)
- [ ] Run: `docker run hello-world`
- [ ] Run: `docker run -it ubuntu bash`
- [ ] Run: `docker run -d -p 8080:80 nginx` → open localhost:8080
- [ ] Learn: `docker ps`, `docker images`, `docker stop`

### Deliverable
Notes in `week-2-docker/day-08-first-container.md`
EOF
)"

gh issue create --title "Day 09: Dockerfile — Package Your Own App" --label "week-2-docker,hands-on" --body "$(cat <<'EOF'
## Day 9 — Your First Dockerfile

**Time:** 45 min | **Theme:** Week 2 — Docker

### Why
Running others' containers is easy. Containerizing YOUR code is the real skill.

### Tasks
- [ ] Create a simple Node.js app in `week-2-docker/my-app/`
- [ ] Write a `Dockerfile` for it
- [ ] Build: `docker build -t my-devops-app .`
- [ ] Run: `docker run -d -p 3000:3000 my-devops-app`
- [ ] Open localhost:3000 and /health

### Deliverable
App + Dockerfile + screenshot pushed.
EOF
)"

gh issue create --title "Day 10: BUFFER DAY" --label "week-2-docker,buffer" --body "$(cat <<'EOF'
## Day 10 — Buffer

Catch up or watch [TechWorld with Nana — Docker Tutorial](https://www.youtube.com/results?search_query=techworld+nana+docker+tutorial).

No guilt. Buffer days are built into the plan.
EOF
)"

gh issue create --title "Day 11: Docker Compose — Multi-Container Apps" --label "week-2-docker,hands-on" --body "$(cat <<'EOF'
## Day 11 — Docker Compose

**Time:** 45 min | **Theme:** Week 2 — Docker

### Why
Real apps = app + database + cache. Compose manages them all.

### Tasks
- [ ] Create `docker-compose.yml` with app + Postgres
- [ ] `docker compose up` — watch two services spin up
- [ ] `docker compose down` to stop

### Deliverable
Compose file pushed.

### Scenario
> *Need to run the app with a database locally but don't want to install Postgres. What do you do?*
EOF
)"

gh issue create --title "Day 12: Volumes, Networks, and .env" --label "week-2-docker,hands-on" --body "$(cat <<'EOF'
## Day 12 — Data Persistence

**Time:** 30 min | **Theme:** Week 2 — Docker

### Why
Containers are ephemeral. Volumes save your data. Networks let containers talk.

### Tasks
- [ ] Stop containers, restart — verify data persists (volumes!)
- [ ] Create `.env` file, reference in compose
- [ ] Run `docker network ls` and `docker volume ls`
- [ ] Push `.env.example` (never real `.env`)

### Deliverable
Updated compose + `.env.example`
EOF
)"

gh issue create --title "Day 13: Docker Deep Dive — Optimize + Debug" --label "week-2-docker,hands-on" --body "$(cat <<'EOF'
## Day 13 — Optimization

**Time:** 30 min | **Theme:** Week 2 — Docker

### Why
Small images = fast deploys. Debug skills save you at 3am.

### Tasks
- [ ] Check image size: `docker images my-devops-app`
- [ ] Add `.dockerignore`
- [ ] Try: `docker exec -it <id> sh` (get inside container)
- [ ] Try: `docker logs <id>`, `docker stats`
- [ ] Bonus: multi-stage build

### Deliverable
Optimized Dockerfile + size comparison.
EOF
)"

gh issue create --title "Day 14: BOSS FIGHT — Dockerized Portfolio Site" --label "week-2-docker,boss-fight" --body "$(cat <<'EOF'
## Day 14 — Boss Fight!

**Time:** 45-60 min | **Theme:** Week 2 — Docker

### Why
Your portfolio IS a DevOps project. It proves the skills by being built with them.

### Tasks
- [ ] Create HTML/CSS portfolio in `week-2-docker/portfolio/`
- [ ] Dockerize with Nginx
- [ ] Docker Compose setup
- [ ] Run and screenshot

### Deliverable
Dockerized portfolio site. **This is a portfolio piece.**

### 🏆 Week 2 Complete!
You can containerize anything. That's a hireable skill.
EOF
)"

# ============ WEEK 3: CI/CD ============

gh issue create --title "Day 15: BUFFER DAY — Halfway Point!" --label "week-3-cicd,buffer" --body "$(cat <<'EOF'
## Day 15 — Buffer (Halfway!)

🎉 You're halfway! You know Linux + Docker. That alone is hireable.

- [ ] Watch: [Abhishek's CI/CD explanation](https://www.youtube.com/results?search_query=abhishek+veeramalla+cicd+explained)
- [ ] Update progress tracker in README
- [ ] Celebrate. You've been consistent for 2 weeks.
EOF
)"

gh issue create --title "Day 16: GitHub Actions — Your First Pipeline" --label "week-3-cicd,hands-on" --body "$(cat <<'EOF'
## Day 16 — First CI Pipeline

**Time:** 30 min | **Theme:** Week 3 — CI/CD

### Why
CI = every push gets tested automatically. No more "forgot to run tests."

### Tasks
- [ ] Create `.github/workflows/ci.yml`
- [ ] Make it echo info on every push
- [ ] Push and watch it run in Actions tab
- [ ] See the ✅ green checkmark

### Deliverable
Working GitHub Actions workflow.

### Scenario
> *Junior dev pushes broken code to main on Friday 5pm. How to prevent?* CI + branch protection.
EOF
)"

gh issue create --title "Day 17: CI — Build + Test Automatically" --label "week-3-cicd,hands-on" --body "$(cat <<'EOF'
## Day 17 — Build & Test in CI

**Time:** 30-45 min | **Theme:** Week 3 — CI/CD

### Why
A pipeline that doesn't test is just a fancy logger.

### Tasks
- [ ] Update CI to build Docker image
- [ ] Add health check test
- [ ] Break it on purpose — see the red ❌
- [ ] Fix it — green ✅ again

### Deliverable
CI that builds and tests.
EOF
)"

gh issue create --title "Day 18: Push Docker Image to GHCR" --label "week-3-cicd,hands-on" --body "$(cat <<'EOF'
## Day 18 — Container Registry

**Time:** 30 min | **Theme:** Week 3 — CI/CD

### Why
Build once, deploy anywhere. Registry = where "ready to deploy" images live.

### Tasks
- [ ] Add GHCR login + push to CI workflow
- [ ] Push and verify image appears in GitHub Packages
- [ ] Tag with commit SHA for versioning

### Deliverable
CI pushes image to GHCR automatically.
EOF
)"

gh issue create --title "Day 19: Branch Protection + PR Workflow" --label "week-3-cicd,hands-on" --body "$(cat <<'EOF'
## Day 19 — Branch Protection

**Time:** 30 min | **Theme:** Week 3 — CI/CD

### Why
Nobody should push directly to main. Not even you at 2am.

### Tasks
- [ ] Set up branch protection on `main`
- [ ] Require CI to pass before merge
- [ ] Create a branch, open a PR, watch CI run
- [ ] Merge after green

### Deliverable
Protected main branch + your first proper PR.
EOF
)"

gh issue create --title "Day 20: BUFFER DAY" --label "week-3-cicd,buffer" --body "$(cat <<'EOF'
## Day 20 — Buffer

Catch up on CI/CD tasks. Review your pipeline. Rest if needed.
EOF
)"

gh issue create --title "Day 21: BOSS FIGHT — Full CI/CD Pipeline" --label "week-3-cicd,boss-fight" --body "$(cat <<'EOF'
## Day 21 — Boss Fight!

**Time:** 45-60 min | **Theme:** Week 3 — CI/CD

### Why
This is the thing you draw on whiteboards in interviews.

### Tasks
- [ ] Verify full pipeline: PR → CI → Build → Test → Push Image
- [ ] Draw pipeline diagram in [Excalidraw](https://excalidraw.com/)
- [ ] Save as `week-3-cicd/pipeline-diagram.png`
- [ ] Update README with diagram

### Deliverable
Complete CI/CD pipeline + visual diagram. **This is a portfolio piece.**

### 🏆 Week 3 Complete!
You have a real CI/CD pipeline. Most devs with years of experience don't.
EOF
)"

# ============ WEEK 4: Cloud + Deploy + Observe ============

gh issue create --title "Day 22: Deploy to the Cloud" --label "week-4-cloud,hands-on" --body "$(cat <<'EOF'
## Day 22 — First Cloud Deployment

**Time:** 30-45 min | **Theme:** Week 4 — Cloud + Observability

### Why
localhost doesn't count. Real DevOps = code on the internet.

### Tasks
- [ ] Sign up for [Railway](https://railway.app/) (free tier)
- [ ] Deploy your Dockerized app
- [ ] Get a public URL
- [ ] Add URL to README

### Deliverable
Live app on the internet. Send the link to someone.
EOF
)"

gh issue create --title "Day 23: Environment Variables + Secrets" --label "week-4-cloud,hands-on" --body "$(cat <<'EOF'
## Day 23 — Secrets Management

**Time:** 30 min | **Theme:** Week 4 — Cloud + Observability

### Why
Hardcoded passwords in code = career-ending security incident.

### Tasks
- [ ] Move config to env vars in Railway
- [ ] Create `.env.example` with dummy values
- [ ] Verify app reads from env vars

### Deliverable
App using env vars, `.env.example` committed.
EOF
)"

gh issue create --title "Day 24: Monitoring — Know Before Users Do" --label "week-4-cloud,hands-on" --body "$(cat <<'EOF'
## Day 24 — Monitoring

**Time:** 30 min | **Theme:** Week 4 — Cloud + Observability

### Why
App down + you don't know = users tell you. On Twitter. Publicly.

### Tasks
- [ ] Add proper `/health` endpoint
- [ ] Set up [UptimeRobot](https://uptimerobot.com/) (free)
- [ ] Get your first "UP" notification

### Deliverable
Health endpoint + monitoring screenshot.
EOF
)"

gh issue create --title "Day 25: BUFFER DAY" --label "week-4-cloud,buffer" --body "$(cat <<'EOF'
## Day 25 — Buffer

Almost there. Catch up or rest. You've earned it.
EOF
)"

gh issue create --title "Day 26: Logs — Your 3am Best Friend" --label "week-4-cloud,hands-on" --body "$(cat <<'EOF'
## Day 26 — Structured Logging

**Time:** 30 min | **Theme:** Week 4 — Cloud + Observability

### Why
When prod breaks, logs are the only thing between you and a mental breakdown.

### Tasks
- [ ] Add structured JSON logging to your app
- [ ] Check logs in Railway
- [ ] Search for errors in logs

### Deliverable
App with structured logging.
EOF
)"

gh issue create --title "Day 27: Infrastructure as Code (Taste Test)" --label "week-4-cloud,hands-on" --body "$(cat <<'EOF'
## Day 27 — Terraform Intro

**Time:** 30 min | **Theme:** Week 4 — Cloud + Observability

### Why
Clicking buttons in cloud consoles doesn't scale. IaC = version-controlled infrastructure.

### Tasks
- [ ] Read [Terraform in 15 min](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
- [ ] Create basic `main.tf` in `week-4-cloud/`
- [ ] Understand: `plan` shows changes, `apply` makes them

### Deliverable
Notes + basic `.tf` file.
EOF
)"

gh issue create --title "Day 28: Kubernetes (Just a Taste)" --label "week-4-cloud,hands-on" --body "$(cat <<'EOF'
## Day 28 — Kubernetes Intro

**Time:** 30-45 min | **Theme:** Week 4 — Cloud + Observability

### Why
K8s runs ~80% of containerized prod workloads. Know what it does.

### Tasks
- [ ] Use [KillerCoda Playground](https://killercoda.com/playgrounds/scenario/kubernetes) (browser, zero RAM)
- [ ] Run: `kubectl get nodes`, `kubectl create deployment`, `kubectl get pods`
- [ ] Watch: [K8s in 100 Seconds](https://www.youtube.com/watch?v=PziYflu8cB8)

### Deliverable
Notes in `week-4-cloud/day-28-k8s.md`
EOF
)"

gh issue create --title "Day 29: BUFFER / Polish Day" --label "week-4-cloud,buffer" --body "$(cat <<'EOF'
## Day 29 — Final Buffer

- [ ] Fix anything incomplete
- [ ] Polish your GitHub repo
- [ ] Update all progress trackers
- [ ] Prep for the grand finale tomorrow
EOF
)"

gh issue create --title "Day 30: THE GRAND FINALE 🎉" --label "week-4-cloud,boss-fight" --body "$(cat <<'EOF'
## Day 30 — Grand Finale!

**Time:** 60 min | **Theme:** The Capstone

### You did it.

### Tasks
- [ ] Update portfolio site with:
  - Pipeline diagram
  - Links to weekly projects
  - Live app URL
  - GitHub contribution graph
- [ ] Write `RETROSPECTIVE.md`:
  - What you learned
  - What was hardest
  - What you'd do differently
  - What's next
- [ ] Deploy portfolio to GitHub Pages / Cloudflare Pages
- [ ] Post journey on LinkedIn/Twitter
- [ ] Tag Abhishek Veeramalla — he loves this stuff

### Deliverable
Deployed portfolio + retrospective. **You are DevOps.**

### 🏆 30 Days Complete!
You went from zero to:
- ✅ Linux proficiency
- ✅ Docker containerization
- ✅ CI/CD pipelines
- ✅ Cloud deployment
- ✅ Monitoring + logging
- ✅ IaC + K8s awareness
- ✅ A portfolio proving all of it

Most people who "plan to learn DevOps" never start. You finished.
EOF
)"

echo ""
echo "✅ All 30 issues created!"
echo ""
echo "🏷️  Labels: week-1-linux, week-2-docker, week-3-cicd, week-4-cloud, boss-fight, buffer, hands-on"
echo ""
echo "🔗 View your issues: gh issue list --limit 30"
echo ""
echo "🚀 Start Day 1: close the issue when done → gh issue close 1"
