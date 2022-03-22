-- SET @user = "alex";

-- CREATE SCHEMA `movie_db` ;
use `movie_db`;


CREATE TABLE `publications` (
`name` VARCHAR(250) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
`avatar` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
PRIMARY KEY (`name`) USING BTREE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;


CREATE TABLE `reviewers` (
`name` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
`publication` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
`avatar` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
PRIMARY KEY (`name`) USING BTREE,
INDEX `publication_fk` (`publication`) USING BTREE,
CONSTRAINT `publication_fk` FOREIGN KEY (`publication`) REFERENCES `movie_db`.`publications` (`name`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;



CREATE TABLE `movies` (
`title` VARCHAR(250) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
`release` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
`score` INT NULL DEFAULT NULL,
`reviewer` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
PRIMARY KEY (`title`) USING BTREE,
INDEX `reviewer_id` (`reviewer`) USING BTREE,
CONSTRAINT `reviewer_id` FOREIGN KEY (`reviewer`) REFERENCES `movie_db`.`reviewers` (`name`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

use `movie_db`;

-- INSERT into publications (name, avatar) VALUES('NombreRevista', 'imagenrevista');
INSERT INTO publications (name, avatar) VALUES ('The Daily Reviewer', 'glyphicon-eye-open'),('International Movie Critic', 'glyphicon-fire'),('MoviesNow', 'glyphicon-time'),('MyNextReview', 'glyphicon-record'),('Movies Games', 'glyphicon-heart-empty'),('TheOne', 'glyphicon-globe'),('ComicBookHero.com', 'glyphicon-flash');


-- INSERT into reviewers (name, publication, avatar) VALUES ('NombreReviewer', 'NombreRevista', 'imagenReviewer');
INSERT INTO reviewers (name, publication, avatar) VALUES ('Robert Smith', 'The Daily Reviewer', 'https://s3.amazonaws.com/uifaces/faces/twitter/angelcolberg/128.jpg'),('Chris Harris', 'International Movie Critic', 'https://s3.amazonaws.com/uifaces/faces/twitter/bungiwan/128.jpg'), ('Janet Garcia', 'MoviesNow', 'https://s3.amazonaws.com/uifaces/faces/twitter/grrr_nl/128.jpg'),('Andrew West', 'MyNextReview', 'https://s3.amazonaws.com/uifaces/faces/twitter/d00maz/128.jpg'), ('Mindy Lee', 'Movies Games', 'https://s3.amazonaws.com/uifaces/faces/twitter/laurengray/128.jpg'),('Martin Thomas', 'TheOne', 'https://s3.amazonaws.com/uifaces/faces/twitter/karsh/128.jpg'),('Anthony Miller', 'ComicBookHero.com', 'https://s3.amazonaws.com/uifaces/faces/twitter/9lessons/128.jpg');


-- INSERT into movies (title, `release`, score, reviewer) VALUES ('NombrePelicula', 2010, 5,'NombreReviewer');
INSERT INTO movies (title, `release`, score, reviewer) VALUES ('Suicide Squad', 2016, 8, 'Robert Smith'),('Batman vs. Superman', 2016, 6, 'Chris Harris'),('Captain America: Civil War', 2016, 9, 'Janet Garcia'),('Deadpool', 2016, 9, 'Andrew West'),('Avengers: Age of Ultron', 2015, 7, 'Mindy Lee'),('Ant-Man', 2015, 8, 'Martin Thomas'),('Guardians of the Galaxy', 2014, 10, 'Anthony Miller'),('Doctor Strange', 2016, 7, 'Anthony Miller'),('Superman: Homecoming', 2017, 10, 'Chris Harris'),('Wonder Woman', 2017, 8, 'Martin Thomas');