const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    type: {
        type: String,
        enum: ['free', 'premium'],
        required: true,
        default: 'free',
    },
    label: {
        type: String,
    },
    subWorkflows: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'SubWorkflow'
    }],
    active: {
        type: Boolean,
        required: true,
        default: true
    },
});

module.exports =  mongoose.model('Workflow', postSchema);