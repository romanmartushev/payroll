# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.26)
# Database: payroll
# Generation Time: 2020-02-20 15:13:52 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table deduction_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deduction_types`;

CREATE TABLE `deduction_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Code',
  `is_locked` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it locked?',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deduction_types_code_index` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `deduction_types` WRITE;
/*!40000 ALTER TABLE `deduction_types` DISABLE KEYS */;

INSERT INTO `deduction_types` (`id`, `name`, `code`, `is_locked`, `created_at`, `updated_at`)
VALUES
	(1,'Loan','loan',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(2,'Income Tax','income-tax',1,'2020-02-20 15:13:00','2020-02-20 15:13:00');

/*!40000 ALTER TABLE `deduction_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table deductions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deductions`;

CREATE TABLE `deductions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hashslug` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed Slug',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Owner of the record.',
  `payroll_id` int(10) unsigned NOT NULL COMMENT 'FK for payrolls',
  `payslip_id` int(10) unsigned NOT NULL COMMENT 'FK for payslips',
  `deduction_type_id` int(10) unsigned NOT NULL COMMENT 'FK for deduction_types',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'Description',
  `amount` bigint(20) DEFAULT '0' COMMENT 'Big amount of money',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deductions_hashslug_unique` (`hashslug`),
  KEY `deductions_user_id_index` (`user_id`),
  KEY `deductions_payroll_id_index` (`payroll_id`),
  KEY `deductions_payslip_id_index` (`payslip_id`),
  KEY `deductions_deduction_type_id_index` (`deduction_type_id`),
  CONSTRAINT `deductions_deduction_type_id_foreign` FOREIGN KEY (`deduction_type_id`) REFERENCES `deduction_types` (`id`),
  CONSTRAINT `deductions_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payrolls` (`id`),
  CONSTRAINT `deductions_payslip_id_foreign` FOREIGN KEY (`payslip_id`) REFERENCES `payslips` (`id`),
  CONSTRAINT `deductions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table earning_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `earning_types`;

CREATE TABLE `earning_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Code',
  `is_locked` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it locked?',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `earning_types_code_index` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `earning_types` WRITE;
/*!40000 ALTER TABLE `earning_types` DISABLE KEYS */;

INSERT INTO `earning_types` (`id`, `name`, `code`, `is_locked`, `created_at`, `updated_at`)
VALUES
	(1,'Basic','basic',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(2,'Overtime','overtime',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(3,'Allowance','allowance',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(4,'Bonus','bonus',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(5,'Claim','claim',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(6,'Other','other',1,'2020-02-20 15:13:00','2020-02-20 15:13:00');

/*!40000 ALTER TABLE `earning_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table earnings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `earnings`;

CREATE TABLE `earnings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hashslug` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed Slug',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Owner of the record.',
  `payroll_id` int(10) unsigned NOT NULL COMMENT 'FK for payrolls',
  `payslip_id` int(10) unsigned NOT NULL COMMENT 'FK for payslips',
  `earning_type_id` int(10) unsigned NOT NULL COMMENT 'FK for earning_types',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'Description',
  `amount` bigint(20) DEFAULT '0' COMMENT 'Big amount of money',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `earnings_hashslug_unique` (`hashslug`),
  KEY `earnings_user_id_index` (`user_id`),
  KEY `earnings_payroll_id_index` (`payroll_id`),
  KEY `earnings_payslip_id_index` (`payslip_id`),
  KEY `earnings_earning_type_id_index` (`earning_type_id`),
  CONSTRAINT `earnings_earning_type_id_foreign` FOREIGN KEY (`earning_type_id`) REFERENCES `earning_types` (`id`),
  CONSTRAINT `earnings_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payrolls` (`id`),
  CONSTRAINT `earnings_payslip_id_foreign` FOREIGN KEY (`payslip_id`) REFERENCES `payslips` (`id`),
  CONSTRAINT `earnings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(1,'2014_10_12_000000_create_users_table',1),
	(2,'2014_10_12_100000_create_password_resets_table',1),
	(3,'2020_02_20_140458_create_payroll_table',1),
	(4,'2020_02_20_140458_create_positions_table',1),
	(5,'2020_02_20_140458_create_salaries_table',1);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table payroll_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payroll_statuses`;

CREATE TABLE `payroll_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Code',
  `is_locked` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it locked?',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payroll_statuses_code_index` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `payroll_statuses` WRITE;
/*!40000 ALTER TABLE `payroll_statuses` DISABLE KEYS */;

INSERT INTO `payroll_statuses` (`id`, `name`, `code`, `is_locked`, `created_at`, `updated_at`)
VALUES
	(1,'Active','active',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(2,'Inactive','inactive',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(3,'Locked','locked',1,'2020-02-20 15:13:00','2020-02-20 15:13:00');

/*!40000 ALTER TABLE `payroll_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table payrolls
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payrolls`;

CREATE TABLE `payrolls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hashslug` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed Slug',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Owner of the record.',
  `month` tinyint(3) unsigned NOT NULL COMMENT 'Payroll for Month',
  `year` smallint(5) unsigned NOT NULL COMMENT 'Payroll for Year',
  `date` date NOT NULL COMMENT 'Pay Date / Pay Day',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is it locked?',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payrolls_hashslug_unique` (`hashslug`),
  KEY `payrolls_user_id_index` (`user_id`),
  CONSTRAINT `payrolls_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table payslip_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payslip_statuses`;

CREATE TABLE `payslip_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Code',
  `is_locked` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it locked?',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payslip_statuses_code_index` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `payslip_statuses` WRITE;
/*!40000 ALTER TABLE `payslip_statuses` DISABLE KEYS */;

INSERT INTO `payslip_statuses` (`id`, `name`, `code`, `is_locked`, `created_at`, `updated_at`)
VALUES
	(1,'Active','active',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(2,'Inactive','inactive',1,'2020-02-20 15:13:00','2020-02-20 15:13:00'),
	(3,'Locked','locked',1,'2020-02-20 15:13:00','2020-02-20 15:13:00');

/*!40000 ALTER TABLE `payslip_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table payslips
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payslips`;

CREATE TABLE `payslips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hashslug` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed Slug',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Owner of the record.',
  `payroll_id` int(10) unsigned NOT NULL COMMENT 'FK for payrolls',
  `total_earning` bigint(20) DEFAULT '0' COMMENT 'Total Earning',
  `total_deduction` bigint(20) DEFAULT '0' COMMENT 'Total Deduction',
  `basic_salary` bigint(20) DEFAULT '0' COMMENT 'Total Basic Salary',
  `gross_salary` bigint(20) DEFAULT '0' COMMENT 'Total Gross Salary',
  `net_salary` bigint(20) DEFAULT '0' COMMENT 'Total Net Salary',
  `is_verified` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it verified?',
  `verified_at` datetime DEFAULT NULL COMMENT 'Event occured at Date & Time',
  `verified_by` int(10) unsigned DEFAULT NULL,
  `verified_remarks` text COLLATE utf8mb4_unicode_ci COMMENT 'Remarks',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it approved?',
  `approved_at` datetime DEFAULT NULL COMMENT 'Event occured at Date & Time',
  `approved_by` int(10) unsigned DEFAULT NULL,
  `approved_remarks` text COLLATE utf8mb4_unicode_ci COMMENT 'Remarks',
  `is_locked` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is it locked?',
  `locked_at` datetime DEFAULT NULL COMMENT 'Event occured at Date & Time',
  `locked_by` int(10) unsigned DEFAULT NULL,
  `locked_remarks` text COLLATE utf8mb4_unicode_ci COMMENT 'Remarks',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payslips_hashslug_unique` (`hashslug`),
  KEY `payslips_user_id_index` (`user_id`),
  KEY `payslips_payroll_id_index` (`payroll_id`),
  KEY `payslips_verified_by_index` (`verified_by`),
  KEY `payslips_approved_by_index` (`approved_by`),
  KEY `payslips_locked_by_index` (`locked_by`),
  CONSTRAINT `payslips_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `payslips_locked_by_foreign` FOREIGN KEY (`locked_by`) REFERENCES `users` (`id`),
  CONSTRAINT `payslips_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payrolls` (`id`),
  CONSTRAINT `payslips_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `payslips_verified_by_foreign` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table positions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `positions`;

CREATE TABLE `positions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hashslug` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed Slug',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Owner of the record.',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `positions_hashslug_unique` (`hashslug`),
  KEY `positions_user_id_index` (`user_id`),
  CONSTRAINT `positions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table salaries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salaries`;

CREATE TABLE `salaries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hashslug` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed Slug',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Owner of the record.',
  `amount` bigint(20) DEFAULT '0' COMMENT 'Big amount of money',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salaries_hashslug_unique` (`hashslug`),
  KEY `salaries_user_id_index` (`user_id`),
  CONSTRAINT `salaries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
