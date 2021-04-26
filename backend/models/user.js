const mongoose = require('mongoose');

const UserSchema = mongoose.Schema({
    name:{
        type:String,
        required: true
    },
    mobileNumber : {
        type:String,
        required: true
    },
    email : {
        type:String,
        required:true
    },
    password:{
        type:String,
        required:true
    },
    CreatedOn: {
        type:Date,
        default : Date.now()
    },
    isVendor:{
        type:Boolean,
        defualt:false
    },
    cart:[{
        type:mongoose.Types.ObjectId,
        ref:'Item'
    }],
    Liked:{
        type:mongoose.Types.ObjectId,
        ref:'Item'
    }
})

module.exports = mongoose.model('User',UserSchema);