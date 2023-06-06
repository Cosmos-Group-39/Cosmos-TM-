const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
    rating: {
        type: Number,
        required: true,
        validate: {
            validator: function (value) {
                return [1, 2, 3, 4, 5].includes(value);
            },
            message: 'Invalid rating value. Must be 1, 2, 3, 4, or 5.'
        }
    },
    description: {
        type: String,
    },
    reviewer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    organization: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Organization',
        required: true
    }
});

module.exports = mongoose.model('Review', reviewSchema);

