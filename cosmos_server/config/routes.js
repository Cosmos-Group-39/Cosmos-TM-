const router = require('express').Router();

router.use('/works', require('../src/routes/works'));
router.use('/subWorkflows', require('../src/routes/subWorkflows'));
router.use('/workflows', require('../src/routes/workflows'));
router.use('/common', require('../src/routes/common'));
router.use('/accesscode', require('../src/routes/accessCode'));
router.use('/user', require('../src/routes/user'));

module.exports = router;
