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
    console.log(req.body);
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



router.post('/:number/BuyProducts',(req,res)=>{
    let number = req.params.number;
    User.findOne({mobileNumber:number}).then(user=>{
        if(!user){
            res.send('No User Found!');
            res.status(404);
        }else{
            req.body.items.forEach(item=>{
                user.orders.push(item);
            })
            user.save(err=>{
                if(err){
                    res.send(err);
                    res.status(400);
                }else{
                    res.status(200);
                    res.send('Order Recieved!');
                }
            })
        }
    })
})


router.get('/:number/getProducts',(req,res)=>{
    let number = req.params.number;
    User.findOne({mobileNumber:number},{mobileNumber:1,_id:0}).populate({path:'orders',model:'Item',select:{name:1,imageData:1,_id:1,title:1,Description:1,Availability:1}}).then(userProducts=>{
        if(!userProducts){
            res.status(404);
            res.send('User not Found');
        }else{
            res.status(200);
            res.send(userProducts);
        }
    })
})

module.exports = router;