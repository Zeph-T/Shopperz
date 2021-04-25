const mongoose = require('mongoose');

const ItemSchema = mongoose.Schema({
    Name:{
        type:String,
        required:true,
    },
    Vendor:{
        type:mongoose.Types.ObjectId,
        ref:'Vendor',
    },
    Reviews : {
        type:String
    },
    Content:{
        type:String
    },
    NumOfReviews : {
        type:Number,
        default : 0
    },
    DateAdded:{
        type:Date,
        default : Date.now()
    },
    cost:{
        type:Number,
        required:true
    },
    Description:{
        type:String
    },
    Quantity: {
        type:Number,
        required:true,
        default : 0
    }
})

module.exports = mongoose.model('Item',ItemSchema);