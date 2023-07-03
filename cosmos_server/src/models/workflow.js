const mongoose = require('mongoose');
// const Access = require('./accessSchema');

const accessSchema = new mongoose.Schema({
    accessLevel: {
        type: String,
        enum: ['Owner', 'Editor', 'Viewer'],
        required: true
    },
    _id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    }
});

const workflowSchema = new mongoose.Schema({
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
    subWorkflows: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'SubWorkflow'
    }],
    users: {
        type: [accessSchema],//[Access.schema],
    },
    accessCodes: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'AccessCode'
    }],
    chat: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Chat'
    },
    labels: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Label'
    }],
    active: {
        type: Boolean,
        required: true,
        default: true
    }
});

module.exports = mongoose.model('Workflow', workflowSchema);