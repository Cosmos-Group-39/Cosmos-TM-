const mongoose = require('mongoose');

const memberSchema = new mongoose.Schema({
    isAdmin: {
        type: Boolean,
        required: true,
        default: false
    },
    _id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    }
});

const organizationSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    pic:{
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
    members: {
        type: [memberSchema],
        required: true
    },
    labels: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Label'
    }]
});

module.exports = mongoose.model('Organization', organizationSchema);