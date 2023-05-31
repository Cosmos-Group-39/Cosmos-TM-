const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
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
    deadline: {
        type: Date,
        required: true,
        default: Date.now
    },
    label: {
        type: String
    }
});

module.exports = mongoose.model('Work', userSchema);

