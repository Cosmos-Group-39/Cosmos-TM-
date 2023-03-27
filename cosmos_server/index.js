const { MongoClient, ServerApiVersion } = require('mongodb');
const uri = "mongodb+srv://cosmos:cosmosTM@clustercosmos.pnuryvf.mongodb.net/?retryWrites=true&w=majority";
const express = require('express');
const app = new express();
const port = 8080;

const workflow = {
    uid: "MDB011235813",
    title: "Ada Lovelace",
}

app.get("/", (req, res) => {
    return res.send("Hello World!");
});

let server = app.listen(port, () => {
    console.log("listening at http://localhost:" + port)
})


const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true, serverApi: ServerApiVersion.v1 });
client.connect(err => {
    const collection = client.db("CosmosDB").collection("Workflows");
    // perform actions on the collection object
    client.close();
});
