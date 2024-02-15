/*
CREATE DATABASE `schedule` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
*/




DROP TABLE IF EXISTS `schedule`.`schedule`;
DROP TABLE IF EXISTS `schedule`.`students`;
DROP TABLE IF EXISTS `schedule`.`groups`;
DROP TABLE IF EXISTS `schedule`.`subject`;
DROP TABLE IF EXISTS `schedule`.`subject_info`;
DROP TABLE IF EXISTS `schedule`.`subjects`;
DROP TABLE IF EXISTS `schedule`.`teachers`;
DROP TABLE IF EXISTS `schedule`.`people`;






DROP TABLE IF EXISTS `schedule`.`groups`;
CREATE TABLE `schedule`.`groups`(
	`id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
	`name` VARCHAR(30) NOT NULL,
	PRIMARY KEY(`id`)
 ) ENGINE = InnoDB;

INSERT INTO `schedule`.`groups`(`id`,`name`) VALUE
(1, "РПО-311"),
(2, "РПО-211");

DROP TABLE IF EXISTS `schedule`.`subjects`;
CREATE TABLE `schedule`.`subjects`(
	`id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
	`name` VARCHAR(128) UNIQUE NOT NULL,
	`description` TEXT NULL,
	PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `schedule`.`subjects`(`id`,`name`,`description`) VALUE
(1, "Основы философии", NULL),
(2, "База данных MySQL", NULL),
(3, "Основы права", NULL),
(4, "Базы данных", NULL),
(5, "Микропроцессорная техника", NULL),
(6, "Программирование в офисных приложениях", NULL),
(7, "Объектно-ориентированное программирование", NULL),
(8, "Основы предпринимательской деятельности", NULL),
(9, "Физическая культура", NULL),
(10, "Разработка WEB-дизайна", NULL),
(11, "Мобильная робототехника", NULL),
(12, "Основы политологии", NULL),
(13, "Культурология", NULL);

DROP TABLE IF EXISTS `schedule`.`people`;
CREATE TABLE `schedule`.`people`(
	`id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
	`name` VARCHAR(100) NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `schedule`.`people`(`id`,`name`) VALUE
(1, "Думан Калтаев"),
(2, "Иван Ильев"),
(3, "Ералы Гайрат"),
(4, "Максим Беляков"),
(5, "Александр Ненашев"),
(6, "Вадим Киблер"),
(7, "Никита Шинкаренко"),
(8, "Мирас Сарсен"),
(9, "Ермек Садвакасов"),
(10, "Армен Мелкумян"),
(11, "Владимир Валериевич"),
(12, "Ардак Булумбаев"),
(13, "Елена Сычева"),
(14, "Валентина Простоквашина"),
(15, "Батырхан Жунусов"),
(16, "Ляззат Исабекова");




DROP TABLE IF EXISTS `schedule`.`teachers`;
CREATE TABLE `schedule`.`teachers`(
	`teacher_id` INTEGER UNSIGNED NOT NULL,
	FOREIGN KEY(`teacher_id`) REFERENCES `schedule`.`people`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	PRIMARY KEY(`teacher_id`)
) ENGINE = InnoDB;

INSERT INTO `schedule`.`teachers`(`teacher_id`) VALUE
(11),
(12),
(13),
(14),
(15),
(16);


DROP TABLE IF EXISTS `schedule`.`students`;
CREATE TABLE `schedule`.`students`(
	`student_id` INTEGER UNSIGNED NOT NULL,
	`group_id` INTEGER UNSIGNED NOT NULL,
	FOREIGN KEY(`student_id`) REFERENCES `schedule`.`people`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY(`group_id`) REFERENCES `schedule`.`groups`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	UNIQUE KEY(`student_id`,`group_id`),
	PRIMARY KEY(`student_id`)
) ENGINE = InnoDB;

INSERT INTO `schedule`.`students`(`student_id`, `group_id`) VALUE
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1);









DROP TABLE IF EXISTS `schedule`.`subject_info`;
CREATE TABLE `schedule`.`subject_info`(
	`id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
	`subject_id` INTEGER UNSIGNED NOT NULL,
	`hours` TINYINT UNSIGNED NOT NULL,
	CONSTRAINT `snotri_subject_info__subject_id` FOREIGN KEY(`subject_id`) REFERENCES `schedule`.`subjects`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	UNIQUE KEY(`subject_id`, `hours`), 
	PRIMARY KEY(`id`)
) ENGINE = InnoDB;

INSERT INTO `schedule`.`subject_info`(`id`,`subject_id`,`hours`) VALUE
(1, 1, 144), -- 1, Основы философии, 144 часов
(2, 2, 127),
(3, 3, 48),
(4, 4, 100),
(5, 5, 48),
(6, 6, 144),
(7, 7, 127),
(8, 8, 24),
(9, 9, 48),
(10, 10, 144),
(11, 11, 122),
(12, 12, 87),
(13, 13, 10);

DROP TABLE IF EXISTS `schedule`.`subject`;
CREATE TABLE `schedule`.`subject`(
	`id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
	`subject_info_id` INTEGER UNSIGNED NOT NULL,
	`teacher_id` INTEGER UNSIGNED NOT NULL,
	FOREIGN KEY(`subject_info_id`) REFERENCES `schedule`.`subject_info`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY(`teacher_id`) REFERENCES `schedule`.`teachers`(`teacher_id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	UNIQUE KEY(`subject_info_id`, `teacher_id`), 
	PRIMARY KEY(`id`)
)	ENGINE = InnoDB;

INSERT INTO `schedule`.`subject`(`id`,`subject_info_id`,`teacher_id`) VALUE 
(1, 1, 12),
(2, 2, 11),
(3, 3, 12),
(4, 4, 11),
(5, 5, 16),
(6, 6, 13),
(7, 7, 11),
(8, 8, 15),
(9, 9, 15),
(10, 10, 11),
(11, 11, 11),
(12, 12, 12),
(13, 13, 12);

DROP TABLE IF EXISTS `schedule`.`schedule`;
CREATE TABLE `schedule`.`schedule`(
	`id` INTEGER UNSIGNED AUTO_INCREMENT NOT NULL,
	`weekday` INTEGER UNSIGNED NOT NULL,
	`group_id` INTEGER UNSIGNED NOT NULL,
	`subject_id` INTEGER UNSIGNED NOT NULL,
	`lesson` ENUM("1","2","3","4","5","6","7","8") NOT NULL,
	`week_type` ENUM("numerator","denomerator") NULL,
	FOREIGN KEY(`group_id`) REFERENCES `schedule`.`groups`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY(`subject_id`) REFERENCES `schedule`.`subject`(`id`)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	UNIQUE KEY(`weekday`,`group_id`, `subject_id`, `lesson`), 
	
	PRIMARY KEY(`id`)
) ENGINE = InnoDB;
INSERT INTO `schedule`.`schedule`(`id`,`weekday`,`group_id`,`subject_id`,`lesson`,`week_type`) VALUE
(1,1,1,1,4, NULL),
(2,1,1,2,5, NULL),
(3,1,1,3,6, NULL),

(4,2,1,4,4, NULL),
(5,2,1,5,5, NULL),
(6,2,1,5,6, NULL),
(7,2,1,6,7, NULL),

(8,3,1,5,3, NULL),
(9,3,1,2,4, NULL),
(10,3,1,7,5, "numerator"),
(11,3,1,8,5, "denomerator"),
(12,3,1,9,6, NULL),

(13,4,1,10,4, NULL),
(14,4,1,7,5, NULL),
(15,4,1,11,6, NULL),
(16,4,1,12,7, NULL),

(17,5,1,7,4, "numerator"),
(18,5,1,8,4, "denomerator"),
(19,5,1,13,5, NULL),
(20,5,1,11,6, NULL),

/* -------------------------------- */

(21,1,2,2,1, NULL),
(22,1,2,2,2, NULL),
(23,1,2,6,3, NULL),

(24,2,2,1,1, NULL),
(25,2,2,6,2, NULL),
(26,2,2,8,3, NULL),
(27,2,2,11,4, NULL),

(28,3,2,4,1, NULL),
(29,3,2,3,2, NULL),
(30,3,2,8,3, "numerator"),
(31,3,2,3,3, "denomerator"),
(32,3,2,9,4, NULL),

(33,4,2,10,1, NULL),
(34,4,2,2,2, NULL),
(35,4,2,12,3, NULL),
(36,4,2,1,4, NULL),

(37,5,2,7,1, "numerator"),
(38,5,2,8,1, "denomerator"),
(39,5,2,13,2, NULL),
(40,5,2,11,3, NULL);

DROP VIEW IF EXISTS `schedule`.`data`;
CREATE VIEW `schedule`.`data` AS 
	SELECT 
		`schedule`.`id` AS `schedule_id`,
		`schedule`.`group_id` AS `group_id`,
		`schedule`.`subject_id` AS `subject_id`,
		`schedule`.`weekday` AS `weekday`,
		`schedule`.`lesson` AS `lesson`,
		`schedule`.`week_type` AS `week_type`,
		`groups`.`name` AS `group_name`,
		`subjects`.`name` AS `subject_name` 
	FROM
		`schedule`.`schedule`,
		`schedule`.`groups`,
		`schedule`.`subjects`,
		`schedule`.`subject_info`,
		`schedule`.`subject`
	WHERE
		`schedule`.`group_id` = `groups`.`id`
	AND 
		`schedule`.`subject_id` = `subject`.`id`
	AND 
		`subject`.`subject_info_id` = `subject_info`.`subject_id`
	AND 
		`subject_info`.`subject_id` = `subjects`.`id`
	ORDER BY `schedule`.`id`;

DROP VIEW IF EXISTS `schedule`.`students_table`;
CREATE VIEW `schedule`.`students_table` AS
	SELECT
		`people`.`id` AS `id`,
		`students`.`student_id` AS `student_id`,
		`students`.`group_id` AS `group_id`,
		`groups`.`name` AS `group_name`,
		`people`.`name` AS `people_name`
	FROM 
		`schedule`.`people`,
		`schedule`.`groups`,
		`schedule`.`students`
	WHERE
		`students`.`student_id` = `people`.`id`
	AND
		`students`.`group_id` = `groups`.`id`
		;

