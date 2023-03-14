# BUILD STAGE
##

# Cache Nx dependencies in shared base image
FROM monorepo-base-image as builder

WORKDIR /monorepo

# Create client bundle
RUN yarn run nx run api:build:production


# SERVE STAGE
##

FROM node:18-alpine

WORKDIR /api

# Copy lock files
COPY --from=builder /monorepo/dist/apps/api/package.json .

# Install runtime dependencies
RUN yarn install --production && yarn cache clean

# Copy api dist
COPY --from=builder /monorepo/dist/apps/api/ .

EXPOSE 3000

ENTRYPOINT [ "node", "main.js" ]
