const router = require('express').Router();
const Organization = require('../controllers/organization');
const User = require('../controllers/user');

// Route: GET /organizations
router.post('/creatOrg', User.authenticateToken, Organization.createOrg);

module.exports = router;
