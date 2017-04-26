-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.17 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table mmorts.army
CREATE TABLE IF NOT EXISTS `army` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `position_x` int(255) DEFAULT NULL,
  `position_y` int(255) DEFAULT NULL,
  `city_id` int(255) DEFAULT NULL,
  `spearmen` int(255) DEFAULT NULL,
  `swordmen` int(255) DEFAULT NULL,
  `archers` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.army: ~0 rows (approximately)
/*!40000 ALTER TABLE `army` DISABLE KEYS */;
/*!40000 ALTER TABLE `army` ENABLE KEYS */;


-- Dumping structure for table mmorts.buildings
CREATE TABLE IF NOT EXISTS `buildings` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `city_id` int(255) DEFAULT NULL,
  `user_id` int(255) DEFAULT NULL,
  `type` int(2) DEFAULT NULL,
  `level` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.buildings: ~0 rows (approximately)
/*!40000 ALTER TABLE `buildings` DISABLE KEYS */;
/*!40000 ALTER TABLE `buildings` ENABLE KEYS */;


-- Dumping structure for table mmorts.cities
CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user_id` int(255) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `resources_id` int(255) DEFAULT NULL,
  `buildings_id` int(255) DEFAULT NULL,
  `production_id` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.cities: ~1 rows (approximately)
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` (`id`, `user_id`, `name`, `resources_id`, `buildings_id`, `production_id`) VALUES
	(2, 2, 'Athens', 2, NULL, NULL);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;


-- Dumping structure for table mmorts.configuration
CREATE TABLE IF NOT EXISTS `configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `seperator` varchar(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `maintenance` int(1) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.configuration: ~1 rows (approximately)
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` (`id`, `name`, `seperator`, `description`, `maintenance`, `logo`) VALUES
	(1, 'MMORTS', ' - ', 'Oh my it works!', 0, 'logo-knight.jpg');
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;


-- Dumping structure for table mmorts.map
CREATE TABLE IF NOT EXISTS `map` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `x` int(255) DEFAULT NULL,
  `y` int(255) DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.map: ~0 rows (approximately)
/*!40000 ALTER TABLE `map` DISABLE KEYS */;
/*!40000 ALTER TABLE `map` ENABLE KEYS */;


-- Dumping structure for table mmorts.production
CREATE TABLE IF NOT EXISTS `production` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `city_id` int(255) DEFAULT NULL,
  `planks_production` int(255) DEFAULT NULL,
  `ore_production` int(255) DEFAULT NULL,
  `clay_production` int(255) DEFAULT NULL,
  `food_production` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.production: ~0 rows (approximately)
/*!40000 ALTER TABLE `production` DISABLE KEYS */;
INSERT INTO `production` (`id`, `city_id`, `planks_production`, `ore_production`, `clay_production`, `food_production`) VALUES
	(1, 2, 60, 60, 60, 60);
/*!40000 ALTER TABLE `production` ENABLE KEYS */;


-- Dumping structure for table mmorts.profiles
CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.profiles: ~0 rows (approximately)
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;


-- Dumping structure for table mmorts.resources
CREATE TABLE IF NOT EXISTS `resources` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user_id` int(255) NOT NULL,
  `city_id` int(255) NOT NULL,
  `planks` int(255) NOT NULL,
  `ore` int(255) NOT NULL,
  `clay` int(255) NOT NULL,
  `food` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.resources: ~1 rows (approximately)
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` (`id`, `user_id`, `city_id`, `planks`, `ore`, `clay`, `food`) VALUES
	(2, 2, 2, 485, 375, 325, 525);
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;


-- Dumping structure for table mmorts.terrain-types
CREATE TABLE IF NOT EXISTS `terrain-types` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `type` int(255) DEFAULT NULL,
  `terrain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.terrain-types: ~0 rows (approximately)
/*!40000 ALTER TABLE `terrain-types` DISABLE KEYS */;
/*!40000 ALTER TABLE `terrain-types` ENABLE KEYS */;


-- Dumping structure for table mmorts.units
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(50) DEFAULT NULL,
  `attack_value` int(255) DEFAULT NULL,
  `defence_value` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.units: ~0 rows (approximately)
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
/*!40000 ALTER TABLE `units` ENABLE KEYS */;


-- Dumping structure for table mmorts.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` char(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table mmorts.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES
	(2, 'jebcoding', '$2y$10$0VQNecLgN.LPszd3/A9TuuVe4Gds7lIQCifCBDQqNftHEr8ombMAK', 'jebcoding@youtube.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
