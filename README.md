# NomNom App

NomNom helps users manage ingredients, browse recipes, and save favorite dishes in one place.

## Features

- User registration and login with email verification
- Authenticated user profile access
- Ingredient create, read, update, and delete operations
- Expiring-soon ingredient filtering
- Recipe listing, search, details, and creation
- Favorite recipe management

## Tech Stack

- Frontend: Flutter
- Backend: NestJS, TypeScript, Prisma
- Database: PostgreSQL
- Email delivery: MailerSend API

## Run Locally

### Prerequisites

- Docker and Docker Compose
- Flutter SDK

### Backend

```bash
cd backend
docker compose up --build
```

Backend API runs at http://localhost:3000

### Seed local database

```bash
docker cp prisma/seed.ts nomnom-backend:/app/prisma/seed.ts
docker exec nomnom-backend sh -c "cd /app && npx prisma db seed"
```

### Mobile app

```bash
cd mobile
flutter pub get
flutter run
```

## Production

Current production backend is deployed on Railway.

Base API URL:
- https://nomnommobile-production.up.railway.app/api

If mobile app points to another URL, update baseUrl in the network module to the Railway domain.

## Backend Docs

Detailed backend setup, environment variables, deployment, and API endpoints are documented in backend/README.md.
