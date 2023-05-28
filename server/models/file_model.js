const mongoose = require('mongoose');

const FileUploadSchema = new mongoose.Schema({
    name:{
        default:"TJ",
        type:String
    },
    path:[
        {
            type:String,
        }
    ],
});

const FileUploadModel = mongoose.model('File',FileUploadSchema);
module.exports = FileUploadModel;