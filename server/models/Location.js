const mongoose = require('mongoose');

const locationSchema = new mongoose.Schema({
    place:{
        type:String,
        required:true
    },

},{timestamps:true});


const Location = mongoose.model('Location',locationSchema);
module.exports = Location;