const express = require('express');
const Vendor = require('../models/vendor');
const router = express.Router();

router.post('/signup',(req,res)=>{
    Vendor.findOne({mobileNumber : req.body.mobileNumber},(err,vendor)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            if(vendor == null){
                const vendor = Vendor({
                    mobileNumber : req.body.mobileNumber,
                    email : req.body.email,
                    password: req.body.password,
                    name:req.body.name
                })
                vendor.save().then(err=>{
                    if(err){
                        console.log(err);
                        res.json(err);
                    }
                    else{
                        res.json(vendor);
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
    Vendor.findOne({mobileNumber:req.body.mobileNumber,password:req.body.password},(err,vendor)=>{
        if(err){
            console.log(err);
            res.status(404);
        }
        else if(vendor!==null){
            req.Id = vendor._id;
            res.status(200);
            res.json(vendor);
        }else{
            res.status(404);
            res.json({
                message : 'Vendor Details not found'
            })
        }
    })
})

module.exports = router;