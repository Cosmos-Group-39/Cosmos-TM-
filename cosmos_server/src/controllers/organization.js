const Organization = require('../models/organization');
const User = require('../models/user');

module.exports.createOrg = (req, res) => {
    new Organization({
        ...req.body, "members":
        {
            "isAdmin": true,
            "_id": req.user._id
        }
    }).save()
        .then((item) => {
            User.updateOne(
                { _id: req.user._id },
                {
                    $push: {
                        organizations: item._id
                    },
                }
            ).then((e) => {
                res.status(200).json(item);
            })
                .catch((error) => {
                    console.log(error);
                    res.status(500).json(error);
                });

        })
        .catch((error) => {
            console.log(error);
            res.status(500).json(error);
        });
};

module.exports.deleteOrg = (req, res) => {
    console.log("inorg");
    Organization.findByIdAndDelete(req.body.id)
        .then((item) => {
            User.updateOne(
                { _id: req.user._id },
                {
                    $pull: {
                        organizations: req.body.id
                    },
                }
            ).then((e) => {
                res.status(200).json(item);
            })
                .catch((error) => {
                    console.log(error);
                    res.status(500).json(error);
                });

        })
        .catch((error) => {
            console.log(error);
            res.status(500).json(error);
        });
};

module.exports.getOrg = (req, res) => {
    User.findById(req.user._id)
        .then((item) => {
            if (item) {
                const userPromises = item.organizations.map((e) => Organization.findById(e));
                Promise.all(userPromises)
                    .then((orgGot) => {
                        res.status(200).send(orgGot);
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
}




