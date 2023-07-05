const router = require('express').Router();
const Organization = require('../controllers/organization');
const User = require('../controllers/user');

// Route: GET /organizations
router.post('/creatOrg', User.authenticateToken, Organization.createOrg);
router.post('/deleteOrg', User.authenticateToken, Organization.deleteOrg);
router.get('/getOrg', User.authenticateToken, Organization.getOrg);

module.exports = router;
