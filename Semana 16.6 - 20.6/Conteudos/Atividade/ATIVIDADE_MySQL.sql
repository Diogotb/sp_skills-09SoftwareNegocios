CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE usuarios(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
matricula INT NOT NULL,
email VARCHAR(100) UNIQUE
);

CREATE TABLE livros(
idLivro INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
titulo VARCHAR(100) NOT NULL,
autor VARCHAR(100) NOT NULL,
codigo INT NOT NULL,
anoPublicacao INT NOT NULL
);

CREATE TABLE emprestimos(
idEmprestimo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
id INT NOT NULL,
idLivro INT NOT NULL,
dataEmprestimo DATETIME NOT NULL,
dataDevolucao DATETIME,
FOREIGN KEY (id) REFERENCES usuarios(id),
FOREIGN KEY (idLivro) REFERENCES livros(idLivro)
);

INSERT INTO usuarios(nome, matricula, email) VALUES
('João Francisco', 2023001, 'joao.francisco@gmail.com'),
('Lucas Pains', 2023002, 'lucas.pains@gmail.com');

INSERT INTO livros(titulo, autor, codigo, anoPublicacao) VALUES
('O Corvo', 'Edgar Allan Poe', '00001', 1845),
('A Divina Comédia', 'Dante Alighieri', '00002', 1321),
('MySQL: The Complete Reference', 'Vikram Vaswani', '00003', 2004),
('High Performance MySQL', 'Baron Schwartz', '00004', 2012),
('MySQL Crash Course', 'Ben Forta', '00005', 2005);

SELECT * FROM livros;

SELECT COUNT(*) FROM livros;

UPDATE usuarios SET email='pains.lucas@gmail.com' WHERE email='lucas.pains@gmail.com'; 

DELETE FROM usuarios WHERE id=1;
