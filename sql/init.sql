SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `mihrab` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mihrab`;

DROP TABLE IF EXISTS `application`;
CREATE TABLE IF NOT EXISTS `application` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `imam_id` bigint UNSIGNED NOT NULL,
  `status` enum('pending','rejected','accepted','canceled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`job_offer_id`,`imam_id`),
  KEY `imam_id` (`imam_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_contract_type`;
CREATE TABLE IF NOT EXISTS `imam_contract_type` (
  `user_id` bigint UNSIGNED NOT NULL,
  `contract_type` enum('permanent','fixed_term','occasional') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`contract_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_diploma`;
CREATE TABLE IF NOT EXISTS `imam_diploma` (
  `user_id` bigint UNSIGNED NOT NULL,
  `diploma_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_obtained` bigint UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`diploma_name`,`institution`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_experience`;
CREATE TABLE IF NOT EXISTS `imam_experience` (
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `start_date` bigint UNSIGNED NOT NULL,
  `end_date` bigint UNSIGNED DEFAULT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_language`;
CREATE TABLE IF NOT EXISTS `imam_language` (
  `imam_id` bigint UNSIGNED NOT NULL,
  `language` enum('arabic','french') COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` enum('beginner','intermediate','advanced','fluent') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`imam_id`,`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_like`;
CREATE TABLE IF NOT EXISTS `imam_like` (
  `imam_id` bigint UNSIGNED NOT NULL,
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`imam_id`,`job_offer_id`),
  KEY `job_offer_id` (`job_offer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_quran_reading`;
CREATE TABLE IF NOT EXISTS `imam_quran_reading` (
  `imam_id` bigint UNSIGNED NOT NULL,
  `riwaya` enum('hafs','warsh','qalun','al_duri','al_susi','shubah','khalaf') COLLATE utf8mb4_unicode_ci NOT NULL,
  `hizb_hifz` enum('zero_ten','ten_twenty','twenty_thirty','thirty_forty','forty_fifty','fifty_sixty','hafiz') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tajweed_mastery` tinyint(1) NOT NULL,
  `ijazah` tinyint(1) NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`imam_id`,`riwaya`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_skill`;
CREATE TABLE IF NOT EXISTS `imam_skill` (
  `user_id` bigint UNSIGNED NOT NULL,
  `skill` enum('five_prayers','jumuah','aid_prayer','tarawih','quran_classes','conferences','questions_answers') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`skill`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_working_hour`;
CREATE TABLE IF NOT EXISTS `imam_working_hour` (
  `user_id` bigint UNSIGNED NOT NULL,
  `working_hour` enum('full_time','part_time') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`working_hour`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `imam_zone`;
CREATE TABLE IF NOT EXISTS `imam_zone` (
  `user_id` bigint UNSIGNED NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`address`,`city`,`zip_code`,`country`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `invitation`;
CREATE TABLE IF NOT EXISTS `invitation` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `imam_id` bigint UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','accepted','declined') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`job_offer_id`,`imam_id`),
  KEY `imam_id` (`imam_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer`;
CREATE TABLE IF NOT EXISTS `job_offer` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `mosque_id` bigint UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remuneration` int UNSIGNED NOT NULL,
  `urgent` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mosque_id` (`mosque_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer_benefit`;
CREATE TABLE IF NOT EXISTS `job_offer_benefit` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `benefit` enum('apartment','office','library','administrative_assistant') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`job_offer_id`,`benefit`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer_contract_type`;
CREATE TABLE IF NOT EXISTS `job_offer_contract_type` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `contract_type` enum('permanent','fixed_term','occasional') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`job_offer_id`,`contract_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer_language`;
CREATE TABLE IF NOT EXISTS `job_offer_language` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `language` enum('arabic','french') COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` enum('beginner','intermediate','advanced','fluent') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`job_offer_id`,`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer_quran_reading`;
CREATE TABLE IF NOT EXISTS `job_offer_quran_reading` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `riwaya` enum('hafs','warsh','qalun','al_duri','al_susi','shubah','khalaf') COLLATE utf8mb4_unicode_ci NOT NULL,
  `hizb_hifz` enum('zero_ten','ten_twenty','twenty_thirty','thirty_forty','forty_fifty','fifty_sixty','hafiz') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tajweed_mastery` tinyint(1) NOT NULL,
  `ijazah` tinyint(1) NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`job_offer_id`,`riwaya`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer_skill`;
CREATE TABLE IF NOT EXISTS `job_offer_skill` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `skill` enum('five_prayers','jumuah','aid_prayer','tarawih','quran_classes','conferences','questions_answers') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`job_offer_id`,`skill`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_offer_working_hour`;
CREATE TABLE IF NOT EXISTS `job_offer_working_hour` (
  `job_offer_id` bigint UNSIGNED NOT NULL,
  `working_hour` enum('full_time','part_time') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`job_offer_id`,`working_hour`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `mosque`;
CREATE TABLE IF NOT EXISTS `mosque` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture` mediumblob,
  `organization_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_capacity` int DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `supporting_document` mediumblob NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `mosque_manager_like`;
CREATE TABLE IF NOT EXISTS `mosque_manager_like` (
  `mosque_manager_id` bigint UNSIGNED NOT NULL,
  `imam_id` bigint UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`mosque_manager_id`,`imam_id`),
  KEY `imam_id` (`imam_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `mosque_service`;
CREATE TABLE IF NOT EXISTS `mosque_service` (
  `mosque_id` bigint UNSIGNED NOT NULL,
  `service_name` enum('ablutions','women_space','children_classes','adult_classes','janaza','parking','aid_prayer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`mosque_id`,`service_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `mosque_social_media`;
CREATE TABLE IF NOT EXISTS `mosque_social_media` (
  `mosque_id` bigint UNSIGNED NOT NULL,
  `platform` enum('website','instagram','facebook','youtube','twitter') COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`mosque_id`,`platform`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `type` enum('application','job_offer','like','notification','invitation') COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `profile_admin`;
CREATE TABLE IF NOT EXISTS `profile_admin` (
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `profile_imam`;
CREATE TABLE IF NOT EXISTS `profile_imam` (
  `user_id` bigint UNSIGNED NOT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `profile_mosque_manager`;
CREATE TABLE IF NOT EXISTS `profile_mosque_manager` (
  `user_id` bigint UNSIGNED NOT NULL,
  `position` enum('president','secretary','treasurer','mosque_manager') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_salt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` mediumblob,
  `status` enum('active','suspended','disabled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` bigint UNSIGNED NOT NULL,
  `updated_at` bigint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
