const router = require('express').Router();
const common = require('../controllers/common');


// Route: POST /workflows
router.get('/:type', common.getAll);
router.get('/:type/:id', common.populate);
router.post('/:type', common.create);
router.patch('/:type', common.update);

module.exports = router;
