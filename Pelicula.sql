-- Requerimientos
-- 1. Crear una base de datos llamada películas. (1 Punto)
\c daniela
DROP DATABASE peliculas;
CREATE DATABASE peliculas;
\c peliculas

-- 2. Cargar ambos archivos a su tabla correspondiente. (1 Punto)
CREATE TABLE peliculas( 
    id SERIAL, --serial aumenta de uno en uno
    Pelicula VARCHAR(100),
    Año_estreno INT,
    Director VARCHAR(50),
    PRIMARY KEY (id)
);

\copy peliculas FROM 'peliculas.csv' csv header;
SELECT * FROM peliculas LIMIT 10;

CREATE TABLE reparto(
    pelicula_id INT,
    actores VARCHAR(100),
    FOREIGN KEY(pelicula_id) REFERENCES peliculas(id) --mala práctica poner foreign key a ID
);

\copy reparto FROM 'reparto.csv' csv; --sin header porque no hay encabezado en la bbdd
SELECT * FROM reparto LIMIT 10;

-- 3. Obtener el ID de la película “Titanic”. (1 Punto)

SELECT id FROM peliculas WHERE Pelicula = 'Titanic';
-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Puntos)
SELECT actores FROM reparto WHERE pelicula_id = 2;
-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
SELECT COUNT(*) FROM reparto WHERE actores= 'Harrison Ford'; --en cuantos id está Harrison?? 8

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de
-- manera ascendente. (1 punto)
SELECT Pelicula FROM peliculas WHERE Año_estreno BETWEEN 1990 AND 1999 ORDER BY Pelicula ASC;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser
-- nombrado para la consulta como “longitud_titulo”. (1 punto)
SELECT Pelicula, LENGTH(Pelicula) AS longitud_titulo FROM peliculas LIMIT 10; 

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
-- (2 punto)
-- SELECT MAX(LENGTH(Pelicula)) FROM peliculas; --esta no da el nombre de la peli
SELECT Pelicula, LENGTH(Pelicula) AS longitud_titulo FROM peliculas WHERE LENGTH(Pelicula) = (SELECT MAX(LENGTH(Pelicula)) FROM peliculas);