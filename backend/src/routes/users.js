const {Router} = require('express');

const router = Router();

const faker = require('faker');
const User = require('../models/User');


router.get('/api/users', async (req,res) => {

    const users = await User.find();
    res.json({users});
   
});


router.get('/api/users/create',(req,res) => {
    for (let i = 0; i < 1; i++) {
        
        User.create({
            firstName: faker.name.firstName(),
            lastName: faker.name.lastName(),
            avatar: faker.image.avatar()
        });
        
    }
    res.json({message:'5 users created'});
});

router.get('/api/users/delete/:apellido',(req,res) => {
    
    var apellido= req.params.apellido;   
    var MongoClient = require('mongodb').MongoClient;
    //var url = "mongodb://localhost:27017/";
    
    MongoClient.connect("mongodb://localhost:27017/", function(err, db) {
      if (err) throw err;
      var dbo = db.db("flutter-node-tutorial");
      let myquery = { lastName: apellido };
      dbo.collection("users").deleteOne(myquery, function(err, obj) {
        if (err) throw err;
        console.log("1 document deleted:");
        db.close();
      });
    });

    res.json({message:'Usuario borrado:'});
});







module.exports= router;