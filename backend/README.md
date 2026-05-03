# NomNom Backend

NomNom Backend is the server-side API for the NomNom mobile application.

It handles authentication, user profile access, ingredient management, recipe operations, and favorites.

## Current Production

- Platform: Railway
- Base URL: https://nomnommobile-production.up.railway.app
- API prefix: /api
- Email provider: MailerSend API

## Main Features

- User registration and login
- Email verification workflow
- Authenticated profile endpoint
- Ingredient CRUD and expiring-soon filter
- Recipe listing, search, details, and creation
- Favorite recipes management

## Tech Stack

- NestJS + TypeScript
- Prisma ORM
- PostgreSQL

## Local Development With Docker

### Start

From backend folder:

```bash
docker compose up --build
```

This starts:
- PostgreSQL on localhost:5432
- Backend API on http://localhost:3000

### Stop

```bash
docker compose down
```

Remove database volume too:

```bash
docker compose down -v
```

### Seed local DB

```bash
docker cp prisma/seed.ts nomnom-backend:/app/prisma/seed.ts
docker exec nomnom-backend sh -c "cd /app && npx prisma db seed"
```

## Railway Deployment

### Required variables

Set these in Railway service variables:

```env
PORT=3000
DATABASE_URL=<railway-postgres-url>
JWT_SECRET=<strong-random-secret>
JWT_EXPIRES_IN=7d
CLIENT_ORIGIN=*
COOKIE_NAME=nomnom_session
APP_BASE_URL=https://nomnommobile-production.up.railway.app
MAILERSEND_API_KEY=<mailersend-api-key>
MAILERSEND_FROM_EMAIL=noreply@test-nrw7gym8d1og2k8e.mlsender.net
MAILERSEND_FROM_NAME=NomNom
```

Notes:
- Do not use localhost in Railway DATABASE_URL.
- Use Railway service domain in APP_BASE_URL.
- If MAILERSEND_API_KEY is missing, verification link is printed to logs as fallback.

### Seed Railway DB

If running seed from your local machine, use the public DB URL:

```bash
set DATABASE_URL=<railway-public-db-url>
npm run prisma:seed
```

## Main Endpoints

- POST /api/auth/register
- POST /api/auth/login
- POST /api/auth/logout
- POST /api/auth/resend-verification
- GET /api/auth/verify-email?token=...
- GET /api/users/me
- GET/POST /api/ingredients
- GET /api/ingredients/expiring-soon
- GET/POST /api/recipes
- GET /api/recipes/search
- GET/POST/DELETE /api/favorites

## Auth Behavior

- Login requires verified email.
- Unverified user gets 401 with message: Please verify your email before logging in.
- Verification endpoint returns {"success": true} on success.

## Project Structure

- src/auth: auth logic, JWT, verification flow
- src/users: profile endpoints
- src/ingredients: ingredient module
- src/recipes: recipe module
- src/favorites: favorites module
- src/prisma: prisma service module
- prisma/schema.prisma: database schema
- prisma/migrations: migration history
