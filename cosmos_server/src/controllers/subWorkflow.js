const subWorkflow = require('../models/subWorkflow');

// POST /subWorkflows
// module.exports.create = (req, res) => {
//   new subWorkflow(req.body).save()
//     .then((subWorkflow) => {
//       res.status(200).json({ id: subWorkflow._id })
//     })
//     .catch((error) => {
//       res.status(500).json({ error: 'Internal Server Error' });
//     });
// };

module.exports.getSubWorkflows = (req, res) => {
      subWorkflow.findById(req.params.id)
        .then((subWorkflows) => {
          res.status(200).json({ id: subWorkflow._id })
        })
        .catch((error) => {
          res.status(500).json({ error: 'Internal Server Error' });
        });
    };
    







