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

# Copy client bundle
COPY  --from=builder /monorepo/dist/apps/client /usr/share/nginx/html/client

# Expose ports
EXPOSE 80
