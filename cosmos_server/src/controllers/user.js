const User = require('../models/user');
const Workflow = require('../models/workflow');
require('dotenv').config();
const jwt = require('jsonwebtoken');

module.exports.getId = (req, res) => {
    User.findOne(req.body)
        .then((user) => {
            if (user) res.status(200).json({
                id: jwt.sign({ _id: user._id }, process.env.TOKEN_SECRET),
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
            });
            else res.status(404).json('Invalid credentials');
        })
        .catch((error) => {
            console.log(error);
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

module.exports.create = (req, res) => {
    User.findOne({ email: req.body.email })
        .then((workflow) => {

            if (workflow) res.status(404).json({ message: 'Email alreay exists' });
            else {
                new User(req.body).save()
                    .then((item) => {
                        res.status(200).json(item);
                    })
                    .catch((error) => {
                        console.log(error);
                        res.status(500).json(error);
                    });
            }
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

module.exports.ownWorkflows = (req, res) => {
    console.log("get int");
       User.findById(req.user._id)
        .then((user) => {
            console.log('gt user');
            const workflowPromises = user.workflows.map((id) => Workflow.findById(id));
            Promise.all(workflowPromises)
                .then((workflows) => {
                    res.send(workflows);
                })
                .catch((error) => {
                    console.log('sent error');
                    res.status(500).send('Error occurred while fetching workflows');
                });
        })
        .catch((error) => {
            console.log('sent error2');
            res.status(500).send('Error occurred while finding user');
        });
};



module.exports.authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (token == null) return res.sendStatus(401)

    jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {

        if (err) return res.sendStatus(403)

        req.user = user

        next()
    })
}