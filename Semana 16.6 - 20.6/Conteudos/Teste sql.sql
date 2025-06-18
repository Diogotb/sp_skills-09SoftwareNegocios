CREATE DATABASE teste;
USE teste;

CREATE TABLE IF NOT EXISTS teste1(
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
cidade VARCHAR(255) NOT NULL,
dataNascimento DATE
);

CREATE TABLE persons(
Personid INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
sobrenome VARCHAR(255) NOT NULL,
nome VARCHAR(255),
idade INT,
telefone INT(11) NOT NULL,
cpf INT(11) NOT NULL,
cep INT(7) NOT NULL
)

INSERT INTO teste1(nome,cidade,dataNascimento)
VALUES ("Geralto","Limeira", "2007-12-13")

DROP TABLE teste1

INSERT INTO persons(sobrenome, nome, telefone, cpf, cep)
VALUES ("Picinin", "Miguel", "199984101", "23390818", "130420")

DROP TABLE persons

ALTER TABLE persons
ADD carro BOOLEAN
