const Workflow = require('../models/workflow');
const AccessCode = require('../models/accessCode');

module.exports.accessCode = (req, res) => {
    AccessCode.findOne({ code: req.params.accCode })
        .then((accessCode) => {
            if (accessCode) {
                Workflow.findOne(accessCode.workflow).populate('subWorkflows')
                    .then((workflow) => {
                        if (workflow) {
                            // console.log(workflow);
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










