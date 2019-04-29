CREATE DATABASE `testdb`;

CREATE USER `happy`@`localhost` IDENTIFIED BY `happyobs`;
CREATE USER `happy`@`*`         IDENTIFIED BY `happyobs`;

GRANT ALL PRIVILEGES ON testdb.* TO `happy`@`localhost`;
/*GRANT ALL PRIVILEGES ON testdb.* TO `happy`@`140.115.*.*`;*/
GRANT ALL PRIVILEGES ON testdb.* TO `happy`@`*`;



FLUSH PRIVILEGES;