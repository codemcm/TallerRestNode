const dbCon = require('../config/config');

function getUsers(req,res,next) {
    dbCon.any('SELECT * FROM PUBLIC.user')
    .then(function (data) {
        res
        .json({
            status:"successful",
            data:data,
            message:'Consulta exitosa'
        });
    })
    .catch( function(err){
        console.log(err)
        res.json
        ({
            status:"error",
            data:"no data...",
            message:err
        })
    })
}

function getStudentsByGroup(req,res,next) {
    var group_id = parseInt(req.params.group_id);

    dbCon.any('SELECT * FROM student_from_groupGet($1)', group_id)
    .then(function (data) {
        res
        .json({
            status:"successful",
            data:data,
            message:'Consulta exitosa'
        });
    })
    .catch( function(err){
        console.log(err)
        res.json
        ({
            status:"error",
            data:"no data...",
            message:err
        })
    })
}

function getStudent(req,res,next) {
    var alumnoid = parseInt(req.params.alumnoid);
    dbCon.one('SELECT * FROM ALUMNO WHERE alumnoid=$1', alumnoid)
    .then( function(data) {
        res.json({
            status: "successful",
            data: data,
            message: "Consulta exitosa"
        });
    })
    .catch(function(error){
            res.json({
                status: "error",
                data: "no data",
                message:error
            });
    })
}


function addStudent(req, res, next) {
  const query = "SELECT * FROM PUBLIC.studentAdd(${occupation_id}, ${first_name}, ${last_name},"+
                "${surname}, ${email}, ${phone}, ${address}, ${birthday} )";
  dbCon.one(query,req.body)
  .then(function(data){
      res.json({
          status: "successful",
          data: data,
          message: "Alumno registrado con exito"
      })
  })
  .catch(function(error){
      console.log(error);
      res.json({
          status: "error",
          data: "no data",
          message:error
      })
  })
}

function addStudentToGroup(req, res, next) {
    const query = "SELECT * FROM PUBLIC.studentAddToGroup(${student_id}, ${group_id})";
    dbCon.one(query,req.body)
    .then(function(data){
        res.json({
            status: "successful",
            data: data,
            message: "Alumno asignado a grupo"
        })
    })
    .catch(function(error){
        console.log(error);
        res.json({
            status: "error",
            data: "no data",
            message:error
        })
    })
  }

function updateStudent(req,res,next) {
    dbCon.none('UPDATE alumno set nombre=$1 WHERE alumnoid=$2',
               [req.body.nombre, parseInt(req.params.alumnoid) ])
    .then(function(){
        res.json({
            status: "successful",
            data: "Without data",
            message: "Consulta exitosa"
        })
    })
    .catch(function(error){
        console.log(error)
        res.json({
            status: "error",
            data: "no data",
            message:error
        })
    })
}

function deleteStudent(req,res,next) {
    var alumnoid = parseInt(req.params.alumnoid);
    dbCon.any('DELETE FROM alumno WHERE alumnoid=$1', alumnoid)
    .then(function(){
        res.json({
            status: "successful",
            data: "Without data",
            message: "Consulta exitosa"
        })
    })
    .catch(function(error){
        console.log(error)
        res.json({
            status: "error",
            data: "no data",
            message:error
        })
    })
}

function respondiend(req, res, next) {
    res.send('respond with a resource');
  }

module.exports = {
    getUsers: getUsers,
    getStudentsByGroup: getStudentsByGroup,
    respondiend: respondiend,
    getStudent: getStudent,
    addStudent: addStudent,
    updateStudent: updateStudent,
    deleteStudent: deleteStudent,
    addStudentToGroup: addStudentToGroup
}
