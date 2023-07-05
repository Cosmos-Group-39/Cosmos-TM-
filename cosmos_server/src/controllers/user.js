const jwt = require('jsonwebtoken');
const User = require('../models/user');
const Workflow = require('../models/workflow');
const Chat = require('../models/chat');

const Access = require('../models/accessSchema');

require('dotenv').config();

module.exports.getId = (req, res) => {
    User.findOne(req.body)
        .then((user) => {
            console.log(jwt.sign({ _id: user._id }, process.env.TOKEN_SECRET));
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
    User.findById(req.user._id)
        .then((user) => {
            const workflowPromises = user.workflows.map((id) => Workflow.findById(id));
            Promise.all(workflowPromises)
                .then((workflows) => {
                    res.send(workflows);
                })
                .catch((error) => {
                    res.status(500).send('Error occurred while fetching workflows');
                });
        })
        .catch((error) => {
            res.status(500).send('Error occurred while finding user');
        });
};


module.exports.createWorkflow = (req, res) => {
    console.log(req.body);
    let newWorkflow = {
        ...req.body, 'users': {
            "accessLevel": "Owner",
            "_id": req.user._id,
        }
    };

    new Workflow(newWorkflow).save()
        .then((item) => {
            User.updateOne({ _id: req.user._id }, { $push: { workflows: item._id } })
                .then(() => {
                    new Chat({ workflow: item._id }).save()
                        .then((ch) => {
                            Workflow.updateOne({ _id: item._id }, { $set: { chat: ch._id } })
                                .then((e) => {
                                    console.log(ch);
                                    res.status(200).json(item)
                                })
                        });
                })
                .catch((e) => {
                    console.log(e);
                    res.status(500).json(error);
                });
        })
        .catch((error) => {
            console.log(error);
            res.status(500).json(error);
        });
};

module.exports.deleteWorkflow = (req, res) => {
    Workflow.findByIdAndDelete(req.body.wid)
        .then((item) => {
            console.log(item.chat.toString());
            Chat.findByIdAndDelete(item.chat.toString())
                .then(() => { });
            User.updateOne({ _id: req.user._id }, {
                "$pull": {
                    "workflows": req.body.wid
                }
            })
                .then((item) => {
                    res.status(200).json(item);
                })
                .catch((e) => {
                    console.log(e);
                    res.status(500).json(e);
                });
        })
        .catch((error) => {
            console.log(error);
            res.status(500).json(error);
        });
};

module.exports.findUser = (req, res) => {
    User.findOne({ email: req.body.email })
        .then((user) => {
            if (user) {
                // console.log(req.body.workflow)
                Workflow.updateOne(
                    { _id: req.body.workflow },
                    {
                        $push: {
                            users: { accessLevel: 'Viewer', _id: user._id },
                        },
                    }
                )
                    .then((workflowUpdateResult) => {
                        console.log('hi1');
                        User.updateOne(
                            { _id: user._id },
                            {
                                $push: {
                                    workflows: req.body.workflow,
                                },
                            }
                        )
                            .then((userUpdateResult) => {
                                console.log(userUpdateResult);
                                res.status(200).json({
                                    accessLevel: 'Viewer',
                                    _id: user._id,
                                    email: user.email,
                                });
                            })
                            .catch((error) => {
                                console.log('hi');
                                res.status(500).json({ error: 'Internal Server Error' });
                            });
                    })
                    .catch((error) => {
                        res.status(500).json({ error: 'Internal Server Error' });
                    });
            } else {
                res.status(404).json({ message: 'User not found' });
            }
        })
        .catch((error) => {
            console.log(error);
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

module.exports.removeUser = (req, res) => {
    User.findOne({ email: req.body.email })
        .then((user) => {
            if (user) {
                console.log(req.body.workflow)
                Workflow.updateOne(
                    { _id: req.body.workflow },
                    {
                        $pull: {
                            users: { accessLevel: 'Viewer', _id: user._id },
                        },
                    }
                )
                    .then((workflowUpdateResult) => {
                        console.log('hi1');
                        User.updateOne(
                            { _id: user._id },
                            {
                                $pull: {
                                    workflows: req.body.workflow,
                                },
                            }
                        )
                            .then((userUpdateResult) => {
                                console.log(userUpdateResult);
                                res.status(200).json({
                                    accessLevel: 'Viewer',
                                    _id: user._id,
                                    email: user.email,
                                });
                            })
                            .catch((error) => {
                                console.log('hi');
                                res.status(500).json({ error: 'Internal Server Error' });
                            });
                    })
                    .catch((error) => {
                        res.status(500).json({ error: 'Internal Server Error' });
                    });
            } else {
                res.status(404).json({ message: 'User not found' });
            }
        })
        .catch((error) => {
            console.log(error);
            res.status(500).json({ error: 'Internal Server Error' });
        });
};



module.exports.authenticateToken = (req, res, next) => {
    console.log("InAuth");
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (token == null) return res.sendStatus(401)

    jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {

        if (err) return res.sendStatus(403)

        req.user = user
        console.log(req.user);
        next()
    })
}

