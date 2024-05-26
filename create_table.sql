DROP DATABASE IF EXISTS ddbb_juego;

CREATE DATABASE ddbb_juego;
USE ddbb_juego;

DROP TABLE IF EXISTS heroe;
CREATE TABLE heroe (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre varchar(20),
	vida INT,
	ataque_p INT,
	ataque_m INT,
	defensa_p INT,
	defensa_m INT,
	velocidad INT
);

DROP TABLE IF EXISTS villano;
CREATE TABLE villano (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre varchar(20),
	vida INT,
	ataque_p INT,
	ataque_m INT,
	defensa_p INT,
	defensa_m INT,
	velocidad INT
);

DROP TABLE IF EXISTS combate;
CREATE TABLE combate (
	id INT AUTO_INCREMENT PRIMARY KEY,
    heroe_id INT,
    heroe_vida INT,
    villano_id INT,
    villano_vida INT
);

DROP TABLE IF EXISTS combate_log;
CREATE TABLE combate_log (
	id INT AUTO_INCREMENT PRIMARY KEY,
    ganador varchar(100),
    heroe_id INT,
    villano_id INT
);

DROP TABLE IF EXISTS combate_records;
CREATE TABLE combate_records (
	id INT AUTO_INCREMENT PRIMARY KEY,
    cantidad_victorias INT,
    heroe_id INT NULL,
    villano_id INT NULL
);

DROP TABLE IF EXISTS prueba;
CREATE TABLE prueba (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nada INT
);