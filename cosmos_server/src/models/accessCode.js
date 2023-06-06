const mongoose = require('mongoose');

const accessCodeSchema = new mongoose.Schema({
    workflows: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Workflow',
        required: true
    },
    accessLevel: {
        type: String,
        enum: ['Owner', 'Editor', 'Viewer'],
        required: true
    },
    code: {
        type: String,
        required: true
    }
});

module.exports = mongoose.model('AccessCode', accessCodeSchema);

