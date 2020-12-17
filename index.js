const express = require('express')
const app = express()
const port = 3000
const config = {
    host: 'db',
    user: 'root',
    password: 'root',
    database:'nodedb'
};
// db - nome do container, que está no compose em cima de imagem.   
const mysql = require('mysql')
const connection = mysql.createConnection(config)
const sql = `INSERT INTO people(name) values ('leandro')`
    connection.query(sql)
    connection.end()
    app.get('/',(req,res) =>{
        res.send('<h1> full creation </h1>')
    })
    app.listen(port, ()=> {
        console.log('Rodando na porta ' + port)
    })