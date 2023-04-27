module.exports = app => {
    const workflow = require("../controllers/workflow.controller.js");
  
    var router = require("express").Router();
  
    // Create a new Workflow
    // router.post("/", workflow.create);
  
    // Retrieve all Workflows
    router.get("/work", workflow.findAll);
  
    // Retrieve a single Workflow with id
    router.get("/:id", workflow.findOne);
  
    // Update a Workflow with id.
    router.put("/:id", workflow.update);
  
    // Delete a Workflow with id.
    router.delete("/:id", workflow.delete);
  
    // Delete all Workflows
    router.delete("/", workflow.deleteAll);
  
    app.use('/api/workflows', router);
  };
  //api version
  //create folders for api
  //.