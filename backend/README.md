# NomNom Backend

NomNom Backend is the server-side part of the NomNom application, built to support a Flutter mobile client for recipe discovery, ingredient tracking, and favorites management.

This version is an alpha release focused on validating the core app flow and the API contract.

## Overview

NomNom helps users manage ingredients, browse recipes, and save favorite dishes in one place.

The backend provides a REST API for authentication, user access, ingredient management, recipe operations, and favorites handling.

## Purpose

- Provide a stable API for the Flutter client
- Centralize business logic and database access
- Support user-based ingredient and favorites workflows
- Serve as the base for further integration and deployment

## Main Features

- User registration and login
- Authenticated user profile access
- Ingredient create, read, update, and delete operations
- Expiring-soon ingredient filtering
- Recipe listing, search, details, and creation
- Favorite recipe management

## Tech Stack

- Frontend: Flutter
- Backend: NestJS, TypeScript, Prisma
- Database: PostgreSQL

## Run With Docker

### Prerequisites

- [Docker](https://www.docker.com/) and Docker Compose installed
- A `.env` file in the `backend/` folder (see [Environment Variables](#environment-variables) below)

### Start

From the `backend/` folder:

```bash
docker compose up --build
```

This starts:

- PostgreSQL on `localhost:5432`
- Backend API on `http://localhost:3000`

Prisma migrations are applied automatically when the backend container starts.

### Subsequent Runs (no rebuild needed)

```bash
docker compose up
```

### Stop

```bash
docker compose down
```

To also remove the database volume:

```bash
docker compose down -v
```

### Seed the Database

To populate the database with sample recipes, ingredients, and a test user:

```bash
docker cp prisma/seed.ts nomnom-backend:/app/prisma/seed.ts
docker exec nomnom-backend sh -c "cd /app && npx prisma db seed"
```

### Browse the Database (Prisma Studio)

To inspect data via a visual UI at `http://localhost:5556`:

```bash
docker run --rm --name nomnom-studio \
  --network backend_default \
  -p 5556:5555 \
  -e DATABASE_URL="postgresql://postgres:postgres@postgres:5432/nomnom?schema=public" \
  backend-backend \
  sh -c "cd /app && npx prisma studio --hostname 0.0.0.0 --port 5555"
```

## Environment Variables

Create `backend/.env` with the following variables:

```env
PORT=3000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/nomnom?schema=public
JWT_SECRET=your-secret-here
JWT_EXPIRES_IN=7d
CLIENT_ORIGIN=http://localhost:3001
COOKIE_NAME=nomnom_session
APP_BASE_URL=http://localhost:3000

# Optional — SMTP for email verification
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your@gmail.com
SMTP_PASS=your-app-password
SMTP_FROM=your@gmail.com
```

> If SMTP variables are not set, the verification link is printed to the backend logs instead of being sent by email.

## Project Structure

- `src/auth` - authentication logic, guards, and strategies
- `src/users` - user profile endpoints
- `src/ingredients` - ingredient domain and API
- `src/recipes` - recipe domain and API
- `src/favorites` - favorites domain and API
- `src/prisma` - Prisma service integration
- `prisma/schema.prisma` - database schema
- `prisma/migrations` - migration history

## Current Status

This project is currently in alpha.

- Core backend modules are implemented
- Main API routes are available and working
- Database schema and relations are defined
- The project is ready for frontend integration and API-level testing
- Some Flutter-side wiring is still needed to replace mocks with real requests

## Frontend Integration Notes

Base API URL example:

- `http://localhost:3000/api`

Notes for Flutter integration:

- Replace mock data with real API calls
- Make sure the backend is running locally during development
- Authentication uses JWT or cookies, depending on the client implementation
- The Flutter app should align with the current request and response contract

Main endpoints:

- `/api/auth/register`
- `/api/auth/login`
- `/api/auth/verify-email?token=...`
- `/api/auth/resend-verification`
- `/api/users/me`
- `/api/ingredients`
- `/api/recipes`
- `/api/favorites`

Email verification notes:

- New users receive a verification link during registration.
- Login is blocked until `emailVerified` is true.
- If SMTP variables are not configured, the verification URL is printed to the backend logs so you can verify manually during development.
