# 🚀 Nginx Deploy Examples

> This README is also available in [🇬🇧 english 🇬🇧](./README.md)

- [🚀 Nginx Deploy Examples](#-nginx-deploy-examples)
  - [🧭 Design architettura](#-design-architettura)
  - [📦 Deployment](#-deployment)
    - [🌙 Host remoto](#-host-remoto)
    - [🗒️ Nx notes](#️-nx-notes)
    - [🔨 Testing notes](#-testing-notes)
  - [⚙️ Advanced deployment](#️-advanced-deployment)
  - [🖇️ CI/CD e DevOps](#️-cicd-e-devops)

Questo repository contiene una piccola collezione di esempi pratici nei quali Nginx è usato per rendere possibile un deployment efficace in un architettura basata su microservizi.

## 🧭 Design architettura

Per facilitare la dimostrazione dei vantaggi di una soluzione di deployment simile a questa il progetto è stato suddiviso in 3 microservizi pressochè autonomi, che da qesto momento in avanti verranno identificati così:

- 🛣️ **Api:** REST api basata su [NestJS](https://nestjs.com/). *Per il suo deployment è dedicato un container Docker autonomo.*
- 🔒 **Backoffice:** SPA basata su [NextJS](https://nextjs.org/). *Per il suo deployment è dedicato un container Docker autonomo (SSR).*
- 🌐 **Client:** SPA basata su [ReactJS](https://reactjs.org/). *Il suo deployment avviene per mezzo di un bundle statico servito tramite Nginx.*

Questi 3 microservizi sono connessi ed eventualmente esposti attraverso un gateway principale, rappresentato da un ulteriore container Docker nel quale è posto in esecuzione Nginx.

## 📦 Deployment

Per eseguire un deployment ottimizzato di questa architettura si eseguano questi comandi:

> ⚠️⚠️ **ATTENZIONE** ⚠️⚠️ Modificare correttamente e secondo le proprie esigenze le voci indicate in `nginx.conf` prima di cominciare l'operazione

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

A questo punto Client e Backoffice saranno raggiungibili attraverso i domini specificati im `nginx.conf` mentre Api sarà raggiungibile internamente in ognuno dei 2 domini tramite il path `/api/v1/` (*Eg: `xyz.com/api/v1/`*)

### 🌙 Host remoto

Il deployment potrà avvenire su un host remoto, nel quale ovviamente si possieda accesso SSH, tramite la variabile `DOCKER_HOST`.
Da `docker-compose v1.23.1` sarà infatti possibile aggiungere l'indirizzo remoto al comando di compose tramite la flag `-H` nel seguente modo:

```bash
docker-compose -H "ssh://<USER>@<REMOTE_HOST>" up --build -d
```

### 🗒️ Nx notes

Questo repository è stato generato tramite [Nx](https://nx.dev), e per questo motivo la gestione dei container e del loro processo di build ne sarà condizionato.

In particolar modo le dev dependencies necessarie al processo di build assistito sono condivise tra i container, evitando multipli lunghi tempi di attesa yarn install, tramite l'immagine `monorepo-base-image`, definita in `Dockerfile.base` e usata come base per ogni microservizio e che dovrà essere generata ad ogni cambio di sorgente in uno dei servizi. *Nota: l'attesa dell'installazione delle dipendenze è annullata tramite grazie allo sfruttamento della cache del processo di build*.

Nx aggiunge quindi un layer in più alla complessità del deployment, in particolar modo nella gestione del processo di build delle immagini dei containers e nei relativi Dockerfile.
è quindi possibile rimuovere quest'ulteriore complessità (immagine condivisa e `Dockerfile.base`) se si decidesse di optare per una differente soluzione per la gestione della monorepo.

### 🔨 Testing notes

In sistemi Unix like sarà possibile testare questo deployment anche in ambiente locale, senza dover necessariamente possedere il dominio in questione, editando il file di associazione degli host (`/etc/hosts`) in modo opportuno.

Per esempio la seguente configurazione permetterà di creare un alias verso localhost dei domini necessari:

```bash
# [Previous hosts...]

# [Test Nginx deployment]
### Section start
127.0.0.1 xyz.com
127.0.0.1 admin.xyz.com
127.0.0.1 www.xyz.com
# [Test Nginx deployment]
### Section end
```

## ⚙️ Advanced deployment

In questo repository sono presenti altri 3 esempi di deployment più strutturati rispetto a quello di base, in particolar modo essi sono in grado di aggiungere al design proposto le seguenti feature:

- 🔐 Https (**gratuito**) su alcuni o tutti i microservizi
- 🧺 Proxy caching
- 📊 Rate limiting

Ognuna di queste feature sarà raggiungibile attraverso opportune modifiche sulla configurazione di Ngix.

> Per maggiori informazioni si faccia riferimento alla cartella `examples/` e al relativo [README](examples/README_IT.md)

## 🖇️ CI/CD e DevOps

Il processo descritto può essere oltretutto facilmente inserito in una pipeline di deployment, facilitando così l'integrazione in un ottica legata al continuos development.
Questa possibilità è esplorata ed approfondita nel file `bitbucket-pipelines.yml` che fornisce un esempio per un ambiente [BitBucket](https://bitbucket.org)

✨ **This workspace has been generated by [Nx, a Smart, fast and extensible build system.](https://nx.dev)** ✨
