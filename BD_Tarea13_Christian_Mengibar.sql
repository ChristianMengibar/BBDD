CREATE DATABASE game_management;

USE game_management;

/* 1. CREAR LAS SENTENCIAS SQL */

CREATE TABLE IF NOT EXISTS genres (
id INT NOT NULL AUTO_INCREMENT,
genre_name VARCHAR(50),
PRIMARY KEY (id) 
);

CREATE TABLE IF NOT EXISTS games (
id INT NOT NULL AUTO_INCREMENT,
genre_id INT NOT NULL,
game_name VARCHAR (50) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_games_id
FOREIGN KEY (genre_id)
REFERENCES genres (id)
);

CREATE TABLE IF NOT EXISTS publishers (
id INT NOT NULL AUTO_INCREMENT,
publisher_name VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS games_publishers (
id INT AUTO_INCREMENT NOT NULL,
game_id INT NOT NULL,
publisher_id INT,
PRIMARY KEY (id),
CONSTRAINT fk_gampubl_gamid
FOREIGN KEY (game_id)
REFERENCES games (id)
	ON UPDATE CASCADE,
CONSTRAINT fk_gampubl_publid
FOREIGN KEY (publisher_id)
REFERENCES publishers (id)
	ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS platforms (
id INT NOT NULL AUTO_INCREMENT,
platform_name VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS games_platforms (
id INT NOT NULL AUTO_INCREMENT,
game_publisher_id INT,
platform_id INT,
release_year INT,
PRIMARY KEY (id),
CONSTRAINT fk_gampla_id
FOREIGN KEY (game_publisher_id)
REFERENCES games_publishers (id)
	ON UPDATE CASCADE,
CONSTRAINT fk_gampla_plaid
FOREIGN KEY (platform_id)
REFERENCES platforms (id)
	ON UPDATE CASCADE
);

 /* SIN CLAVES PRINCIPALES NI AJENAS */
CREATE TABLE IF NOT EXISTS regions (
id INT NOT NULL,
region_name VARCHAR(50)
);

 /* SIN CLAVES PRINCIPALES NI AJENAS */
CREATE TABLE IF NOT EXISTS regions_sales (
region_id INT NOT NULL,
game_platform_id INT NOT NULL,
num_sales INT NOT NULL
);

ALTER TABLE regions
MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE regions_sales
ADD CONSTRAINT pk_regionsal_id PRIMARY KEY (region_id, game_platform_id);

ALTER TABLE regions_sales
ADD CONSTRAINT fk_region_id FOREIGN KEY (region_id)
REFERENCES regions (id);

ALTER TABLE regions_sales
ADD CONSTRAINT fk_game_platform_id FOREIGN KEY (game_platform_id)
REFERENCES games_platforms (id);

/* 2. CREAR UN INDICE PARA CADA TABLA QUE INCLUYA CAMPOS CLAVE Y AJENOS */

CREATE INDEX idx_gam ON games (id, genre_id);

CREATE INDEX idx_publ ON publishers (id);

CREATE INDEX idx_gampubl ON games_publishers (id, game_id, publisher_id);

CREATE INDEX idx_plat ON platforms (id);

CREATE INDEX idx_gamplat ON games_platforms (id, game_publisher_id, platform_id);

CREATE INDEX idx_regsal ON regions_sales (region_id, game_platform_id);

CREATE INDEX idx_reg ON regions (id);

/* 3. AÑADIMOS MAS RESTRICCIONES */

ALTER TABLE regions
ADD CONSTRAINT uc_reg_nam
UNIQUE (region_name);

ALTER TABLE publishers
ADD CONSTRAINT uc_publ_nam
UNIQUE (publisher_name);

ALTER TABLE regions_sales
ALTER num_sales SET DEFAULT 0;

ALTER TABLE games_platforms
ALTER rel_year SET DEFAULT 1989;

ALTER TABLE regions_sales
ADD CONSTRAINT chk_regsal_numsal CHECK (num_sales >= 0);

ALTER TABLE games_platforms
ADD CONSTRAINT chk_gamplat_relyear CHECK (release_year >= 1989);


/* 4. ELIMINA LAS RESTRICCIONES DEL PUNTO ANTERIOR */

DROP INDEX uc_reg_nam ON regions;

DROP INDEX uc_publ_nam ON publishers;

ALTER TABLE regions_sales
ALTER num_sales DROP DEFAULT;

ALTER TABLE games_platforms
ALTER rel_year DROP DEFAULT;

ALTER TABLE regions_sales
DROP CHECK chk_regsal_numsal;

ALTER TABLE games_platforms
DROP CHECK chk_gamplat_relyear;

/* FIN */