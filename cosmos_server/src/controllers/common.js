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
module.exports.populate = (req, res) => {
    require(`../models/${req.params.type}`).findById(req.params.id).populate('works')
        .then((workflows) => {
            res.json(workflows);
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
        });
};

// POST /common/:type
module.exports.create = (req, res) => {
    new require(`../models/${req.params.type}`)(req.body).save()
        .then((item) => {
            res.status(200).json({ id: item._id })
        })
        .catch((error) => {
            res.status(500).json({ error: 'Internal Server Error' });
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





