# 🔐 Supporto https

> This README is also available in [🇬🇧 english 🇬🇧](./README.md)

È possibile sfruttare [Certbot](https://certbot.eff.org/) e la sua integrazione con Nginx per ottenere certificati **gratuiti** con i quali forzare tutto il traffico di un servizio su HTTPS, migliorando così sensibilmente la sicurezza del prodotto.

Per farlo basterà modificare `nginx.conf` e `docker-compose.yml` utilizzando i template presenti in questa directory.

Una volta eseguito questo passaggio sarà possibile eseguire `init-letsencrypt.sh` per inizializzare i container correttamente:

> ⚠️⚠️ **ATTENZIONE** ⚠️⚠️ modificare secondo le proprie esigenze `init-letsencrypt.sh`

```bash
 ./init-letsencrypt.sh
```

Una volta eseguito sarà possibile procedere normalmente con:

```bash
docker-compose up --build -d
```

## 🌙 Host remoto

Per eseguire questa procedura su un host remoto basterà specificare l'url dell'host nello script di inizializzazione

## 🔨 Testing notes

Non sarà più possibile utilizzare `/etc/hosts` in quanto i domini selezionati dovranno essere raggiunti da i server di Let's Encrypt durante la fase di setup.
L'unica strada percorribile è quindi in questo caso quella di configurare i record DNS di un dominio di propria propietà in modo da puntare ad un ip corretto.

### 🖊️ Crediti

Grazie a Philip e alla sua [guida](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71) sull'argomento.
