import { Router } from 'express';
import { sessionController } from '../controllers/sessionController.js';

const router = Router();

// Session CRUD routes
router.post(
  '/sessions',
  sessionController.createSession.bind(sessionController)
);
router.get(
  '/sessions',
  sessionController.getAllSessions.bind(sessionController)
);
router.get(
  '/sessions/:id',
  sessionController.getSession.bind(sessionController)
);
router.put(
  '/sessions/:id',
  sessionController.updateSession.bind(sessionController)
);
router.delete(
  '/sessions/:id',
  sessionController.deleteSession.bind(sessionController)
);

// Session state management
router.patch(
  '/sessions/:id/state',
  sessionController.updateSessionState.bind(sessionController)
);

export default router;
