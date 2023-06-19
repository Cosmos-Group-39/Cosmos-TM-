const router = require('express').Router();
const AccesCode = require('../controllers/accessCode');

// Route: GET /workflows
router.get('/:accCode', AccesCode.accessCode);
// // Route: POST /workflows
// router.post('/', workflow.create);

module.exports = router;
