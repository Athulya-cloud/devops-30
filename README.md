# DevOps Zero to Hero in 30 Days

### A hands-on, ADHD-friendly DevOps roadmap inspired by [Abhishek Veeramalla](https://github.com/iam-veeramalla)

> "The best way to learn DevOps is to do DevOps." — every SRE ever

---

## The Rules

- **30-45 min/day.** Some days 15 min. That counts.
- **Every 5th day is a buffer.** ADHD tax is real. No guilt.
- **Hands-on only.** No slides. No textbooks. You break things, you fix things.
- **Each day = 1 deliverable.** Did it? Push it. Close the issue. Done.
- **Why before what.** Every topic starts with *why it exists* before you touch it.

---

## How This Works

```
1. Each day has a GitHub Issue → do the task → close the issue
2. Push your work to the weekly folder → green squares every day
3. Boss fights on Day 7, 14, 21, 30 → these become portfolio projects
4. Interview questions after each week → you're job-ready, not just "learned stuff"
```

### Progress Tracker

| Week | Theme | Days | Status |
|------|-------|------|--------|
| 1 | Linux + Scripting | 1-7 | `[ ]` |
| 2 | Containers (Docker) | 8-14 | `[ ]` |
| 3 | CI/CD + GitOps | 15-21 | `[ ]` |
| 4 | Cloud + Deploy + Observe | 22-30 | `[ ]` |

---

## Week 1: Linux + Scripting

> *"Every server you'll ever touch runs Linux. Get comfortable here and everything else clicks."*

### Day 1 — Your Terminal is Your IDE Now
**Why:** Every DevOps tool — Docker, K8s, Terraform, CI/CD — runs through the terminal. If you're fast here, you're fast everywhere.

**Do:**
- [ ] Open your terminal. Run `uname -a`. You're on Unix already (macOS).
- [ ] Install OrbStack if you haven't: `brew install orbstack`
- [ ] Spin up a Linux container: `docker run -it ubuntu bash`
- [ ] Run: `ls`, `pwd`, `whoami`, `cat /etc/os-release`
- [ ] Exit with `exit`

**Push:** Create this repo on GitHub. Push your first commit. Day 1 done.

**Scenario:** *Your manager says "SSH into the staging server and check the logs." You need to not panic.* After today, you won't.

---

### Day 2 — Navigate + Manipulate Files
**Why:** 80% of DevOps troubleshooting is "find the file, read the file, change the file."

**Do:**
- [ ] Play [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) — Levels 0-5
- [ ] Each level = SSH into a server, find a password using terminal commands
- [ ] Commands you'll learn: `cat`, `file`, `find`, `du`, `grep`

**Push:** Save your notes/commands for each level in `week-1-linux/day-02-bandit.md`

**Scenario:** *Production logs are in `/var/log/` and the file is 2GB. You can't open it in VS Code. What do you do?* (`head`, `tail`, `grep`, `less` — you'll know after today.)

---

### Day 3 — Permissions, Pipes, and Power
**Why:** Linux permissions are why your deploy script fails with "Permission denied" at 2am.

**Do:**
- [ ] Bandit Levels 6-10
- [ ] Learn: `chmod`, `chown`, pipes (`|`), redirection (`>`, `>>`)
- [ ] Try: `cat /etc/passwd | grep root`
- [ ] Try: `echo "hello" > test.txt && cat test.txt`

**Push:** Save commands + notes in `week-1-linux/day-03-permissions.md`

**Scenario:** *You deployed a script but it won't execute. Error: "Permission denied." Fix it.* (Hint: `chmod +x script.sh`)

---

### Day 4 — Shell Scripting: Your First Automation
**Why:** If you do something twice, script it. That's the entire DevOps philosophy.

**Do:**
- [ ] Write `week-1-linux/health-check.sh`:
  ```bash
  #!/bin/bash
  # Your first DevOps script — checks if a website is alive

  URLS=("https://google.com" "https://github.com" "https://tooljet.com")
  LOG_FILE="health-log-$(date +%Y-%m-%d).txt"

  for url in "${URLS[@]}"; do
      status=$(curl -o /dev/null -s -w "%{http_code}" "$url")
      timestamp=$(date '+%Y-%m-%d %H:%M:%S')
      echo "$timestamp | $url | HTTP $status" >> "$LOG_FILE"

      if [ "$status" -eq 200 ]; then
          echo "✅ $url is UP ($status)"
      else
          echo "❌ $url is DOWN ($status)"
      fi
  done

  echo "Log saved to $LOG_FILE"
  ```
- [ ] Make it executable: `chmod +x health-check.sh`
- [ ] Run it: `./health-check.sh`

**Push:** Commit the script + the log file it generates.

**Scenario:** *Your team needs to know if the staging server goes down overnight. You can't stare at it. What do you do?* You write a script like this and cron it. (Day 6 callback!)

---

### Day 5 — BUFFER DAY
- Catch up on anything from Days 1-4
- Optional: watch [Abhishek's Linux video](https://www.youtube.com/results?search_query=abhishek+veeramalla+linux+for+devops)
- Optional: browse [r/devops](https://reddit.com/r/devops) top posts

---

### Day 6 — Networking: Just Enough to Not Be Dangerous
**Why:** Every deployment is "put code on a server and let the internet reach it." You need to understand how that works.

**Do:**
- [ ] Run and understand each:
  ```bash
  curl -v https://tooljet.com        # See HTTP request/response headers
  ping google.com -c 5               # Can I reach this server?
  traceroute google.com              # What path do packets take?
  docker run -it ubuntu bash -c "apt update && apt install -y net-tools && netstat -tlnp"  # What ports are open?
  ```
- [ ] Write `week-1-linux/day-06-networking.md` explaining what each command showed you

**Push:** Your notes + any screenshots.

**Scenario:** *App is deployed but users can't reach it. `curl` returns "Connection refused." What do you check?* (Port, firewall, is the process running?)

---

### Day 7 — BOSS FIGHT: System Monitor Script
**Why:** This is a real tool that real DevOps engineers use variations of.

**Do:**
- [ ] Write `week-1-linux/system-monitor.sh`:
  ```bash
  #!/bin/bash
  # Boss Fight: System monitoring script

  echo "=============================="
  echo "  SYSTEM REPORT — $(date)"
  echo "=============================="
  echo ""
  echo "💻 HOSTNAME: $(hostname)"
  echo "⏱️  UPTIME:$(uptime)"
  echo ""
  echo "📊 CPU USAGE:"
  top -l 1 | head -n 10
  echo ""
  echo "💾 MEMORY:"
  vm_stat | head -n 5
  echo ""
  echo "📁 DISK USAGE:"
  df -h | head -n 5
  echo ""
  echo "🌐 NETWORK:"
  echo "  Public IP: $(curl -s ifconfig.me)"
  echo ""
  echo "🐳 DOCKER STATUS:"
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || echo "  Docker not running"
  echo ""
  echo "=============================="
  ```
- [ ] Run it. Screenshot the output.
- [ ] Bonus: add the health-check from Day 4 into this script.

**Push:** Script + screenshot in README.

---

### Week 1 Interview Questions
<details>
<summary>Click to reveal — try answering before peeking</summary>

1. What's the difference between `>` and `>>` in bash?
2. How do you find all `.log` files larger than 100MB?
3. What does `chmod 755` mean? What about `644`?
4. How do you check which process is using port 8080?
5. What's the difference between `grep` and `find`?
6. How would you schedule a script to run every hour?
7. What's a pipe (`|`) and why is it useful?
8. How do you check disk usage on a Linux server?
</details>

---

## Week 2: Containers (Docker)

> *"Containers solved the 'but it works on my machine' problem. If it runs in a container, it runs everywhere."*

### Day 8 — Why Containers Exist + First Container
**Why:** Before Docker, deploying meant "pray the server has the right Python version." Containers package EVERYTHING together.

**Do:**
- [ ] Watch: [Docker in 100 Seconds — Fireship](https://www.youtube.com/watch?v=Gjnup-PuquQ)
- [ ] Run:
  ```bash
  docker run hello-world                    # Your first container
  docker run -it ubuntu bash                # Interactive Ubuntu
  docker run -d -p 8080:80 nginx            # Nginx web server
  ```
- [ ] Open `http://localhost:8080` — you're serving a website
- [ ] Run `docker ps`, `docker images`, `docker stop $(docker ps -q)`

**Push:** Notes in `week-2-docker/day-08-first-container.md`

**Scenario:** *Dev says "it works on my machine." QA says it's broken. How do containers solve this?* (Same image, same environment, everywhere.)

---

### Day 9 — Dockerfile: Package Your Own App
**Why:** Running other people's containers is easy. The real skill is containerizing YOUR code.

**Do:**
- [ ] Create `week-2-docker/my-app/app.js`:
  ```javascript
  const http = require('http');
  const server = http.createServer((req, res) => {
    if (req.url === '/health') {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ status: 'ok', timestamp: new Date().toISOString() }));
    } else {
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end('<h1>Hello from Docker! 🐳</h1><p>I built this on Day 9.</p>');
    }
  });
  server.listen(3000, () => console.log('Server running on port 3000'));
  ```
- [ ] Create `week-2-docker/my-app/Dockerfile`:
  ```dockerfile
  FROM node:20-alpine
  WORKDIR /app
  COPY app.js .
  EXPOSE 3000
  CMD ["node", "app.js"]
  ```
- [ ] Build and run:
  ```bash
  cd week-2-docker/my-app
  docker build -t my-devops-app .
  docker run -d -p 3000:3000 my-devops-app
  ```
- [ ] Open `http://localhost:3000` and `http://localhost:3000/health`

**Push:** The app, Dockerfile, and a screenshot.

---

### Day 10 — BUFFER DAY
- Catch up or rewatch [TechWorld with Nana — Docker Tutorial](https://www.youtube.com/results?search_query=techworld+nana+docker+tutorial)

---

### Day 11 — Docker Compose: Multi-Container Apps
**Why:** Real apps aren't one container. They're app + database + cache + queue. Compose manages them all.

**Do:**
- [ ] Create `week-2-docker/fullstack/docker-compose.yml`:
  ```yaml
  services:
    app:
      build: ../my-app
      ports:
        - "3000:3000"
      environment:
        - DB_HOST=db
      depends_on:
        - db
    db:
      image: postgres:16-alpine
      environment:
        POSTGRES_PASSWORD: devops123
        POSTGRES_DB: myapp
      volumes:
        - pgdata:/var/lib/postgresql/data
      ports:
        - "5432:5432"

  volumes:
    pgdata:
  ```
- [ ] Run: `docker compose up`
- [ ] Watch TWO services spin up together
- [ ] `docker compose down` to stop everything

**Push:** The compose file + notes.

**Scenario:** *You need to run the app locally with a database but don't want to install Postgres on your Mac. What do you do?* (This. Exactly this.)

---

### Day 12 — Volumes, Networks, and .env Files
**Why:** Containers are ephemeral — they die, data dies with them. Volumes save your data. Networks let containers talk.

**Do:**
- [ ] Stop and remove your containers. Start them again. Check: is your Postgres data still there? (Yes — because of the volume!)
- [ ] Create a `.env` file instead of hardcoding passwords in compose
- [ ] Run `docker network ls` — see the network Compose created
- [ ] Run `docker volume ls` — see your persistent volume

**Push:** Updated compose file + `.env.example` (never push real `.env`)

---

### Day 13 — Docker Deep Dive: Optimize + Debug
**Why:** Small images deploy faster. Knowing how to debug a container saves you at 3am.

**Do:**
- [ ] Check your image size: `docker images my-devops-app`
- [ ] Add a `.dockerignore` file (like `.gitignore` for Docker)
- [ ] Debug a running container:
  ```bash
  docker exec -it <container_id> sh    # Get inside a running container
  docker logs <container_id>            # Read container logs
  docker stats                          # Live resource usage
  ```
- [ ] Try a multi-stage build to shrink your image (Google "multi-stage Dockerfile Node.js")

**Push:** Optimized Dockerfile + size comparison screenshot.

---

### Day 14 — BOSS FIGHT: Dockerized Portfolio Site
**Why:** This becomes a real project for your portfolio AND your GitHub.

**Do:**
- [ ] Create `week-2-docker/portfolio/` with a simple HTML/CSS portfolio site
- [ ] Dockerize it with Nginx:
  ```dockerfile
  FROM nginx:alpine
  COPY . /usr/share/nginx/html
  EXPOSE 80
  ```
- [ ] Docker Compose it with any backend you want
- [ ] Run it, screenshot it, push it
- [ ] Bonus: this is the start of your actual portfolio site

**Push:** Full portfolio Docker setup. This is a portfolio project.

---

### Week 2 Interview Questions
<details>
<summary>Click to reveal</summary>

1. What's the difference between an image and a container?
2. What's a Dockerfile? Walk me through each instruction.
3. How is a container different from a VM?
4. What's Docker Compose and when would you use it?
5. How do you persist data in Docker?
6. What's a multi-stage build and why use it?
7. How do you debug a container that keeps crashing?
8. What's the difference between `CMD` and `ENTRYPOINT`?
</details>

---

## Week 3: CI/CD + GitOps

> *"CI/CD is the assembly line of software. Code goes in, tested artifacts come out. No humans in the loop."*

### Day 15 — BUFFER DAY (Halfway Point!)
- You know Linux. You know Docker. That alone is hireable.
- Watch: [Abhishek's CI/CD explanation](https://www.youtube.com/results?search_query=abhishek+veeramalla+cicd+explained)
- Reflect: update the progress tracker in this README.

---

### Day 16 — GitHub Actions: Your First Pipeline
**Why:** CI = every push gets automatically tested. No more "I forgot to run tests before merging."

**Do:**
- [ ] Create `.github/workflows/ci.yml` in this repo:
  ```yaml
  name: DevOps-30 CI
  on: [push, pull_request]

  jobs:
    hello:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - name: Hello CI
          run: |
            echo "🚀 CI Pipeline triggered!"
            echo "Branch: ${{ github.ref }}"
            echo "Commit: ${{ github.sha }}"
            echo "Author: ${{ github.actor }}"
  ```
- [ ] Push it. Go to your repo → Actions tab. Watch it run.
- [ ] See the green checkmark. That's CI.

**Push:** The workflow file. Watch Actions run.

**Scenario:** *A junior dev pushes broken code to main on Friday at 5pm. How do you prevent this?* (CI that runs tests + branch protection. You're building it this week.)

---

### Day 17 — CI: Build + Test Automatically
**Why:** A pipeline that doesn't test anything is just a fancy logger.

**Do:**
- [ ] Update `ci.yml` to build your Docker image:
  ```yaml
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - name: Build Docker image
          run: docker build -t my-devops-app ./week-2-docker/my-app
        - name: Run health check
          run: |
            docker run -d -p 3000:3000 --name test-app my-devops-app
            sleep 3
            curl -f http://localhost:3000/health || exit 1
            echo "✅ Health check passed!"
  ```
- [ ] Push. Watch it build AND test in the cloud.
- [ ] Break it on purpose (change the port). See the red X. Fix it.

**Push:** Updated workflow.

---

### Day 18 — Docker Image → GitHub Container Registry
**Why:** Build once, deploy anywhere. The registry is where your "ready to deploy" images live.

**Do:**
- [ ] Update your workflow to push to GHCR:
  ```yaml
  - name: Login to GHCR
    uses: docker/login-action@v3
    with:
      registry: ghcr.io
      username: ${{ github.actor }}
      password: ${{ secrets.GITHUB_TOKEN }}

  - name: Push to GHCR
    run: |
      docker tag my-devops-app ghcr.io/${{ github.actor }}/my-devops-app:latest
      docker push ghcr.io/${{ github.actor }}/my-devops-app:latest
  ```
- [ ] Push. Check your GitHub profile → Packages. Your image is there.

**Push:** Updated workflow.

---

### Day 19 — Branch Protection + PR Workflow
**Why:** Nobody should push directly to main. Not even you at 2am.

**Do:**
- [ ] Go to repo Settings → Branches → Add rule for `main`:
  - Require pull request before merging
  - Require status checks to pass (select your CI job)
- [ ] Create a branch: `git checkout -b feature/add-readme-update`
- [ ] Make a change, push, open a PR. Watch CI run on the PR.
- [ ] Merge only after green.

**Push:** Your first proper PR workflow.

---

### Day 20 — BUFFER DAY

---

### Day 21 — BOSS FIGHT: Full CI/CD Pipeline
**Why:** This is the thing you draw on whiteboards in interviews.

**Do:**
- [ ] Your pipeline should now:
  1. Trigger on PR to main
  2. Build the Docker image
  3. Run health check tests
  4. Push image to GHCR on merge to main
- [ ] Draw your pipeline (use [Excalidraw](https://excalidraw.com/)):
  ```
  Code Push → GitHub Actions → Build → Test → Push Image → Ready to Deploy
  ```
- [ ] Save the diagram as `week-3-cicd/pipeline-diagram.png`
- [ ] Update this README with the diagram

**Push:** Final pipeline + diagram. This is a portfolio piece.

---

### Week 3 Interview Questions
<details>
<summary>Click to reveal</summary>

1. What's the difference between CI and CD?
2. What is GitHub Actions? How does it work?
3. What triggers a CI pipeline?
4. How do you store secrets in CI/CD?
5. What's a container registry? Why do you need one?
6. What's branch protection and why is it important?
7. What happens if CI fails on a PR?
8. What's GitOps? How is it different from traditional CD?
</details>

---

## Week 4: Cloud + Deployment + Observability

> *"Code that's not deployed is just a hobby project. Code that's deployed AND monitored is production."*

### Day 22 — Deploy to the Cloud
**Why:** localhost doesn't count. Real DevOps = code running on the internet.

**Do:**
- [ ] Sign up for [Railway](https://railway.app/) (free tier, no credit card)
- [ ] Deploy your Dockerized app from GitHub
- [ ] Get a public URL. Send it to someone. Your app is LIVE.

**Push:** Add the live URL to this README.

**Scenario:** *PM asks "is the new feature live?" You send them a URL. That's deployment.*

---

### Day 23 — Environment Variables + Secrets in Production
**Why:** Hardcoded passwords in code = career-ending security incident.

**Do:**
- [ ] Move all config to environment variables in Railway
- [ ] Create a `.env.example` with dummy values (never commit real secrets)
- [ ] Verify your app reads config from env vars, not hardcoded strings

**Push:** Updated app code using env vars.

---

### Day 24 — Monitoring: Know Before Your Users Do
**Why:** If your app is down and you don't know, your users will tell you. On Twitter. Publicly.

**Do:**
- [ ] Add a proper `/health` endpoint that checks:
  - App is running
  - Can connect to database (if applicable)
  - Returns response time
- [ ] Set up [UptimeRobot](https://uptimerobot.com/) (free) to ping `/health` every 5 min
- [ ] Get your first "UP" notification email

**Push:** Health endpoint code + UptimeRobot screenshot.

---

### Day 25 — BUFFER DAY

---

### Day 26 — Logs: Your Best Friend at 3am
**Why:** When something breaks in production, logs are the only thing between you and a mental breakdown.

**Do:**
- [ ] Add structured logging to your app (JSON format):
  ```javascript
  const log = (level, message, meta = {}) => {
    console.log(JSON.stringify({
      timestamp: new Date().toISOString(),
      level,
      message,
      ...meta
    }));
  };

  log('info', 'Server started', { port: 3000 });
  log('error', 'Database connection failed', { error: 'timeout' });
  ```
- [ ] Check logs in Railway/your cloud platform
- [ ] Search logs for errors — this is how real debugging works

**Push:** Updated app with structured logging.

---

### Day 27 — Infrastructure as Code (Taste Test)
**Why:** Clicking buttons in cloud consoles doesn't scale. IaC means your infrastructure is version-controlled.

**Do:**
- [ ] Read: [Terraform in 15 min — HashiCorp tutorial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
- [ ] Create `week-4-cloud/main.tf` — even just a hello-world config
- [ ] Understand the concept: `terraform plan` shows changes, `terraform apply` makes them
- [ ] You don't need to deploy anything. Just understand the WHY.

**Push:** Notes + basic `.tf` file.

---

### Day 28 — Kubernetes (Just a Taste)
**Why:** K8s runs ~80% of containerized production workloads. You don't need to master it, but you need to know what it does.

**Do:**
- [ ] Use [KillerCoda K8s Playground](https://killercoda.com/playgrounds/scenario/kubernetes) (free, browser-based, zero RAM)
- [ ] Run:
  ```bash
  kubectl get nodes
  kubectl create deployment my-app --image=nginx
  kubectl get pods
  kubectl expose deployment my-app --port=80 --type=NodePort
  ```
- [ ] Watch: [Kubernetes in 100 Seconds — Fireship](https://www.youtube.com/watch?v=PziYflu8cB8)

**Push:** Notes in `week-4-cloud/day-28-k8s.md`

**Scenario:** *Your app needs to handle 10x traffic during a sale. How?* (K8s autoscaling. `kubectl scale deployment my-app --replicas=5`)

---

### Day 29 — BUFFER / CATCH-UP DAY
- Fix anything that's incomplete
- Polish your GitHub repo
- Update all README progress trackers

---

### Day 30 — THE GRAND FINALE: Portfolio + Retrospective
**Why:** You didn't just learn DevOps. You built a portfolio proving it.

**Do:**
- [ ] Update your portfolio site (from Day 14) with:
  - Your DevOps pipeline diagram
  - Links to each week's projects
  - The live deployed app URL
  - Your GitHub contribution graph (it should be green!)
- [ ] Write `RETROSPECTIVE.md`:
  - What you learned
  - What was hardest
  - What you'd do differently
  - What you want to learn next
- [ ] Deploy your portfolio to GitHub Pages or Cloudflare Pages
- [ ] Post your journey on LinkedIn/Twitter. Tag Abhishek Veeramalla. He loves this stuff.

**Push:** Everything. You're done. You did it.

---

### Week 4 Interview Questions
<details>
<summary>Click to reveal</summary>

1. How do you deploy a Docker container to the cloud?
2. What are environment variables and why are they important?
3. What's a health check endpoint?
4. How do you monitor an application in production?
5. What's Infrastructure as Code? Name a tool.
6. What's Kubernetes? When would you use it vs. plain Docker?
7. What's the difference between horizontal and vertical scaling?
8. Describe a full CI/CD pipeline from code push to production.
</details>

---

## Resources That Don't Suck

| Resource | What | Format |
|----------|------|--------|
| [Abhishek Veeramalla — YouTube](https://www.youtube.com/@AbhishekVeeramalla) | DevOps Zero to Hero | Video (free) |
| [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) | Gamified Linux | Interactive SSH |
| [Fireship](https://www.youtube.com/@Fireship) | 100-second explainers | Short video |
| [TechWorld with Nana](https://www.youtube.com/@TechWorldwithNana) | Docker + K8s deep dives | Video |
| [KillerCoda](https://killercoda.com/) | Browser-based labs | Interactive |
| [SadServers](https://sadservers.com/) | Debug broken servers | Puzzle |
| [KodeKloud](https://kodekloud.com/) | Hands-on DevOps labs | Interactive |

---

## ADHD Survival Kit

- **Don't read ahead.** Today is the only day that exists.
- **25-min timer.** Pomodoro. When it rings, you CAN stop.
- **Half a day > zero days.** Always.
- **Buffer days are sacred.** They're not "lazy days." They're "ADHD days."
- **Push something every day.** Even notes. Green squares = dopamine.
- **If you're stuck for 15 min, skip it.** Come back on a buffer day.

---

## Live Deployed App

> URL: `_your deployed app URL here_`

---

*Started: 2026-03-18 | Target: 2026-04-17*

*Inspired by [Abhishek Veeramalla's DevOps Zero to Hero](https://github.com/iam-veeramalla). Built with ADHD brain, coffee, and stubbornness.*
