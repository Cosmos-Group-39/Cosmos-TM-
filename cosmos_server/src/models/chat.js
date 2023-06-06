const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    time: {
        type: Date,
        required: true,
        default: Date.now
    },
    content: {
        type: String,
        required: true
    }
})

const chatSchema = new mongoose.Schema({
    workflow: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Workflow',
        required: true
    },
    messages: {
        type: [messageSchema],
    }
});

module.exports = mongoose.model('Chat', chatSchema);

