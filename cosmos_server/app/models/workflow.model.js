/**doc comment */
module.exports = mongoose => {
  const Workflow = mongoose.model(
    "workflow",
    mongoose.Schema(
      {
        title: String,
        description: String,
        works: [{
          name: String,
          description: String,
          state: Boolean
        }]
      },
    )
  );
  return Workflow;
};