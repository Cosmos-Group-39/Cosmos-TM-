const router = require('express').Router();
const workflow = require('../controllers/workflows');

// Route: GET /workflows
router.get('/:id', workflow.getWorkflow);
router.get('/workflowMembers/:id', workflow.getUsers);
// // Route: POST /workflows
// router.post('/', workflow.create);

module.exports = router;
