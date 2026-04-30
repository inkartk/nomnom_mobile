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

From the `backend` folder:

```bash
docker compose up --build
```

This starts:

- PostgreSQL on `localhost:5432`
- Backend API on `http://localhost:3000`

Notes:

- `backend/.env` is loaded automatically for app variables.
- Inside Docker, `DATABASE_URL` is overridden to use the `postgres` service hostname.
- Prisma migrations are applied automatically on backend container start.

Stop services:

```bash
docker compose down
```

Stop and remove database volume too:

```bash
docker compose down -v
```

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
- If SMTP variables are not configured, the verification URL is printed to backend logs.

Optional SMTP env variables:

- `APP_BASE_URL`
- `SMTP_HOST`
- `SMTP_PORT`
- `SMTP_USER`
- `SMTP_PASS`
- `SMTP_FROM`

This alpha is basically backend-ready, but the Flutter side still needs the final hookup so it can stop vibing on mocks.
