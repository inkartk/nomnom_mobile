# NomNom

> A mobile app that helps you track ingredients, discover recipes, and save your favorites — all in one place.

## Problem Statement

People often forget what ingredients they have at home, miss expiry dates, and struggle to decide what to cook. NomNom solves this by combining ingredient tracking with recipe discovery in a single app.

## Features

- User registration and login with email verification
- Authenticated user profile access
- Ingredient create, read, update, and delete operations
- Expiring-soon ingredient alerts
- Recipe listing, search, and details
- Favorite recipe management

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile | Flutter |
| Backend | NestJS, TypeScript |
| ORM | Prisma |
| Database | PostgreSQL |
| Auth | JWT + HTTP cookies |
| Email | MailerSend API |
| Deployment | Railway |

## Installation

### Prerequisites

- [Docker](https://www.docker.com/) and Docker Compose
- [Flutter SDK](https://flutter.dev/)

### 1. Clone the repository

```bash
git clone https://github.com/gullyfest/nomnom_mobile
cd nomnom_mobile
```

### 2. Configure the backend

Create `backend/.env` (see `backend/README.md` for all variables):

```env
PORT=3000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/nomnom?schema=public
JWT_SECRET=your-secret
JWT_EXPIRES_IN=7d
COOKIE_NAME=nomnom_session
APP_BASE_URL=http://localhost:3000
MAILERSEND_API_KEY=your-mailersend-key
MAILERSEND_FROM_EMAIL=noreply@your-domain.mlsender.net
MAILERSEND_FROM_NAME=NomNom
```

### 3. Start the backend

```bash
cd backend
docker compose up --build
```

Backend runs at `http://localhost:3000`.

### 4. Seed the database (optional)

```bash
docker cp prisma/seed.ts nomnom-backend:/app/prisma/seed.ts
docker exec nomnom-backend sh -c "cd /app && npx prisma db seed"
```

### 5. Run the mobile app

```bash
cd mobile
flutter pub get
flutter run
```

## Usage

1. Open the app and **sign up** with your email
2. Check your inbox and **verify your email** via the link
3. **Log in** and start adding ingredients to your pantry
4. Browse and **search recipes** based on what you have
5. **Save favorites** for quick access later
6. Get notified about **expiring ingredients**

## Screenshots

### Auth

| Register | Verify Email | Login |
|---|---|---|
| <img src="screenshots/register_page.jpg" width="240" /> | <img src="screenshots/verify_email_page.jpg" width="240" /> | <img src="screenshots/login_page.jpg" width="240" /> |

### Ingredients & Recipes

| Ingredients | Add Ingredient | Recipes |
|---|---|---|
| <img src="screenshots/ingredient_page.jpg" width="240" /> | <img src="screenshots/add_ingredient_page.jpg" width="240" /> | <img src="screenshots/recipes_page.jpg" width="240" /> |

### Recipe Details, Favorites & Profile

| Recipe Details | Favorites | Profile |
|---|---|---|
| <img src="screenshots/details_page.jpg" width="240" /> | <img src="screenshots/favorites_page.jpg" width="240" /> | <img src="screenshots/profile_page.jpg" width="240" /> |

## API

Production API base URL:
```
https://nomnommobile-production.up.railway.app/api
```

Full API documentation is available in [backend/README.md](backend/README.md).

## Student IDs

Yerniyazova Aruzhan - 230103049 
Tolegen Ingkar - 230103157
Zhanali Biyekeyev - 230103327
Nurtileu Abdilda - 230103017