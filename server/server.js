const express = require('express');
const mongoose = require('mongoose');
const Location = require("./models/Location");

const app = express();

app.use(express.urlencoded({extended:true}));
app.use(express.json());

mongoose.connect("mongodb+srv://vibin10njr:w6VgI2LNaksC7IQH@weatherapp.pt7u5.mongodb.net/weatherapp?retryWrites=true&w=majority&appName=weatherApp").then(()=>{
    console.log("Mongodb Connected");
}).catch((error)=>{
    console.log(error);
})

app.get('/',async(req,res)=>{
    const locations = await Location.find();

    if(locations){
        res.status(200).json({locations})
    }else{
        res.status(404).json({message:"Not Found"});
    }
});

app.post("/",async (req,res)=>{
    console.log(req.body);
    const {place} = req.body;
    if(place){
        const newLocation = new Location({
            place
        });
        await newLocation.save();
        res.status(200).json({message:"Location added successfully"});
    }
})


app.listen(8000,()=>{
    console.log('connected to server http://localhost:8000');
})