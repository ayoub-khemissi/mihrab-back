-- Database creation
CREATE DATABASE IF NOT EXISTS mihrab DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mihrab;

-- User table
DROP TABLE IF EXISTS user;
CREATE TABLE user (
    id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    email VARCHAR(50) UNIQUE NOT NULL,
    password_salt VARCHAR(255),
    password_hash VARCHAR(255),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    photo MEDIUMBLOB,
    is_suspended BOOLEAN DEFAULT FALSE,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED
);

-- Admin profile table
DROP TABLE IF EXISTS profile_admin;
CREATE TABLE profile_admin (
    user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Mosque manager profile table
DROP TABLE IF EXISTS profile_mosque_manager;
CREATE TABLE profile_mosque_manager (
    user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    position ENUM('president', 'secretary', 'treasurer', 'mosque_manager') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Imam profile table
DROP TABLE IF EXISTS profile_imam;
CREATE TABLE profile_imam (
    user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    bio TEXT,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Mosque table
DROP TABLE IF EXISTS mosque;
CREATE TABLE mosque (
    id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    picture MEDIUMBLOB,
    organization_name VARCHAR(100),
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    phone VARCHAR(255),
    max_capacity INT NULL,
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    supporting_document MEDIUMBLOB NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Mosque services table
DROP TABLE IF EXISTS mosque_service;
CREATE TABLE mosque_service (
    mosque_id BIGINT UNSIGNED NOT NULL,
    service_name ENUM('ablutions', 'women_space', 'children_classes', 'adult_classes', 'janaza', 'parking', 'aid_prayer') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    PRIMARY KEY (mosque_id, service_name),
    FOREIGN KEY (mosque_id) REFERENCES mosque(id)
);

-- Mosque social media table
DROP TABLE IF EXISTS mosque_social_media;
CREATE TABLE mosque_social_media (
    mosque_id BIGINT UNSIGNED NOT NULL,
    platform ENUM('website', 'instagram', 'facebook', 'youtube', 'twitter') NOT NULL,
    url VARCHAR(255) NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    PRIMARY KEY (mosque_id, platform),
    FOREIGN KEY (mosque_id) REFERENCES mosque(id)
);

-- Job offer table
DROP TABLE IF EXISTS job_offer;
CREATE TABLE job_offer (
    id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    mosque_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    remuneration INT UNSIGNED NOT NULL,
    urgent BOOLEAN NOT NULL DEFAULT FALSE,
    status ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    FOREIGN KEY (mosque_id) REFERENCES mosque(id)
);

-- Imam working hour table
DROP TABLE IF EXISTS imam_working_hour;
CREATE TABLE imam_working_hour (
    user_id BIGINT UNSIGNED NOT NULL,
    working_hour ENUM('full_time', 'part_time') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, working_hour),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Job offer working hour table
DROP TABLE IF EXISTS job_offer_working_hour;
CREATE TABLE job_offer_working_hour (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    working_hour ENUM('full_time', 'part_time') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (job_offer_id, working_hour),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Imam contract type table
DROP TABLE IF EXISTS imam_contract_type;
CREATE TABLE imam_contract_type (
    user_id BIGINT UNSIGNED NOT NULL,
    contract_type ENUM('permanent', 'fixed_term', 'occasional') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, contract_type),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Job offer contract type table
DROP TABLE IF EXISTS job_offer_contract_type;
CREATE TABLE job_offer_contract_type (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    contract_type ENUM('permanent', 'fixed_term', 'occasional') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (job_offer_id, contract_type),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Imam skill table
DROP TABLE IF EXISTS imam_skill;
CREATE TABLE imam_skill (
    user_id BIGINT UNSIGNED NOT NULL,
    skill ENUM('five_prayers', 'jumuah', 'aid_prayer', 'tarawih', 'quran_classes', 'conferences', 'questions_answers') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, skill),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Job offer skill table
DROP TABLE IF EXISTS job_offer_skill;
CREATE TABLE job_offer_skill (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    skill ENUM('five_prayers', 'jumuah', 'aid_prayer', 'tarawih', 'quran_classes', 'conferences', 'questions_answers') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (job_offer_id, skill),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Imam quran reading table
DROP TABLE IF EXISTS imam_quran_reading;
CREATE TABLE imam_quran_reading (
    imam_id BIGINT UNSIGNED NOT NULL,
    riwaya ENUM('hafs', 'warsh', 'qalun', 'al_duri', 'al_susi', 'shubah', 'khalaf') NOT NULL,
    hizb_hifz ENUM('0_10', '11_20', '21_30', '31_40', '41_50', '51_60', 'hafiz') NOT NULL,
    tajweed_mastery BOOLEAN NOT NULL,
    ijazah BOOLEAN NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (imam_id, riwaya),
    FOREIGN KEY (imam_id) REFERENCES user(id)
);

-- Job offer quran reading table
DROP TABLE IF EXISTS job_offer_quran_reading;
CREATE TABLE job_offer_quran_reading (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    riwaya ENUM('hafs', 'warsh', 'qalun', 'al_duri', 'al_susi', 'shubah', 'khalaf') NOT NULL,
    hizb_hifz ENUM('0_10', '11_20', '21_30', '31_40', '41_50', '51_60', 'hafiz') NOT NULL,
    tajweed_mastery BOOLEAN NOT NULL,
    ijazah BOOLEAN NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (job_offer_id, riwaya),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Imam language table
DROP TABLE IF EXISTS imam_language;
CREATE TABLE imam_language (
    imam_id BIGINT UNSIGNED NOT NULL,
    language ENUM('arabic', 'french') NOT NULL,
    level ENUM('beginner', 'intermediate', 'advanced', 'fluent') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (imam_id, language),
    FOREIGN KEY (imam_id) REFERENCES user(id)
);

-- Job offer language table
DROP TABLE IF EXISTS job_offer_language;
CREATE TABLE job_offer_language (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    language ENUM('arabic', 'french') NOT NULL,
    level ENUM('beginner', 'intermediate', 'advanced', 'fluent') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (job_offer_id, language),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Mosque manager like table
DROP TABLE IF EXISTS mosque_manager_like;
CREATE TABLE mosque_manager_like (
    mosque_manager_id BIGINT UNSIGNED NOT NULL,
    imam_id BIGINT UNSIGNED NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (mosque_manager_id, imam_id),
    FOREIGN KEY (mosque_manager_id) REFERENCES user(id),
    FOREIGN KEY (imam_id) REFERENCES user(id)
);

-- Imam like table
DROP TABLE IF EXISTS imam_like;
CREATE TABLE imam_like (
    imam_id BIGINT UNSIGNED NOT NULL,
    job_offer_id BIGINT UNSIGNED NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (imam_id, job_offer_id),
    FOREIGN KEY (imam_id) REFERENCES user(id),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Job offer benefit table
DROP TABLE IF EXISTS job_offer_benefit;
CREATE TABLE job_offer_benefit (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    benefit ENUM('apartment', 'office', 'library', 'administrative_assistant') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (job_offer_id, benefit),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id)
);

-- Application table
DROP TABLE IF EXISTS application;
CREATE TABLE application (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    imam_id BIGINT UNSIGNED NOT NULL,
    status ENUM('pending', 'rejected', 'interview', 'accepted') NOT NULL DEFAULT 'pending',
    message TEXT,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    PRIMARY KEY (job_offer_id, imam_id),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id),
    FOREIGN KEY (imam_id) REFERENCES user(id)
);

-- Notification table
DROP TABLE IF EXISTS notification;
CREATE TABLE notification (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    type ENUM('application', 'job_offer', 'like', 'notification', 'invitation') NOT NULL,
    message TEXT NOT NULL,
    url VARCHAR(255) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Invitation table
DROP TABLE IF EXISTS invitation;
CREATE TABLE invitation (
    job_offer_id BIGINT UNSIGNED NOT NULL,
    imam_id BIGINT UNSIGNED NOT NULL,
    message TEXT NOT NULL,
    status ENUM('pending', 'accepted', 'declined') NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    updated_at BIGINT UNSIGNED,
    PRIMARY KEY (job_offer_id, imam_id),
    FOREIGN KEY (job_offer_id) REFERENCES job_offer(id),
    FOREIGN KEY (imam_id) REFERENCES user(id)
);

-- Imam zone table
DROP TABLE IF EXISTS imam_zone;
CREATE TABLE imam_zone (
    user_id BIGINT UNSIGNED NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,  
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, address, city, zip_code, country),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Imam experience table
DROP TABLE IF EXISTS imam_experience;
CREATE TABLE imam_experience (
    user_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    start_date BIGINT UNSIGNED NOT NULL,
    end_date BIGINT UNSIGNED,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, title),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Imam diploma table
DROP TABLE IF EXISTS imam_diploma;
CREATE TABLE imam_diploma (
    user_id BIGINT UNSIGNED NOT NULL,
    diploma_name VARCHAR(100) NOT NULL,
    institution VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    year_obtained BIGINT UNSIGNED NOT NULL,
    description TEXT NOT NULL,
    created_at BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, diploma_name),
    FOREIGN KEY (user_id) REFERENCES user(id)
);
