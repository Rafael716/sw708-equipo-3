/** @type {import('dependency-cruiser').IConfiguration} */
module.exports = {
  forbidden: [
    {
      name: 'dominio-monitoreo-no-depende-de-infra',
      comment:
        'El dominio de monitoreo no debe depender de infraestructura, Nest ni TypeORM (rodaja Lab06).',
      severity: 'error',
      from: {
        path: '^src/monitoreo/dominio',
        pathNot: '\\.spec\\.ts$',
      },
      to: {
        path: '^src/monitoreo/(infraestructura|controllers|services)',
      },
    },
    {
      name: 'dominio-monitoreo-no-depende-de-framework',
      comment: 'El dominio no importa NestJS ni TypeORM.',
      severity: 'error',
      from: {
        path: '^src/monitoreo/dominio',
        pathNot: '\\.spec\\.ts$',
      },
      to: {
        path: 'node_modules/(@nestjs|typeorm)',
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
