export function validateEnv(config: Record<string, unknown>) {
  const required = ['DATABASE_URL', 'JWT_SECRET'];

  for (const key of required) {
    if (!config[key] || typeof config[key] !== 'string') {
      throw new Error(`Environment variable ${key} is required`);
    }
  }

  return config;
}
