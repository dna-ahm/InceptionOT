# Inception-of-Things (IoT)

A System Administration project that introduces Kubernetes using **K3s**, **K3d**, **Vagrant** and **Argo CD**.

## Structure

```
.
├── p1/      # K3s and Vagrant
├── p2/      # K3s and three simple applications
├── p3/      # K3d and Argo CD
└── bonus/   # GitLab (optional)
```

Each folder contains its own `scripts/` and `confs/` directories (plus a `Vagrantfile` for p1 and p2).

## Parts

### Part 1: K3s and Vagrant
Two virtual machines created with Vagrant: a K3s **server** (controller) and a K3s **agent** (worker), each with a dedicated IP, connected together as a small cluster.

### Part 2: K3s and three applications
One VM running K3s in server mode, hosting three web apps exposed through an **Ingress**. The app served depends on the requested host (`app1.com`, `app2.com`, or app3 by default). App 2 runs with 3 replicas.

### Part 3: K3d and Argo CD
A K3d cluster (no Vagrant) with two namespaces: `argocd` and `dev`. Argo CD automatically deploys an application from a public GitHub repository, so changing the image tag (`v1` → `v2`) in Git updates the running app.

### Bonus: GitLab
A local GitLab instance running in its own `gitlab` namespace, replacing GitHub in the Part 3 workflow.

## Usage

Each part has its own setup. In short:

- **p1 / p2:** run `vagrant up` from the part's folder.
- **p3 / bonus:** run the install script in `scripts/`, then apply the configs in `confs/`.

## Requirements

- A virtual machine as the host environment
- Vagrant and a provider (e.g. VirtualBox)
- Docker, K3d, kubectl
