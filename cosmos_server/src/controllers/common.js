// GET /common/:type
module.exports.getAll = (req, res) => {
    require(`../models/${req.params.type}`).find()
        .then((workflows) => {
            res.json(workflows);
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

//GET /common/:type/:id
module.exports.getOne = (req, res) => {
    require(`../models/${req.params.type}`).findById(req.params.id)
        .then((workflows) => {
            res.json(workflows);
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

// POST /common/:type
module.exports.create = (req, res) => {
    console.log(req.body);
    new require(`../models/${req.params.type}`)(req.body).save()
        .then((item) => {
            // res.status(200).json({ id: item._id })
            res.status(200).json(item)
        })
        .catch((error) => {
            res.status(500).json(error);
        });
};

// PATCH /common/:type
module.exports.update = (req, res) => {
    require(`../models/${req.params.type}`).updateOne(req.body)
        .then((item) => {
            res.status(200).json(item)
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

module.exports.remove = (req, res) => {
    require(`../models/${req.params.type}`).findByIdAndDelete(req.params.id)
        .then((item) => {
            res.status(200).json(item)
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
        });
};




/*Send the patch in format
{
    {
        "_id": "647f301f0b223c7d9f21acdd", //Document id to be updated
        "$set": {
            "title": "updated",
            //and other fields to be updated
        },
        "$push": {
            //here goes if adding something to an array field
            "works": {new object}
        }
    }

}
*/