# BUILD STAGE
##

# Cache Nx dependencies in shared base image
FROM monorepo-base-image as builder

WORKDIR /monorepo

# Create backoffice bundle
RUN yarn run nx run backoffice:build:production


# SERVE STAGE
##

FROM node:18-alpine

WORKDIR /backoffice

# Copy lock files
COPY --from=builder /monorepo/dist/apps/backoffice/package.json .

# Install runtime dependencies
RUN yarn install --production && yarn cache clean

# Copy backoffice dist
COPY --from=builder /monorepo/dist/apps/backoffice/ .


ENTRYPOINT yarn run next start -p ${BO_PORT}

