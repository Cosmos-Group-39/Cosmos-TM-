const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    features: [{
        type: String,
        required: true
    }],
    description: {
        type: String,
        required: true
    },
    price: {
        type: Number,
        required: true
    }
});

module.exports = mongoose.model('Subscription', userSchema);

