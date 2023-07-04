const Organization = require('../models/organization');
const User = require('../models/user');

module.exports.createOrg = (req, res) => {
    console.log("inorg");
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

