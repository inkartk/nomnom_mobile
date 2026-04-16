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

## Installation

```bash
git clone <your-repo-link>
cd project
npm install
npm run prisma:generate
npm run prisma:migrate -- --name init
npm run seed

```

## Usage

* Sign up or log in
* Browse food options
* Add food options
* Save favorites
* Customize preferences
* Track the info


## Tech Stack

* Frontend: Flutter
* Backend: NestJS, TypeScript, Prisma
* Database: PostgreSQL
