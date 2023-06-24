const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true
  },

  lastName: {
    type: String,
    required: true
  },

  email: {
    type: String,
    required: true
  },
  mobile: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  address: {
    type: String,
  },
  dob: {
    type: Date,
    required: true,
  },
  profilePic: {
    type: String,
  },
  isDeleted: {
    type: Boolean,
    required: true,
    default: false
  },
  subscription: {
    // type: mongoose.Schema.Types.ObjectId,
    // ref: 'Subscription',
    type: String,
    required: true,
  },
  workflows: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Workflow'
  }],
  organizations: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Organization'
  }],
  reviews: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Review'
  }]
});

module.exports = mongoose.model('User', userSchema);

