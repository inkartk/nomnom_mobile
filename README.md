# NomNom App

NomNom helps users manage ingredients, browse recipes, and save favorite dishes in one place.

## Problem Statement

Many users struggle to find personalized food options and track their preferences efficiently. They often forgot about ingredients in their fridge and expiracy dates of some products.

## Features

* User registration and login
* Authenticated user profile access
* Ingredient create, read, update, and delete operations
* Expiring-soon ingredient filtering
* Recipe listing, search, details, and creation
* Favorite recipe management

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) and Docker Compose
- [Flutter SDK](https://flutter.dev/)

### Run the Backend

1. Clone the repository:

```bash
git clone <your-repo-link>
cd nomnom_mobile
```

2. Create `backend/.env` with the required variables (see `backend/README.md` for the full list).

3. Start the backend and database:

```bash
cd backend
docker compose up --build
```

This starts:
- PostgreSQL on `localhost:5432`
- Backend API on `http://localhost:3000`

Prisma migrations are applied automatically on startup.

### Seed the Database (optional)

To populate the database with sample recipes and ingredients:

```bash
docker cp prisma/seed.ts nomnom-backend:/app/prisma/seed.ts
docker exec nomnom-backend sh -c "cd /app && npx prisma db seed"
```

### Run the Flutter App

```bash
cd mobile
flutter pub get
flutter run
```

Make sure the backend is running before launching the app.

## Usage

- Sign up or log in (email verification required)
- Browse and search recipes
- Manage your ingredients and track expiry dates
- Save favorite recipes


## Tech Stack

* Frontend: Flutter
* Backend: NestJS, TypeScript, Prisma
* Database: PostgreSQL
