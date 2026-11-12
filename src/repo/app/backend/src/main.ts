import { HttpAdapterHost, NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { ErroresContratoFilter } from './monitoreo/http/errores-contrato.filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  // Habilitar CORS para el frontend
  const corsOrigins = (process.env.CORS_ORIGINS || 'http://localhost:3000,https://bd252-grupo5-app.vercel.app')
    .split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);

  app.enableCors({
    origin: corsOrigins,
    credentials: true,
  });
  
  // Validación global de DTOs
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      forbidNonWhitelisted: true,
    }),
  );

  // Cuerpo de error del contrato en POST /v1/incidencias para lo que Nest rechaza
  // antes del controlador: JSON inválido y falta de token (semana-10/docs/api).
  app.useGlobalFilters(
    new ErroresContratoFilter(app.get(HttpAdapterHost).httpAdapter),
  );
  
  const port = process.env.PORT || 3001;
  await app.listen(port);
  console.log(`🚀 Backend running on http://localhost:${port}`);
}
bootstrap();
