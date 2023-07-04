const Workflow = require('../models/workflow');
const AccessCode = require('../models/accessCode');
const User = require('../models/user');

module.exports.accessCode = (req, res) => {
    AccessCode.findOne({ code: req.params.accCode })
        .then((accessCode) => {
            if (accessCode) {
                Workflow.findOne(accessCode.workflow).populate('subWorkflows')
                    .then((workflow) => {
                        if (workflow) {
                            res.status(200).json(workflow);
                        } else {
                            console.log('Workflow not found');
                            res.status(404).json({ message: 'Workflow not found' });
                        }
                    })
                    .catch((error) => {
                        console.error(error);
                        res.status(500).json({ message: 'Internal server error' });
                    });
            } else {
                console.log('Access code not found');
                res.status(404).json({ message: 'Access code not found' });
            }
        })
        .catch((error) => {
            console.error(error);
            res.status(500).json({ message: 'Internal server error' });
        });
};


module.exports.getWorkflow = (req, res) => {
    Workflow.findById(req.params.id).populate('subWorkflows')
        .then((workflow) => {
            if (workflow) {
                res.status(200).json(workflow);
            } else {
                console.log('Workflow not found');
                res.status(404).json({ message: 'Workflow not found' });
            }
        })
        .catch((error) => {
            console.error(error);
            res.status(500).json({ message: 'Internal server error' });
        });
};

module.exports.getUsers = (req, res) => {
    Workflow.findById(req.params.id)
        .then((workflow) => {
            if (workflow) {
                const userPromises = workflow.users.map((user) => User.findById(user._id));
                Promise.all(userPromises)
                    .then((usersGot) => {
                        const data = workflow.users.map((user) => { return { accessLevel: user.accessLevel, _id: user._id, email: usersGot.filter((e) => e._id.toString() == user._id)[0].email } });
                        res.status(200).send(data);
                    })
                    .catch((error) => {
                        console.log(error);
                        res.status(500).send('Error occurred while fetching workflows');
                    });
            } else {
                console.log('Workflow not found');
                res.status(404).json({ message: 'Workflow not found' });
            }
        })
        .catch((error) => {
            console.error(error);
            res.status(500).json({ message: 'Internal server error' });
        });
};

// module.exports.getUsers



// GET /workflows
// module.exports.getAll = (req, res) => {
//   Workflow.find()
//     .then((workflows) => {
//       res.json(workflows);
//     })
//     .catch((error) => {
//       res.status(500).json({ error: 'Internal Server Error' });
//     });
// };

// POST /workflows
// module.exports.create = (req, res) => {
//   new Workflow(req.body).save()
//     .then((workflow) => {
//       res.status(200).json({ id: workflow._id })
//     })
//     .catch((error) => {
//       res.status(500).json({ error: 'Internal Server Error' });
//     });
// };






