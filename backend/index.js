require('dotenv').config();
var mongoose = require('mongoose');
const express = require('express');
var app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const userRouter = require('./routes/userRouter');
// const itemRouter = require('./routes/itemRouter');
const vendorRouter = require('./routes/vendorRouter');
app.use(cors())
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
const PORT = process.env.PORT || 7000 ;


mongoose.connect(process.env.DB_STRING,{ useNewUrlParser: true , useUnifiedTopology: true});

app.get('/',(req,res)=>{
    res.send('Connected!');
})

app.use('/users',userRouter);
app.use('/vendors',vendorRouter);

app.listen(PORT,()=>{
    console.log(`DB CONNECTED! Server listening on Port ${PORT}`);
});