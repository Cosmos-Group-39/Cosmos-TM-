const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    works: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Work'
    }],
    label: {
        type: String,
    },
    view: {
        type: String,
        enum: ['stepView', 'progressBar', 'ganttChart', 'calendar'],
        required: true,
    }
});

module.exports = mongoose.model('SubWorkflow', userSchema);

