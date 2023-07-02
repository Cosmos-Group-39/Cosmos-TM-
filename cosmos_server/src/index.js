require('dotenv').config();
const cors = require("cors");
const express = require("express");

const routes = require('../config/routes');
const app = express();

var corsOptions = {
    // origin: "http://localhost:8081"
};

app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(express.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

// simple route (a health check)
app.get("/", (req, res) => {
    res.json({ message: "Cosmos server is up..." });
});

require('../config/database')();

app.use('/api', routes);

app.listen(process.env.PORT, () => {
    // console.log(require('crypto').randomBytes(64).toString('hex'));
    console.log(`Server is running on port ${process.env.PORT}.`);
});

