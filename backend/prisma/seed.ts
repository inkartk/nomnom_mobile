import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  const passwordHash = await bcrypt.hash('password', 10);

  const user = await prisma.user.upsert({
    where: { email: 'alex@nomnom.app' },
    update: {
      name: 'Alex',
      passwordHash,
    },
    create: {
      name: 'Alex',
      email: 'alex@nomnom.app',
      passwordHash,
    },
  });

  const recipes = [
    {
      title: 'Tomato Basil Pasta',
      description: 'Quick pasta with fresh tomatoes and basil.',
      instructions: ['Boil pasta', 'Saute tomatoes', 'Mix with basil and olive oil'],
      imageUrl: 'https://images.unsplash.com/photo-1523986371872-9d3ba2e2a389',
    },
    {
      title: 'Avocado Toast Deluxe',
      description: 'Crispy toast with avocado and lemon zest.',
      instructions: ['Toast bread', 'Mash avocado', 'Season and serve'],
      imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141',
    },
    {
      title: 'Lemon Herb Salad',
      description: 'Bright salad with herbs and citrus.',
      instructions: ['Chop greens', 'Mix dressing', 'Toss and enjoy'],
      imageUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352',
    },
  ];

  for (const recipe of recipes) {
    await prisma.recipe.upsert({
      where: { id: recipe.title.toLowerCase().replace(/[^a-z0-9]+/g, '-') },
      update: recipe,
      create: {
        id: recipe.title.toLowerCase().replace(/[^a-z0-9]+/g, '-'),
        authorId: user.id,
        ...recipe,
      },
    });
  }

  const tomatoRecipe = await prisma.recipe.findFirstOrThrow({
    where: { title: 'Tomato Basil Pasta' },
  });

  await prisma.ingredient.createMany({
    data: [
      {
        id: 'i1',
        name: 'Tomatoes',
        quantity: 3,
        unit: 'pcs',
        expirationDate: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000),
        userId: user.id,
      },
      {
        id: 'i2',
        name: 'Pasta',
        quantity: 500,
        unit: 'g',
        expirationDate: new Date(Date.now() + 12 * 24 * 60 * 60 * 1000),
        userId: user.id,
      },
      {
        id: 'i3',
        name: 'Basil',
        quantity: 1,
        unit: 'bunch',
        expirationDate: new Date(Date.now() + 1 * 24 * 60 * 60 * 1000),
        userId: user.id,
      },
    ],
    skipDuplicates: true,
  });

  await prisma.favorite.upsert({
    where: {
      userId_recipeId: {
        userId: user.id,
        recipeId: tomatoRecipe.id,
      },
    },
    update: {},
    create: {
      userId: user.id,
      recipeId: tomatoRecipe.id,
    },
  });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error(error);
    await prisma.$disconnect();
    process.exit(1);
  });