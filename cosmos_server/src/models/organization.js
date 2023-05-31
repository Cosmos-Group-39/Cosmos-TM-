const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    reviews: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Review'
    }],
    workflows: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Workflow'
    }],
    members: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Review'
    }],
});

module.exports =  mongoose.model('Organization', postSchema);