# 🚀 Nginx Deploy Examples

This repository contains a small collection of practical examples in which Nginx is used to enable effective deployment in a microservices-based architecture.

## 🧭 Architecture design

In order to facilitate the demonstration of the advantages of a deployment solution similar to this one, the project has been divided into three almost autonomous microservices, which from now on will be identified as follows

- 🛣️ **Api:** REST api based on [NestJS](https://nestjs.com/). *A standalone Docker container is dedicated for its deployment.
- 🔒 **Backoffice:** SPA based on [NextJS](https://nextjs.org/). *An autonomous Docker container (SSR) is dedicated for its deployment.
- 🌐 **Client:** SPA based on [ReactJS](https://reactjs.org/). *Deployment is by means of a static bundle served via Nginx.

These 3 microservices are connected and eventually exposed via a main gateway, represented by an additional Docker container in which Nginx is running.

## 📦 Deployment

To perform an optimised deployment of this architecture, execute these commands:

> CAUTION Edit the entries in `nginx.conf` correctly and according to your needs before starting the operation

```bash
# Clone this repo
git clone https://github.com/enea-scaccabarozzi/Nginx-deploy-examples.git
cd Nginx-deploy-examples

# See Nx notes
docker build -t monorepo-base-image -f Dockerfile.base .

# Configure enviromet's variables
cp .env.prod.sample .env.prod
nano .env.prod

# Start services
docker-compose up --build -d
```

At this point Client and Backoffice will be reachable through the domains specified im `nginx.conf` while Api will be reachable internally in each of the 2 domains via the path `/api/v1/` (*Eg: `xyz.com/api/v1/`*)

### 🌙 Remote host

Deployment can take place on a remote host, where you obviously have SSH access, via the `DOCKER_HOST` variable.
From `docker-compose v1.23.1` it will be possible to add the remote address to the compose command via the `-H` flag as follows:

```bash
docker-compose -H "ssh://<USER>@<REMOTE_HOST>" up --build -d
```

### 🗒️ Nx notes

This repository has been generated via [Nx](https://nx.dev), and therefore the management of containers and their build process will be affected.

In particular, the dev dependencies needed for the assisted build process are shared between containers, avoiding multiple long waiting times for the yarn install, via the `monorepo-base-image`, defined in `Dockerfile.base` and used as the base for each microservice, and which will have to be generated every time the source changes to one of the services. *Note: the wait for dependencies to be installed is cancelled by exploiting the build process cache*.

Nx thus adds an extra layer to the complexity of the deployment, particularly in the management of the build process of container images and associated Dockerfiles.
It is therefore possible to remove this additional complexity (shared image and `Dockerfile.base`) if one decides to opt for a different solution for managing the monobody.

### 🔨 Testing notes

On Unix like systems, it will also be possible to test this deployment locally, without necessarily owning the domain in question, by editing the host association file (`/etc/hosts`) appropriately.

For example, the following configuration will alias the required domains to localhost:

```bash
# [Previous hosts]

# [Test Nginx deployment]
### Section start
127.0.0.1 xyz.com
127.0.0.1 admin.xyz.com
127.0.0.1 www.xyz.com
# [Test Nginx deployment]
### Section end
```

## ⚙️ Advanced deployment

In this repository there are 3 more structured deployment examples than the basic one, in particular they add the following features to the proposed design:

- 🔐 Https (**free**) on some or all microservices
- 🧺 Proxy caching
- 📊 Rate limiting

Each of these features will be achievable through appropriate changes to the Ngix configuration.

> For more information please refer to the `examples/` folder and its [README](./examples/README.md)

## 🖇️ CI/CD and DevOps

The process described can also be easily inserted into a deployment pipeline, facilitating integration in a continuos development perspective.
This possibility is explored and deepened in the file `bitbucket-pipelines.yml` which provides an example for a [BitBucket](https://bitbucket.org) environment

✨ **This workspace has been generated by [Nx, a Smart, fast and extensible build system](https://nx.dev)** ✨
