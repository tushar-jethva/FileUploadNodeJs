const express = require('express');
const mongoose = require('mongoose');
const AuthRouter = require('./routes/auth');
const app = express();
const PORT = 3000;
const DB = "mongodb://127.0.0.1:27017/FileUpload?directConnection=true&serverSelectionTimeoutMS=2000";

app.use(express.json());
app.use(express.static('uploads/images/'));
app.use(AuthRouter);

mongoose.connect(DB).then(()=>{
    console.log("Connected with DB!")
}).catch((e)=>{
    console.log(e);
});

app.get('/',(req,res)=>{
    res.json({msg:"This is practice session!"});
});

app.listen(PORT,function(req,res){
    console.log("http://localhost:"+PORT);
});