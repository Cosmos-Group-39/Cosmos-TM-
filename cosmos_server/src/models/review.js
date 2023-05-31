const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    rating: {
        type: Number,
        required: true
    },
    description: {
        type: String,
    },
    reviewer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
});

module.exports = mongoose.model('Review', userSchema);

