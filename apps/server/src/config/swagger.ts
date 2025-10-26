import swaggerJSDoc from 'swagger-jsdoc';
import swaggerUi from 'swagger-ui-express';
import { Express } from 'express';

const options: swaggerJSDoc.Options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Amnesiac API',
      version: '1.0.0',
      description: 'REST API for managing Blood on the Clocktower game sessions',
      contact: {
        name: 'AbstractDevs',
        url: 'https://github.com/AbstractDevs/amnesiac',
      },
    },
    servers: [
      {
        url: 'http://localhost:3000',
        description: 'Development server',
      },
      {
        url: 'http://64.225.49.223:3000',
        description: 'Production server',
      },
    ],
    components: {
      schemas: {
        Session: {
          type: 'object',
          required: ['id', 'name', 'startTime', 'lastUpdated', 'type', 'state'],
          properties: {
            id: {
              type: 'string',
              format: 'uuid',
              description: 'Unique session identifier',
              example: '123e4567-e89b-12d3-a456-426614174000',
            },
            name: {
              type: 'string',
              description: 'Human-readable session name',
              example: 'Evening Game - Rotting Moors',
            },
            startTime: {
              type: 'string',
              format: 'date-time',
              description: 'When the session was created',
              example: '2025-10-26T15:30:00.000Z',
            },
            lastUpdated: {
              type: 'string',
              format: 'date-time',
              description: 'When the session was last modified',
              example: '2025-10-26T16:45:00.000Z',
            },
            type: {
              type: 'string',
              description: 'Type of session',
              example: 'SCRIPT',
              enum: ['SCRIPT'],
            },
            state: {
              type: 'object',
              description: 'Flexible session state object',
              example: {
                currentPhase: 'night',
                playerCount: 7,
                script: 'rotting-moors',
              },
            },
          },
        },
        CreateSessionRequest: {
          type: 'object',
          required: ['name', 'type'],
          properties: {
            name: {
              type: 'string',
              description: 'Human-readable session name',
              example: 'Evening Game - Rotting Moors',
            },
            type: {
              type: 'string',
              description: 'Type of session',
              example: 'SCRIPT',
              enum: ['SCRIPT'],
            },
            state: {
              type: 'object',
              description: 'Initial session state (optional)',
              example: {
                script: 'rotting-moors',
                playerCount: 7,
              },
            },
          },
        },
        UpdateSessionRequest: {
          type: 'object',
          properties: {
            name: {
              type: 'string',
              description: 'Updated session name',
              example: 'Updated Game Name',
            },
            type: {
              type: 'string',
              description: 'Updated session type',
              example: 'SCRIPT',
            },
            state: {
              type: 'object',
              description: 'Updated session state',
              example: {
                currentPhase: 'day',
                playerCount: 8,
              },
            },
          },
        },
        UpdateStateRequest: {
          type: 'object',
          required: ['state'],
          properties: {
            state: {
              type: 'object',
              description: 'New session state to merge',
              example: {
                currentPhase: 'voting',
                nomination: {
                  nominee: 'player1',
                  nominator: 'player2',
                },
              },
            },
          },
        },
        SuccessResponse: {
          type: 'object',
          properties: {
            success: {
              type: 'boolean',
              example: true,
            },
            data: {
              type: 'object',
              description: 'Response data',
            },
          },
        },
        ErrorResponse: {
          type: 'object',
          properties: {
            success: {
              type: 'boolean',
              example: false,
            },
            error: {
              type: 'string',
              description: 'Error message',
              example: 'Session not found',
            },
          },
        },
        HealthResponse: {
          type: 'object',
          properties: {
            success: {
              type: 'boolean',
              example: true,
            },
            message: {
              type: 'string',
              example: 'Amnesiac Server is running',
            },
            timestamp: {
              type: 'string',
              format: 'date-time',
              example: '2025-10-26T15:30:00.000Z',
            },
          },
        },
      },
    },
  },
  apis: [
    './src/routes/*.ts',
    './src/controllers/*.ts',
  ],
};

const specs = swaggerJSDoc(options);

export const setupSwagger = (app: Express): void => {
  // Swagger UI setup
  app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs, {
    explorer: true,
    customCss: '.swagger-ui .topbar { display: none }',
    customSiteTitle: 'Amnesiac API Documentation',
  }));

  // Raw OpenAPI JSON
  app.get('/api-docs.json', (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(specs);
  });
};

export default specs;