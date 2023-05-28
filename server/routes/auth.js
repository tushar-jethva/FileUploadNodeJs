const express = require('express');
const AuthModel = require('../models/auth_model');
const fs = require('fs-extra');
const multer = require('multer');
const path = require('path');
const FileUploadModel = require('../models/file_model');
const AuthRouter = express.Router();
const IP = "192.168.174.230";
const PORT = 3000;

const storage = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null,"uploads/images");
    },
    filename:(req,file,cb)=>{
        cb(null,file.originalname);
        
    }
});

const upload = multer({storage});

//single
AuthRouter.post('/uploadOne',upload.single('uploadFile'),(req,res)=>{
    if(req.file != null){
        res.json({"url":`http://${IP}:${PORT}/${arr[i]['originalname']}`});
    }
});

//multiple
AuthRouter.post("/uploadMulti",upload.array('uploadFile'),async(req,res)=>{
    
    const {name} = req.body;
    console.log(name);
    console.log(req.files);
    let arr = req.files;
    console.log(req.files); 
    let list = [];
    for(let i=0;i<arr.length;i++){
        list.push(`http://${IP}:${PORT}/${arr[i]['originalname']}`);
    }
    let file = new FileUploadModel({
        name,
        path:list
    });
    
    file = await file.save();
    res.json(file);
});


AuthRouter.get('/api',async(req,res)=>{
    res.send("Hello router");
});


AuthRouter.post('/api/auth',async(req,res)=>{
        try{
            console.log(req.body);
            let {name,mobile_no,area,city} = req.body;
            mobile_no = mobile_no.replaceAll(" ","");
            console.log(mobile_no);
            const user = await AuthModel.findOne({mobile_no});
            if(user){
                return res.status(400).json({"msg":"Mobile Number is already exist!"});
            }
    
            let newUser = new AuthModel({
                name,
                mobile_no,
                area,
                city
            });
    
            newUser = await newUser.save();
            res.json(newUser);
        }
        catch(e){
            res.status(500).json({error:e.message});
        }
    });

AuthRouter.get("/api/getAll",async(req,res)=>{

    try{
        const users = await AuthModel.find({});
        res.json(users);
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
})


module.exports = AuthRouter;