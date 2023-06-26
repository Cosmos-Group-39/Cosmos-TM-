const router = require('express').Router();
const User = require('../controllers/user,');

// Route: GET /user
router.post('/login', User.getId);
router.post('/register', User.create);


module.exports = router;
