# Assignment 3 - Container Deployment & Orchestration
## Docker Hub + Kubernetes (Minikube) Deployment

### Scenario
You are a DevOps engineer deploying a small web application for internal testing. You’ll containerize a web server (Nginx), publish it to Docker Hub, and deploy it on a Kubernetes cluster (using Minikube). This assignment tests your understanding of container creation, image publishing, and Kubernetes orchestration.

### Objectives
By the end of this assignment, you should be able to:
- Build a Docker image with Nginx and custom HTML content
- Push an image to Docker Hub
- Deploy multiple replicas of your container using Kubernetes

---

## Part 1 — Docker Image

1. Create a new directory for your project.
2. Create an `index.html` file with the following content:
   - The following sentence: `<h1>Hello from <INSERT YOUR FIRST NAME> - running on port 8085!</h1>`
3. A style sheet separate from your `index.html` that contains the following:
   - **Background:** red
   - **Font colour:** white
4. Include image or photo of your choosing that’s saved in the project folder. Save the image file as `image.jpg`.
5. Create a `Dockerfile` in the same directory that has the following requirements:
   - **Base Image:** `nginx:alpine`
   - **Copy Files:** `index.html`, `style.css`, `image.jpg` to correct locations in `/usr/share/nginx/html/`
   - **Expose port:** `8085`
   - **Update Nginx** to listen on port `8085`
   - **Start Nginx** in the foreground
6. Build and test your image locally so it runs properly. **(1 mark)**
7. Push the image to Docker Hub.
8. Submit your Docker Hub project URL:
   > [PASTE URL HERE]

---

## Part 2 — Kubernetes Deployment

You will now deploy your Docker container to a Kubernetes cluster (Minikube).

Using your Docker image from Part 1, create a deployment and service configuration in a file named: `deployment-67.yml`.

Your configuration must meet the following requirements:

### Deployment Requirements
- The deployment must be named `devops-app-22`
- It must run **3 replicas** of your container
- Each pod must:
  - Use your Docker Hub image (e.g., `YOUR-USERNAME/devops-app-22:v1`)
  - Listen on container port `8085`
  - Be labeled appropriately so the service can select it
- The container should display your “Hello from…” (`index.html`) message when accessed

### Service Requirements
- The service must:
  - Be of type `NodePort`
  - Be named `devops-app-22`
  - Expose your container on port `8085` and map to the same `targetPort` inside the container
  - Use a `nodePort` value between **30000–32767** (you can choose any valid number)

Then deploy and verify everything is working.

---

## Part 3 — Submission
**Due Tuesday, February, 2025, 5:30PM**

Push all required files to a GitHub repository named `CSD-4503W-Assignment-3`:
- `Dockerfile`
- `index.html`
- `style.css`
- `image.jpg`
- `deployment-67.yml`

Submit this document to the Dropbox folder in D2L.

---

## Marking Guide — Assignment 3
**Total: 28 points (Part 1: 17, Part 2: 10, Part 3: 1)**

### Part 1 — Docker Image (17 points)
- **index.html**
  - `<h1>` contains exactly: `"Hello from <FIRST NAME> - running on port 8085!"` — **2 pts**
- **style.css**
  - `background: red;` — **1.5 pts**
  - `color (colour): white;` — **1.5 pts**
- **Assets**
  - `image.jpg` present in project — **1 pt**
- **Dockerfile**
  - Base image: `nginx:alpine` — **1 pt**
  - Copies `index.html`, `style.css`, `image.jpg` to `/usr/share/nginx/html/` — **3 pts**
  - `EXPOSE 8085` — **1 pt**
  - Nginx configured to listen on `8085` (e.g., conf edit or sed replace) — **2 pts**
  - Foreground start (e.g., `CMD ["nginx", "-g", "daemon off;"]`) — **1 pt**
- **Build/Test Evidence**
  - Local build/run verified (awarded if Dockerfile mostly complete) — **1 pt**
- **Docker Hub URL**
  - Valid Docker Hub repository/image URL provided — **1 pt**

### Part 2 — Kubernetes Deployment (10 points)
- **Deployment**
  - `replicas: 3` — **1 pt**
  - Pod template has labels; container image set; `containerPort: 8085` — **3 pts**
- **Service (NodePort)**
  - `type: NodePort` — **1 pt**
  - `port: 8085` maps to `targetPort: 8085` — **1 pt**
  - `nodePort` within **30000–32767** — **1 pt**
  - `selector` matches pod labels (traffic routes to pods) — **1 pt**
- **Deployment/Verify Consistency**
  - Configs are internally consistent (proxy for successful deploy/verify) — **1 pt**

### Part 3 — GitHub Submission (1 point)
- Repository named exactly `CSD-4503W-Assignment-3` with all required files at repo root — **1 point**

---

### Leniency & Naming Notes
- Do not deduct marks for differences in deployment name, container name, image name/tag, or specific `nodePort` value (any valid value in range is acceptable).
- Minor whitespace/casing differences in CSS are acceptable if the intent is clear.
- For Nginx port `8085`, accept common implementation patterns (custom conf, sed replacement, or environment templating).

### Marker Feedback Guidance (for consistency)
- If `<h1>` text differs only by student first name, it is correct. Ensure port text shows `8085`.
- If `COPY` uses `COPY . /usr/share/nginx/html/` and files exist in build context, award full `COPY` marks.
- If Service uses selector keys that are a superset of Deployment labels, award if routing would still match.
- Partial credit is allowed for CSS (**1.5 pts** each rule).