const { connect } = require('mongoose');
require('dotenv').config();

// Database configuration function
async function connectToDatabase() {
  try {
    // Connect to the database
    await connect(process.env.DB_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('Connected to the database');
  } catch (error) {
    console.error('Error connecting to the database:', error);
    // process.exit(1); // Terminate the application on database connection failure
  }
}

module.exports = connectToDatabase;


