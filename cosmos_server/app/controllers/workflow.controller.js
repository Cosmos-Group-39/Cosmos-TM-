const db = require("../models");
const Workflow = db.workflows;
//use sa centralized exception handling
// Create and Save a new Workflow
exports.create = (req, res) => {
    // Validate request
    if (!req.body.title) {
        res.status(400).send({ message: "Content can not be empty!" });
        return;
    }

    // Create a Workflow
    const workflow = new Workflow({
        title: req.body.title,
        description: req.body.description,
        works: req.body.works,
    });

    if(req.body.description === "test"){
        return  res.status(500).json({message: "msg"});
    }

    // Save Workflow in the database
    workflow
        .save(workflow)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while creating the Workflow."
            });
        });
};

// Retrieve all Workflows from the database.
exports.findAll = (req, res) => {
    const title = req.query.title;
    var condition = title ? { title: { $regex: new RegExp(title), $options: "i" } } : {};

    Workflow.find(condition)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving workflows."
            });
        });
};

// Find a single Workflow with an id
exports.findOne = (req, res) => {
    const id = req.params.id;

    Workflow.findById(id)
        .then(data => {
            if (!data)
                res.status(404).send({ message: "Not found Workflow with id " + id });
            else res.send(data);
        })
        .catch(err => {
            res
                .status(500)
                .send({ message: "Error retrieving Workflow with id=" + id });
        });
};

// Update a Workflow by the id in the request
exports.update = (req, res) => {
    if (!req.body) {
        return res.status(400).send({
            message: "Data to update can not be empty!"
        });
    }

    const id = req.params.id;

    Workflow.findByIdAndUpdate(id, req.body, { useFindAndModify: false })
        .then(data => {
            if (!data) {
                res.status(404).send({
                    message: `Cannot update Workflow with id=${id}. Maybe Workflow was not found!`
                });
            } else res.send({ message: "Workflow was updated successfully." });
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating Workflow with id=" + id
            });
        });
};

// Delete a Workflow with the specified id in the request
exports.delete = (req, res) => {
    const id = req.params.id;

    Workflow.findByIdAndRemove(id)
        .then(data => {
            if (!data) {
                res.status(404).send({
                    message: `Cannot delete Workflow with id=${id}. Maybe Workflow was not found!`
                });
            } else {
                res.send({
                    message: "Workflow was deleted successfully!"
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete Workflow with id=" + id
            });
        });
};

// Delete all Workflow from the database.
exports.deleteAll = (req, res) => {
    Workflow.deleteMany({})
        .then(data => {
            res.send({
                message: `${data.deletedCount} Workflows were deleted successfully!`
            });
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while removing all Workflows."
            });
        });
};

// Find all published Workflows
exports.findAllPublished = (req, res) => {
    Workflow.find({ published: true })
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving Workflows."
            });
        });
};