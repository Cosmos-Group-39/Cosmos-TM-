const mongoose = require('mongoose');

const workSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    active: {
        type: Boolean,
        required: true,
        default: false
    },
    startTime: {
        type: Date,
    },
    endTime: {
        type: Date,
    },
    labels: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Label'
    }],
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    repetitive: {
        amount: Number,
        Unit: String
    }
});

const subWorkflowSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    works: [workSchema],
    view: {
        type: String,
        enum: ['stepView', 'progressBar', 'ganttChart', 'calendar', 'chartView'],
        required: true,
    },
    labels: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Label'
    }]
});

module.exports = mongoose.model('SubWorkflow', subWorkflowSchema);

