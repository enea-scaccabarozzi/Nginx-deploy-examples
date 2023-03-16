# BUILD STAGE
##

# Cache Nx dependencies in shared base image
FROM monorepo-base-image as builder

WORKDIR /monorepo

# Create client bundle
RUN yarn run nx run client:build:production


# SERVE STAGE
##

FROM nginx:alpine

# Copy config
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Default proxy pass options
RUN echo 'proxy_set_header X-Real-IP $remote_addr;' > /etc/nginx/proxy_params
RUN echo 'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;' >> /etc/nginx/proxy_params
RUN echo 'proxy_set_header X-Forwarded-Proto $scheme;' >> /etc/nginx/proxy_params
RUN echo 'proxy_set_header Host $host;' >> /etc/nginx/proxy_params

# Copy client bundle
COPY  --from=builder /monorepo/dist/apps/client /usr/share/nginx/html/client

# Expose ports
EXPOSE 80
