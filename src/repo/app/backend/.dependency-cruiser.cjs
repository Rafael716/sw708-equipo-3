/** @type {import('dependency-cruiser').IConfiguration} */
module.exports = {
  forbidden: [
    {
      name: 'dominio-monitoreo-no-depende-de-infra',
      comment:
        'El dominio de monitoreo no debe depender de infraestructura, Nest ni TypeORM (rodaja Lab06). ' +
        'Lab10: tampoco del adaptador HTTP (http/, incluido el código generado del contrato) ni de las entidades TypeORM (entities/).',
      severity: 'error',
      from: {
        path: '^src/monitoreo/dominio',
        pathNot: '\\.spec\\.ts$',
      },
      to: {
        path: '^src/monitoreo/(infraestructura|controllers|services|http|entities)',
      },
    },
    {
      name: 'dominio-monitoreo-no-depende-de-framework',
      comment:
        'El dominio no importa el framework (Lab06: NestJS y TypeORM). ' +
        'Lab10: tampoco Express, validación y transformación de NestJS, Passport, RxJS, ' +
        'reflect-metadata ni el driver de PostgreSQL. Incluye los import type (tsPreCompilationDeps).',
      severity: 'error',
      from: {
        path: '^src/monitoreo/dominio',
        pathNot: '\\.spec\\.ts$',
      },
      to: {
        path: 'node_modules/(@nestjs|typeorm|express|@types/express|class-validator|class-transformer|passport|passport-jwt|rxjs|reflect-metadata|pg)(/|$)',
      },
    },
    {
      name: 'dominio-monitoreo-no-depende-de-otros-modulos',
      comment:
        'Frontera Partición B: el dominio de monitoreo no debe importar gestión marítima, reservas ni operaciones terrestres.',
      severity: 'error',
      from: {
        path: '^src/monitoreo/dominio',
        pathNot: '\\.spec\\.ts$',
      },
      to: {
        path: '^src/(gestion_maritima|gestion_reserva|gestion_portuaria|operaciones_terrestres)',
      },
    },
  ],
  options: {
    doNotFollow: {
      path: 'node_modules',
    },
    tsConfig: {
      fileName: 'tsconfig.json',
    },
    tsPreCompilationDeps: true,
    enhancedResolveOptions: {
      exportsFields: ['exports'],
      conditionNames: ['import', 'require', 'node', 'default'],
      mainFields: ['main', 'types', 'typings'],
    },
  },
};
