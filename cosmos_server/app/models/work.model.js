module.exports = mongoose => {
    const Work = new mongoose.Schema({
        title: String,
        description: String,
        state: Boolean
      });
  
    return Work;
  };