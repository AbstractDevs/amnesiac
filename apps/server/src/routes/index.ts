import { Router } from 'express';
import sessionRoutes from './sessions.js';

const router = Router();

router.use('/api', sessionRoutes);

// Health check endpoint
router.get('/health', (req, res) => {
  res.json({
    success: true,
    message: 'Amnesiac Server is running',
    timestamp: new Date().toISOString(),
  });
});

export default router;
