const router = require('express').Router();
const workflow = require('../controllers/workflows');

// Route: GET /workflows
router.get('/accesscode/:accCode', workflow.accessCode);
// // Route: POST /workflows
// router.post('/', workflow.create);

module.exports = router;
