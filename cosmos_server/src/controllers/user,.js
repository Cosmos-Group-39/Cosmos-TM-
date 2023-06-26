const User = require('../models/user');

module.exports.getId = (req, res) => {
    User.findOne(req.body)
        .then((workflow) => {
            if (workflow) res.status(200).json({ 
                id: workflow._id, 
                firstName: workflow.firstName, 
                lastName: workflow.lastName, 
                email: workflow.email, 
            });
            else res.status(404).json('Invalid credentials');
        })
        .catch((error) => {
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
