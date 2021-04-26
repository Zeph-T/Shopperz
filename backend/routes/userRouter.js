const express = require('express');
const User = require('../models/user');
const router = express.Router();

router.post('/signup',(req,res)=>{
    User.findOne({mobileNumber : req.body.mobileNumber},(err,user)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            if(user == null){
                const user = User({
                    mobileNumber : req.body.mobileNumber,
                    email : req.body.email,
                    password: req.body.password,
                    name:req.body.name
                })
                user.save().then(err=>{
                    if(err){
                        console.log(err);
                        res.json(err);
                    }
                    else{
                        res.json(user);
                    }
                })
            }else{
                res.status(409);
                res.json({
                    message : 'mobile number  is already taken'
                })
            }
        }
    })
})

router.post('/signin',(req,res)=>{
    User.findOne({mobileNumber:req.body.mobileNumber,password:req.body.password},(err,user)=>{
        if(err){
            console.log(err);
            res.status(404);
        }
        else if(user!==null){
            req.Id = user._id;
            res.status(200);
            res.json(user);
        }else{
            res.status(404);
            res.json({
                message : 'User Details not found'
            })
        }
    })
})


module.exports = router;