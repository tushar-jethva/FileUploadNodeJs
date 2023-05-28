const mongoose = require('mongoose');

const AuthSchema = new mongoose.Schema({
    name:{
        required:true,
        type:String
    },
    mobile_no:{
        required:true,
        type:String,
        trim:true
    },
    area:{
        required:true,
        type:String,
    },
    city:{
        required:true,
        type:String,
    }
});

const AuthModel = mongoose.model('User',AuthSchema);
module.exports = AuthModel;