# 🔐 Https support

It is possible to take advantage of [Certbot](https://certbot.eff.org/) and its integration with Nginx to obtain **free** certificates with which to force all the traffic of a service onto HTTPS, thus significantly improving the security of the product.

To do this, simply edit `nginx.conf` and `docker-compose.yml` using the templates in this directory.

Once you have done this, you can run `init-letsencrypt.sh` to initialise the containers correctly:

> ⚠️⚠️ **WARNING** ⚠️⚠️ modify `init-letsencrypt.sh` to suit your needs.

```bash
 ./init-letsencrypt.sh
```

Once run, you can proceed normally with:

```bash
docker-compose up --build -d
```

## 🌙 Remote host

To perform this procedure on a remote host, simply specify the host url in the initialisation script

## 🔨 Testing notes

It will no longer be possible to use `/etc/hosts` as the selected domains will have to be reached by the Let's Encrypt servers during the setup phase.
The only way forward in this case is therefore to configure the DNS records of your own domain to point to a correct IP.

### 🖊️ Credits

Thanks to Philip and his [guide](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71) on the subject.
