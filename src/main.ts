import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { json } from 'express';
import { ValidationPipe } from '@nestjs/common';

const { MIHRAB_BACK_PORT, MIHRAB_BACK_HOST } = process.env;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.use(json());

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      forbidNonWhitelisted: true,
    }),
  );

  await app.listen(MIHRAB_BACK_PORT || 8080, MIHRAB_BACK_HOST || 'localhost');
}

bootstrap();
