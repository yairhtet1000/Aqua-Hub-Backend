-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: laravel
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (68,'Freshwater','freshwater','Knowledge or help about freshwater aquarium','2026-08-12 10:27:40','2026-08-12 10:27:40',NULL),(69,'Saltwater','saltwater','Knowledge and help about saltwater aquarium','2026-08-12 10:28:08','2026-08-12 10:28:08',NULL),(70,'Sick Fish','sick-fish','Seeking help about sick fish or about cure','2026-08-12 10:28:46','2026-08-12 10:28:46',NULL),(71,'Fish Disease','fish-disease','Knowledge and help about fish disease','2026-08-12 10:29:26','2026-08-12 10:29:26',NULL),(72,'Did you know?','did-you-know','Knowledge sharing about aquarium tips and tricks','2026-08-13 12:17:05','2026-08-13 12:17:05',NULL),(73,'Medication','medication','Medication methods for sick fish','2026-08-13 12:22:48','2026-08-13 12:22:48',NULL),(74,'Don\'t do it!','dont-do-it','Debunking false info!','2026-08-14 10:36:31','2026-08-14 10:36:31',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `post_id` bigint unsigned NOT NULL,
  `parent_comment_id` bigint unsigned DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_post_id_foreign` (`post_id`),
  KEY `comments_parent_comment_id_foreign` (`parent_comment_id`),
  CONSTRAINT `comments_parent_comment_id_foreign` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (45,512,68,NULL,'What treatment are you going on them?','2026-08-13 11:18:29','2026-08-13 11:18:29',NULL),(46,511,68,45,'I haven\'t done anything right now. This is my first tank and I don\'t know what to do.','2026-08-13 11:19:28','2026-08-13 11:19:28',NULL),(47,511,71,NULL,'Wow! That looks so coool!!','2026-08-13 12:19:10','2026-08-13 12:19:10',NULL),(48,512,71,47,'Thanks. Much appreciated.','2026-08-13 12:19:32','2026-08-13 12:19:32',NULL),(49,514,74,NULL,'Nice plants','2026-08-13 12:59:18','2026-08-13 12:59:18',NULL),(50,513,74,49,'Thanks a lot','2026-08-13 12:59:44','2026-08-13 12:59:44',NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `follower_id` bigint unsigned NOT NULL,
  `following_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`follower_id`,`following_id`),
  KEY `follows_following_id_foreign` (`following_id`),
  CONSTRAINT `follows_follower_id_foreign` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `follows_following_id_foreign` FOREIGN KEY (`following_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES (511,11,NULL,NULL),(511,512,NULL,NULL),(512,511,NULL,NULL),(513,514,NULL,NULL),(514,513,NULL,NULL);
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` bigint unsigned DEFAULT NULL,
  `comment_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `images_post_id_foreign` (`post_id`),
  KEY `images_comment_id_foreign` (`comment_id`),
  CONSTRAINT `images_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `images_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (3,'posts/OXn3xAAYOpp3HSG4qb6gNcN6RjI0KGwFrDotAN94.jpg',67,NULL,'2026-08-12 10:30:18','2026-08-12 10:30:18',NULL),(4,'posts/ZfvrhrPqjtv99m97Ju5lh6sIrJnsUs9LL1oFZeyB.jpg',68,NULL,'2026-08-13 11:17:46','2026-08-13 11:17:46',NULL),(5,'posts/9ou1lpnYCLtLr9ye5NI9BGNzn09gTD0KGZUKA9wQ.jpg',69,NULL,'2026-08-13 11:33:07','2026-08-13 12:03:25','2026-08-13 12:03:25'),(6,'posts/kZ1cAN3S3kp9X1sfGJGlefY8V2p8TcA0l9EbI8r9.jpg',70,NULL,'2026-08-13 11:34:24','2026-08-13 11:34:24',NULL),(7,'posts/JdJtxLciVwZ9Ktp7GSr2VLEEfQQsC8A452yKKdbl.jpg',71,NULL,'2026-08-13 12:18:48','2026-08-13 12:18:48',NULL),(8,'posts/8GGtrZ4nWRW91B2uz4UcZnExKURthQkIY3iCkzWG.jpg',72,NULL,'2026-08-13 12:26:29','2026-08-13 12:26:29',NULL),(9,'posts/bHjGz42DgkfmyCHcnHwfag9T9JFfj3p1OLhiOdRz.jpg',73,NULL,'2026-08-13 12:29:16','2026-08-13 12:29:16',NULL),(10,'posts/4hHgsJJAF5tzYIxJydJPoUK8qivjjVQFTOX0uafG.jpg',74,NULL,'2026-08-13 12:58:26','2026-08-13 12:58:26',NULL),(11,'posts/Dx5Hh9ynGOazX65yHbIsOzH6qUFfL886CjokVYBf.jpg',75,NULL,'2026-08-13 13:01:07','2026-08-13 13:01:07',NULL),(12,'posts/TxT3AeuPLh2CHvMDv8ENqj0NsKfDimBxUXXFMBvF.png',76,NULL,'2026-08-14 10:33:26','2026-08-14 10:33:26',NULL),(13,'posts/UyY5UUDyird7zed5LB142LgyhByaMECuRorFGdWd.jpg',77,NULL,'2026-08-14 10:34:15','2026-08-14 10:34:15',NULL),(14,'posts/ljlne8wMYjZaAwD4cI4WdBDyzBTbSOscq70FfDLT.jpg',78,NULL,'2026-08-14 10:38:08','2026-08-14 10:38:08',NULL);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `user_id` bigint unsigned NOT NULL,
  `post_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `likes_post_id_foreign` (`post_id`),
  CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (511,67),(512,67),(512,68),(511,70),(17,71),(511,71),(17,72),(512,72),(511,73),(512,73),(17,74),(514,74),(17,75),(512,75),(512,76),(512,77),(17,78);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2026_08_06_015631_create_roles_table',1),(2,'2026_08_06_015901_create_users_table',1),(3,'2026_08_06_020351_create_tanks_table',1),(4,'2026_08_06_020420_create_categories_table',1),(5,'2026_08_06_020441_create_posts_table',1),(6,'2026_08_06_020551_create_comments_table',1),(7,'2026_08_06_020804_create_tags_table',1),(8,'2026_08_06_021150_create_post_tags_table',1),(9,'2026_08_06_021240_create_likes_table',1),(10,'2026_08_06_021335_create_images_table',1),(11,'2026_08_06_021644_create_reports_table',1),(12,'2026_08_09_190215_create_personal_access_tokens_table',1),(13,'2026_08_11_150342_add_slug_to_categories_table',1),(14,'2026_08_11_150343_add_slug_to_tags_table',1),(15,'2026_08_11_150344_add_temperature_and_ph_to_tanks_table',1),(16,'2026_08_12_005403_create_saved_posts_table',2),(17,'2026_08_11_183756_create_notifications_table',3),(18,'2026_08_12_010503_create_follows_table',4),(19,'2026_08_11_193708_add_status_and_force_email_change_to_users_table',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES ('130625af-ec17-45b2-b2bd-169468eb8b61','App\\Notifications\\PostLikedNotification','App\\Models\\User',512,'{\"message\":\"Mango liked your post \\\"Salt water tank setup\\\".\",\"post_id\":71,\"sender_id\":511,\"sender_name\":\"Mango\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/SIpptAWvvDewmOjHOfDIIcq51iC0nZRU534xIW93.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:18:53','2026-08-13 12:18:53'),('13fbc9cd-f298-41a1-83b4-234553b89e74','App\\Notifications\\CommentRepliedNotification','App\\Models\\User',514,'{\"message\":\"John Doe replied to your comment on \\\"Dutch Style Aquarium\\\".\",\"post_id\":74,\"sender_id\":513,\"sender_name\":\"John Doe\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/mAIpZw83Fj3VSZfYnUzHPNgKy4E05mG1GGRAUTP4.jpg\",\"type\":\"comment_replied\"}',NULL,'2026-08-13 12:59:44','2026-08-13 12:59:44'),('2c9fe64d-e255-4077-8588-eeb813a1d4e6','App\\Notifications\\PostLikedNotification','App\\Models\\User',512,'{\"message\":\"Linnea Abernathy liked your post \\\"Don\'t keep Betta!!!\\\".\",\"post_id\":78,\"sender_id\":17,\"sender_name\":\"Linnea Abernathy\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/FARr9MttLtbu7PSsd1rXLVhHor9B9jp5ISuYpETM.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:39:42','2026-08-14 10:39:42'),('2ea23ce7-d013-408b-b6c4-ec46b6749f9f','App\\Notifications\\PostLikedNotification','App\\Models\\User',514,'{\"message\":\"Linnea Abernathy liked your post \\\"Classic Style Tank Setup\\\".\",\"post_id\":75,\"sender_id\":17,\"sender_name\":\"Linnea Abernathy\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/FARr9MttLtbu7PSsd1rXLVhHor9B9jp5ISuYpETM.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:40:03','2026-08-14 10:40:03'),('38f10905-d20b-4afc-8be2-e577fcd9ebe1','App\\Notifications\\PostLikedNotification','App\\Models\\User',511,'{\"message\":\"Diana liked your post \\\"White spots on neon tetra, what should I do?\\\".\",\"post_id\":68,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 11:18:03','2026-08-13 11:18:03'),('3dfeb45f-1d12-4567-8dff-bab826c74507','App\\Notifications\\PostLikedNotification','App\\Models\\User',11,'{\"message\":\"Mango liked your post \\\"Torn fin betta\\\".\",\"post_id\":67,\"sender_id\":511,\"sender_name\":\"Mango\",\"sender_avatar\":null,\"type\":\"post_liked\"}',NULL,'2026-08-12 10:44:41','2026-08-12 10:44:41'),('477bea7f-f9bb-47ff-986d-9f891c9d515d','App\\Notifications\\PostLikedNotification','App\\Models\\User',17,'{\"message\":\"Diana liked your post \\\"Blue diamond shrimp\\\".\",\"post_id\":77,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:39:50','2026-08-14 10:39:50'),('5a735cdf-dbf5-4c04-8c8b-f8dc2e7d77c0','App\\Notifications\\PostLikedNotification','App\\Models\\User',512,'{\"message\":\"Linnea Abernathy liked your post \\\"Salt water tank setup\\\".\",\"post_id\":71,\"sender_id\":17,\"sender_name\":\"Linnea Abernathy\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/FARr9MttLtbu7PSsd1rXLVhHor9B9jp5ISuYpETM.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:40:16','2026-08-14 10:40:16'),('67347ae6-56e6-423b-8a15-2213e22a0cd0','App\\Notifications\\PostLikedNotification','App\\Models\\User',513,'{\"message\":\"Linnea Abernathy liked your post \\\"Dutch Style Aquarium\\\".\",\"post_id\":74,\"sender_id\":17,\"sender_name\":\"Linnea Abernathy\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/FARr9MttLtbu7PSsd1rXLVhHor9B9jp5ISuYpETM.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:58:45','2026-08-13 12:58:45'),('6f92c95f-2e54-40b8-9f69-d185694c5493','App\\Notifications\\CommentAddedNotification','App\\Models\\User',512,'{\"message\":\"Mango commented on your post \\\"Salt water tank setup\\\".\",\"post_id\":71,\"sender_id\":511,\"sender_name\":\"Mango\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/SIpptAWvvDewmOjHOfDIIcq51iC0nZRU534xIW93.jpg\",\"type\":\"comment_added\"}',NULL,'2026-08-13 12:19:10','2026-08-13 12:19:10'),('75ece4fe-5913-45b5-bb39-940360a31226','App\\Notifications\\CommentAddedNotification','App\\Models\\User',511,'{\"message\":\"Diana commented on your post \\\"White spots on neon tetra, what should I do?\\\".\",\"post_id\":68,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"comment_added\"}',NULL,'2026-08-13 11:18:30','2026-08-13 11:18:30'),('761ad595-9ab5-4cad-9893-a158fe9dfb19','App\\Notifications\\PostLikedNotification','App\\Models\\User',11,'{\"message\":\"Diana liked your post \\\"Gorgeous White Halfmoon Betta\\\".\",\"post_id\":73,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:29:25','2026-08-13 12:29:25'),('7649ef8a-0052-4447-b079-6a89501a685c','App\\Notifications\\PostLikedNotification','App\\Models\\User',11,'{\"message\":\"Mango liked your post \\\"Gorgeous White Halfmoon Betta\\\".\",\"post_id\":73,\"sender_id\":511,\"sender_name\":\"Mango\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/SIpptAWvvDewmOjHOfDIIcq51iC0nZRU534xIW93.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:29:36','2026-08-13 12:29:36'),('7db5342c-f321-4f2c-b619-fa777717f914','App\\Notifications\\PostLikedNotification','App\\Models\\User',513,'{\"message\":\"Jane Doe liked your post \\\"Dutch Style Aquarium\\\".\",\"post_id\":74,\"sender_id\":514,\"sender_name\":\"Jane Doe\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/H2dIBwTGLTkYP16g9uESKgJkzf4O4wSq8MiHwhJm.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:58:48','2026-08-13 12:58:48'),('83fae11e-3dea-48e8-b8a1-667629dfb5cf','App\\Notifications\\PostLikedNotification','App\\Models\\User',512,'{\"message\":\"Mango liked your post \\\"Iwagumi high tech tank\\\".\",\"post_id\":70,\"sender_id\":511,\"sender_name\":\"Mango\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/SIpptAWvvDewmOjHOfDIIcq51iC0nZRU534xIW93.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:13:44','2026-08-13 12:13:44'),('8e8d890d-2454-4c17-a540-95a654b9bcf3','App\\Notifications\\PostLikedNotification','App\\Models\\User',17,'{\"message\":\"Diana liked your post \\\"Shrimpies\\\".\",\"post_id\":76,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:39:52','2026-08-14 10:39:52'),('91831696-1e30-410f-a90e-0bb1fc3815d7','App\\Notifications\\CommentRepliedNotification','App\\Models\\User',512,'{\"message\":\"Mango replied to your comment on \\\"White spots on neon tetra, what should I do?\\\".\",\"post_id\":68,\"sender_id\":511,\"sender_name\":\"Mango\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/SIpptAWvvDewmOjHOfDIIcq51iC0nZRU534xIW93.jpg\",\"type\":\"comment_replied\"}',NULL,'2026-08-13 11:19:28','2026-08-13 11:19:28'),('bb7bb5be-fe1c-47e3-91ff-0ea0bae12414','App\\Notifications\\PostLikedNotification','App\\Models\\User',11,'{\"message\":\"Diana liked your post \\\"Torn fin betta\\\".\",\"post_id\":67,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:29:29','2026-08-13 12:29:29'),('cba857ff-8663-4fdf-a790-ee20844b2c7e','App\\Notifications\\PostLikedNotification','App\\Models\\User',511,'{\"message\":\"Linnea Abernathy liked your post \\\"Tall tank show case\\\".\",\"post_id\":72,\"sender_id\":17,\"sender_name\":\"Linnea Abernathy\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/FARr9MttLtbu7PSsd1rXLVhHor9B9jp5ISuYpETM.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:40:13','2026-08-14 10:40:13'),('e09d347b-c4c0-48aa-a122-7da3710953ac','App\\Notifications\\PostLikedNotification','App\\Models\\User',511,'{\"message\":\"Diana liked your post \\\"Tall tank show case\\\".\",\"post_id\":72,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-13 12:26:37','2026-08-13 12:26:37'),('e4cbfb18-231e-49da-a4b9-b68a9064fb69','App\\Notifications\\CommentAddedNotification','App\\Models\\User',513,'{\"message\":\"Jane Doe commented on your post \\\"Dutch Style Aquarium\\\".\",\"post_id\":74,\"sender_id\":514,\"sender_name\":\"Jane Doe\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/H2dIBwTGLTkYP16g9uESKgJkzf4O4wSq8MiHwhJm.jpg\",\"type\":\"comment_added\"}',NULL,'2026-08-13 12:59:18','2026-08-13 12:59:18'),('f630cf04-08eb-4c0d-9929-20b37da8671e','App\\Notifications\\PostLikedNotification','App\\Models\\User',514,'{\"message\":\"Diana liked your post \\\"Classic Style Tank Setup\\\".\",\"post_id\":75,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"post_liked\"}',NULL,'2026-08-14 10:39:54','2026-08-14 10:39:54'),('fa3427a0-ebeb-4f80-8c81-28d7dddcc3dd','App\\Notifications\\CommentRepliedNotification','App\\Models\\User',511,'{\"message\":\"Diana replied to your comment on \\\"Salt water tank setup\\\".\",\"post_id\":71,\"sender_id\":512,\"sender_name\":\"Diana\",\"sender_avatar\":\"http:\\/\\/localhost:8000\\/storage\\/avatars\\/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg\",\"type\":\"comment_replied\"}',NULL,'2026-08-13 12:19:32','2026-08-13 12:19:32');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (4,'App\\Models\\User',3,'api-token','92917f28bc5f642f37d0a5a9bb2abb00966f16afa9563f2f21744778345853ad','[\"*\"]','2026-08-12 07:22:32',NULL,'2026-08-11 12:53:48','2026-08-12 07:22:32'),(11,'App\\Models\\User',513,'api-token','1ab47dfe40c4c0508446f182f4ed467128d5c9b4fad925e952faf9a8f832ed43','[\"*\"]','2026-08-13 13:01:24',NULL,'2026-08-13 12:54:53','2026-08-13 13:01:24'),(12,'App\\Models\\User',514,'api-token','c09d2245ab849ae480829b8299893c101f8c1b3e4cd5b5d9b4b7890d3d301dfa','[\"*\"]','2026-08-14 09:59:56',NULL,'2026-08-13 12:55:16','2026-08-14 09:59:56'),(18,'App\\Models\\User',512,'api-token','ddb546c84192960f95a9f3d5842ead3d59a3974c20c0d73cb569318d7eeebd78','[\"*\"]','2026-08-14 10:39:54',NULL,'2026-08-14 10:30:01','2026-08-14 10:39:54'),(19,'App\\Models\\User',17,'api-token','aa5e7910d071ad0e5e8d44b60240416f91d0dc0bde5a253c3241030913d14ff3','[\"*\"]','2026-08-14 10:40:20',NULL,'2026-08-14 10:38:42','2026-08-14 10:40:20');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tags` (
  `post_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `post_tags_tag_id_foreign` (`tag_id`),
  CONSTRAINT `post_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `post_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tags`
--

LOCK TABLES `post_tags` WRITE;
/*!40000 ALTER TABLE `post_tags` DISABLE KEYS */;
INSERT INTO `post_tags` VALUES (67,12),(73,12),(78,12),(68,13),(68,14),(70,15),(70,16),(70,17),(71,18),(67,19),(72,20),(73,21),(73,22),(74,23),(75,24),(76,25),(77,25),(77,26),(78,27);
/*!40000 ALTER TABLE `post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `tank_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_user_id_foreign` (`user_id`),
  KEY `posts_category_id_foreign` (`category_id`),
  KEY `posts_tank_id_foreign` (`tank_id`),
  CONSTRAINT `posts_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `posts_tank_id_foreign` FOREIGN KEY (`tank_id`) REFERENCES `tanks` (`id`),
  CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (67,11,73,NULL,'Torn fin betta','My halfmoon betta is sick and has torn fins. How do i cure that?\r\n\r\nTo cure a torn or rotting fin on a halfmoon betta, perform 25% to 50% warm water changes (78–80°F) every day or every other day. Remove sharp tank decorations, add Indian almond leaves for natural antibacterial tannins, and use broad-spectrum antibiotics if the edges blacken or continue fraying.','published','2026-08-12 10:30:18','2026-08-13 12:24:17',NULL),(68,511,70,NULL,'White spots on neon tetra, what should I do?','White spots are spreading across neon tetras in my planted tank.','published','2026-08-13 11:17:46','2026-08-13 11:17:46',NULL),(69,511,68,NULL,'Iwagumi high tech tank','This is my Iwagumi style tank and i wanted to share it to the internet.','published','2026-08-13 11:33:07','2026-08-13 12:03:25','2026-08-13 12:03:25'),(70,512,68,NULL,'Iwagumi high tech tank','This is my Iwagumi style tank and i wanted to share it to the internet.','published','2026-08-13 11:34:24','2026-08-13 11:34:24',NULL),(71,512,69,NULL,'Salt water tank setup','My first and only saltwater tank setup.','published','2026-08-13 12:18:48','2026-08-13 12:18:48',NULL),(72,511,68,NULL,'Tall tank show case','Here is my tall tank. Isn\'t it beautiful? hehe','published','2026-08-13 12:26:29','2026-08-13 12:26:29',NULL),(73,11,68,NULL,'Gorgeous White Halfmoon Betta','My beloved white halfmoon betta.','published','2026-08-13 12:29:16','2026-08-13 12:29:16',NULL),(74,513,68,NULL,'Dutch Style Aquarium','Here is my dutch style aqyarium','published','2026-08-13 12:58:26','2026-08-13 12:58:26',NULL),(75,514,68,NULL,'Classic Style Tank Setup','My classic style counter top tank','published','2026-08-13 13:01:07','2026-08-13 13:01:07',NULL),(76,17,68,NULL,'Shrimpies','My shrimp are grazing.','published','2026-08-14 10:33:26','2026-08-14 10:33:26',NULL),(77,17,68,NULL,'Blue diamond shrimp','Rare blue diamond neo caridina shrimp.','published','2026-08-14 10:34:15','2026-08-14 10:34:15',NULL),(78,512,74,NULL,'Don\'t keep Betta!!!','I visited my friend\'s house and saw this betta bowl. I told them not to keep betta like this.','published','2026-08-14 10:38:08','2026-08-14 10:38:08',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','reviewed','dismissed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reportable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reportable_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_user_id_foreign` (`user_id`),
  KEY `reports_reportable_type_reportable_id_index` (`reportable_type`,`reportable_id`),
  CONSTRAINT `reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (2,511,'spam','dismissed','App\\Models\\Post',67,'2026-08-12 22:29:25','2026-08-12 22:29:31',NULL),(3,17,'Spam','dismissed','App\\Models\\Post',72,'2026-08-13 13:04:04','2026-08-13 13:04:19',NULL);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','2026-08-11 04:28:02','2026-08-11 04:28:02',NULL),(2,'Moderator','2026-08-11 04:28:02','2026-08-11 04:28:02',NULL),(3,'Member','2026-08-11 04:28:02','2026-08-11 04:28:02',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_posts`
--

DROP TABLE IF EXISTS `saved_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved_posts` (
  `user_id` bigint unsigned NOT NULL,
  `post_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `saved_posts_post_id_foreign` (`post_id`),
  CONSTRAINT `saved_posts_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `saved_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_posts`
--

LOCK TABLES `saved_posts` WRITE;
/*!40000 ALTER TABLE `saved_posts` DISABLE KEYS */;
INSERT INTO `saved_posts` VALUES (17,75,NULL,NULL),(511,70,NULL,NULL);
/*!40000 ALTER TABLE `saved_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_name_unique` (`name`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (12,'betta','betta','2026-08-12 10:30:18','2026-08-12 10:30:18',NULL),(13,'white_spot','white-spot','2026-08-13 11:17:46','2026-08-13 11:17:46',NULL),(14,'neon_tetra','neon-tetra','2026-08-13 11:17:46','2026-08-13 11:17:46',NULL),(15,'iwagumi','iwagumi','2026-08-13 11:33:07','2026-08-13 11:33:07',NULL),(16,'high_tech','high-tech','2026-08-13 11:33:07','2026-08-13 11:33:07',NULL),(17,'co2','co2','2026-08-13 11:33:07','2026-08-13 11:33:07',NULL),(18,'saltwater','saltwater','2026-08-13 12:18:48','2026-08-13 12:18:48',NULL),(19,'torn_fins','torn-fins','2026-08-13 12:24:17','2026-08-13 12:24:17',NULL),(20,'show_case','show-case','2026-08-13 12:26:29','2026-08-13 12:26:29',NULL),(21,'gorgeous','gorgeous','2026-08-13 12:29:16','2026-08-13 12:29:16',NULL),(22,'white','white','2026-08-13 12:29:16','2026-08-13 12:29:16',NULL),(23,'dutch','dutch','2026-08-13 12:58:26','2026-08-13 12:58:26',NULL),(24,'classic_tank','classic-tank','2026-08-13 13:01:07','2026-08-13 13:01:07',NULL),(25,'shrimp','shrimp','2026-08-14 10:33:26','2026-08-14 10:33:26',NULL),(26,'blue_diamond','blue-diamond','2026-08-14 10:34:15','2026-08-14 10:34:15',NULL),(27,'fish_abuse','fish-abuse','2026-08-14 10:38:08','2026-08-14 10:38:08',NULL);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tanks`
--

DROP TABLE IF EXISTS `tanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tanks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume_gallons` decimal(10,2) NOT NULL,
  `water_type` enum('freshwater','saltwater','brackish') COLLATE utf8mb4_unicode_ci NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL,
  `ph_level` decimal(3,2) DEFAULT NULL,
  `aquascape_style` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setup_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tanks_user_id_foreign` (`user_id`),
  CONSTRAINT `tanks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=583 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tanks`
--

LOCK TABLES `tanks` WRITE;
/*!40000 ALTER TABLE `tanks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tanks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `force_email_change` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` text COLLATE utf8mb4_unicode_ci,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=515 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,1,'active',0,'Dawson Paucek','reinhold.wisozk@example.org',NULL,'$2y$12$nI0rhiN9xJ.zJxWApQOmTeQlaG.o6wGS6/0L8XsypbVwDvkGjQ872','463.371.6864','avatars/TsQzNNUhTzTuA98wKHlIBiOUAKw1FSxF4rjZnrqd.jpg','Sit dolorem fugit ab nisi quia.',NULL,'2026-08-11 03:28:07','2026-08-13 10:55:15',NULL),(12,3,'active',0,'Xzavier Ullrich','pgoldner@example.com',NULL,'$2y$12$rWyPqwrDsev.CgeInHcd9OhM8WKwp1b.Rq3PJGB4HcLgtmMbBxuDa','(803) 474-8297','https://via.placeholder.com/200x200.png/00dd88?text=people+non','Eum occaecati nostrum et similique vitae quis.',NULL,'2026-08-11 03:28:07','2026-08-12 10:49:40','2026-08-12 10:49:40'),(13,1,'active',0,'Wallace Murray','anna.dickens@example.org',NULL,'$2y$12$UrCbF0A.YfNutrTZOGR46uuT47EzLg59mKZf05SsujFxkdWhX/btu','+15859044795','https://via.placeholder.com/200x200.png/00ccaa?text=people+tempora','Esse exercitationem quisquam illo est qui similique iusto ex dolor.',NULL,'2026-08-11 03:28:07','2026-08-11 03:28:07',NULL),(14,1,'active',0,'Quincy Lind Jr.','lweber@example.org',NULL,'$2y$12$RTN.oEdgWsuQgrrHG1/5Oun8Sfs0SBpphVshJEriv2hku0qc/PwaW','(346) 968-9988','https://via.placeholder.com/200x200.png/0099dd?text=people+neque','Qui sit deserunt sit possimus ea atque eius accusamus.',NULL,'2026-08-11 03:28:07','2026-08-11 03:28:07',NULL),(15,1,'active',0,'Lorna Morar','bonita.raynor@example.net',NULL,'$2y$12$7Td.edqV.7rdXiKCb14qQ.3Jw8VNqyQnR12O/CAkPqtK2UZnbMhkq','+1-308-510-5425','https://via.placeholder.com/200x200.png/0077ee?text=people+quo','Et voluptatum ratione nostrum eum excepturi accusamus laborum exercitationem.',NULL,'2026-08-11 03:28:07','2026-08-11 03:28:07',NULL),(16,2,'active',0,'Adrienne Hamill','ora.leannon@example.net',NULL,'$2y$12$0S8YBROzybhVdgSgWaB4DuYUiAQHjByr948EPTR4FREbIdj42HdA.','(718) 679-1942','https://via.placeholder.com/200x200.png/00bb44?text=people+nulla','Id corporis aut labore voluptas aspernatur et est voluptatum.',NULL,'2026-08-11 03:28:07','2026-08-11 03:28:07',NULL),(17,2,'active',0,'Linnea Abernathy','mckenzie.amy@example.com',NULL,'$2y$12$Pi4/msmkiKkXkHxs5zABhejYZNo9frypM8rg0mCZ5esxTCGamHdOW','0912345678','avatars/FARr9MttLtbu7PSsd1rXLVhHor9B9jp5ISuYpETM.jpg','Accusamus repellat est ullam voluptates vel rerum harum non aliquam.',NULL,'2026-08-11 03:28:08','2026-08-14 10:24:33',NULL),(18,1,'active',0,'Caesar Beer','mtorphy@example.com',NULL,'$2y$12$BIcxqdX0H7YcdQe07MnyCe.AFhW0Ryy5YDWE/ajs.qBfvk6GSOIMC','315-330-5180','https://via.placeholder.com/200x200.png/0055aa?text=people+sint','Ut quod neque voluptatem odio accusantium quidem.',NULL,'2026-08-11 03:28:08','2026-08-11 03:28:08',NULL),(19,2,'active',0,'Elmo Kling','willms.stephanie@example.org',NULL,'$2y$12$Xi3N2Db/F0nq7naKTclucOIaZnL7l3NPhUoblpOJpo48CAc0JBheu','(360) 743-0222','https://via.placeholder.com/200x200.png/00ee44?text=people+fugit','Architecto nesciunt a odit quo voluptas soluta.',NULL,'2026-08-11 03:28:08','2026-08-11 03:28:08',NULL),(20,2,'active',0,'Bennie Fahey','mraynor@example.org',NULL,'$2y$12$Wu2ZmMfrcVzCKFxtxzjkL.vFHnBMswbz5fc07dbqfYRS3ZFW/EoVu','1-463-988-4721','https://via.placeholder.com/200x200.png/0022aa?text=people+iste','Amet nihil suscipit dolor id corporis officiis eligendi necessitatibus velit.',NULL,'2026-08-11 03:28:08','2026-08-11 03:28:08',NULL),(21,1,'active',0,'Jadyn Mayert','gaetano.hermiston@example.net',NULL,'$2y$12$lxwAS9ktBZ8eXIWWa9xFPOcHKEgRqi3V3zkaaqDXEs8RwZ2PCHMD6','+1.512.921.7823','https://via.placeholder.com/200x200.png/006644?text=people+quaerat','Doloremque aperiam commodi soluta pariatur harum sequi.',NULL,'2026-08-11 03:28:08','2026-08-11 03:28:08',NULL),(22,2,'active',0,'Amaya Schuster','macejkovic.sheila@example.net',NULL,'$2y$12$HqSt4ZVv7CZLoBv0RoA/PeCbrXRfYsuEDytX2vgguUzOmgXoFVTyW','1-520-968-8617','https://via.placeholder.com/200x200.png/006611?text=people+harum','Ipsam doloremque quia pariatur adipisci quisquam praesentium.',NULL,'2026-08-11 03:28:08','2026-08-11 03:28:08',NULL),(23,2,'active',0,'Maureen Wuckert','denesik.max@example.org',NULL,'$2y$12$tdl..uIhbHr7ZvqlT/BhJ.r6Y8926d5moRiGi4xmV.ljVxn4tYBVu','270.871.5561','https://via.placeholder.com/200x200.png/0044ff?text=people+facilis','Et dolorem repellat quam accusamus fuga quis.',NULL,'2026-08-11 03:28:09','2026-08-11 03:28:09',NULL),(24,1,'active',0,'Adrianna Erdman','gilda.smith@example.com',NULL,'$2y$12$h2Bp/e.aqjwu26AMpIBOBepGsbAChhxpzi2JJuTlYOI9p2Mh/Uva2','480.299.8833','https://via.placeholder.com/200x200.png/00aaaa?text=people+blanditiis','Quo alias est repellendus distinctio consequatur non quia.',NULL,'2026-08-11 03:28:09','2026-08-11 03:28:09',NULL),(26,2,'active',0,'Elta Homenick','tkertzmann@example.com',NULL,'$2y$12$kWK2LOSPd0h5D.rn0wyEr.fryDCAEaR.qLsEE7FI2eJsexuhVpz6G','+12172050996','https://via.placeholder.com/200x200.png/00cc11?text=people+autem','Ut aut dolores esse recusandae placeat praesentium qui qui tempora quaerat.',NULL,'2026-08-11 03:28:09','2026-08-11 03:28:09',NULL),(27,2,'active',0,'Ayla Kerluke','jennings.blanda@example.com',NULL,'$2y$12$adw6d3xLjAfJHCD9p3I2u.w4cIjhZeSJX07YBElcEMr1NSC4WlbXW','470-320-3653','https://via.placeholder.com/200x200.png/005566?text=people+minus','Rerum dolor voluptatem est blanditiis velit earum rerum enim consequatur qui.',NULL,'2026-08-11 03:28:09','2026-08-11 03:28:09',NULL),(29,1,'active',0,'Miss Beulah Connelly Sr.','vkuhic@example.net',NULL,'$2y$12$xDrLOQaci9qiA2gmvPsS8.mkriuuFncgEH0xlIdCIaeGArGSiBG36','+1 (628) 871-9856','https://via.placeholder.com/200x200.png/000077?text=people+quo','Modi illo animi iusto et repellat quis explicabo incidunt.',NULL,'2026-08-11 03:28:10','2026-08-11 03:28:10',NULL),(30,1,'active',0,'Missouri O\'Conner','cleve34@example.com',NULL,'$2y$12$.wo/CUDdKk5e/Z5hVtYe8.QSQYLtyrCYzAXJiZfbJcVLX519rLIGK','463-340-2326','https://via.placeholder.com/200x200.png/009900?text=people+quia','Ut id eius optio qui.',NULL,'2026-08-11 03:28:10','2026-08-11 03:28:10',NULL),(31,1,'active',0,'Felipe Pacocha','payton.hand@example.org',NULL,'$2y$12$0fz9ojmzTpLIKGM3/W.oUuYNitN4CKCIuBDF5TkXDUMtvw52C9PO6','(315) 313-8801','https://via.placeholder.com/200x200.png/00ccff?text=people+sapiente','Eius et qui aut quos rem in.',NULL,'2026-08-11 03:28:10','2026-08-11 03:28:10',NULL),(33,1,'active',0,'Bianka Frami','addison.balistreri@example.com',NULL,'$2y$12$Mh/bOk5x5/kaamuqKRREUeiD9u9oQA8Eip7DL3JWCA7Eqi8jc/0uG','786-894-8148','https://via.placeholder.com/200x200.png/002255?text=people+eos','Impedit sunt autem ea aliquid soluta et.',NULL,'2026-08-11 03:28:10','2026-08-11 03:28:10',NULL),(34,2,'active',0,'Dell Klein','antonietta.pfannerstill@example.net',NULL,'$2y$12$pl/C/i/zKnah0Zgmswre9utp/qroyPXtNjAUiqawdipbbtGp2QyAm','+15052779788','https://via.placeholder.com/200x200.png/00bb77?text=people+molestiae','Voluptas sint neque porro dolor fuga.',NULL,'2026-08-11 03:28:11','2026-08-11 03:28:11',NULL),(35,2,'active',0,'Bailey Ritchie','jillian97@example.org',NULL,'$2y$12$v1AhpM3DIEYCw0MSq2pprOWaSMUrojRuXK9nQTcM7K37/gV8oPEdy','+1-660-282-7964','https://via.placeholder.com/200x200.png/0011aa?text=people+nulla','Eum sit cum aut at id et minima quaerat.',NULL,'2026-08-11 03:28:11','2026-08-11 03:28:11',NULL),(40,2,'active',0,'Ms. Layla D\'Amore IV','koch.freida@example.com',NULL,'$2y$12$HrNlpGDSv3Xdnabk8mNRxue3qrKyhuWKyPzQM9Ugiz65.X5SmdH5m','(269) 427-7844','https://via.placeholder.com/200x200.png/0000ff?text=people+sit','Sapiente pariatur sit aperiam et sit ex ex quos sed ut.',NULL,'2026-08-11 03:28:12','2026-08-11 03:28:12',NULL),(41,2,'active',0,'Elsa Casper','genesis.boehm@example.org',NULL,'$2y$12$fwuzwcqRH/3b2fU6CH1dOeMKiehtP2nV9W1F9Jv.wmouwO3oqua7a','479-364-0840','https://via.placeholder.com/200x200.png/007777?text=people+ut','Dolorem quibusdam aut consectetur dolore et qui qui.',NULL,'2026-08-11 03:28:12','2026-08-11 03:28:12',NULL),(42,2,'active',0,'Emmy Metz','berge.alfredo@example.com',NULL,'$2y$12$edoj/l.BV7KMAQ.9w8GOzOVkae3jO6ruk2KcDS4/P3v0N6htPhIqi','1-678-440-8773','https://via.placeholder.com/200x200.png/00ddcc?text=people+error','Ea quibusdam non cumque nesciunt maiores et qui molestias recusandae.',NULL,'2026-08-11 03:28:12','2026-08-11 03:28:12',NULL),(43,2,'active',0,'Prof. Nayeli Veum PhD','welch.myrl@example.net',NULL,'$2y$12$DX3u6uHA/Z75O3O9vE3hOeZxpZqF1CKh2n3E/sK6qMgeFdcnQkojG','+1-331-253-2791','https://via.placeholder.com/200x200.png/0000bb?text=people+ipsam','Quod nostrum aspernatur illo debitis vitae.',NULL,'2026-08-11 03:28:12','2026-08-11 03:28:12',NULL),(44,1,'active',0,'Dr. Heath Fay Jr.','klocko.robb@example.org',NULL,'$2y$12$9W82Q3Jg.2MK33bgZVHzWu.kweMJ4phrsp9Kmrf.7fqBGHSeSlrFK','+1-863-682-3882','https://via.placeholder.com/200x200.png/0077ff?text=people+voluptate','Atque ullam provident molestias sunt minima exercitationem nostrum ipsa.',NULL,'2026-08-11 03:28:12','2026-08-11 03:28:12',NULL),(45,1,'active',0,'Joesph Sipes','fay.kaycee@example.com',NULL,'$2y$12$otvMQ4eVf40vDdWAba9SGulXg9yekqsiO8oOiBknB.Wd1IUSspDW.','+17603403839','https://via.placeholder.com/200x200.png/00ddbb?text=people+fugit','Perspiciatis ut laborum nihil illo dolorem.',NULL,'2026-08-11 03:28:12','2026-08-11 03:28:12',NULL),(46,1,'active',0,'Nona Nikolaus','fnicolas@example.net',NULL,'$2y$12$bD2wiNfznq28tckbD20hhua5RibTZz0dyHYe36zkorQTOm.Z.P5Eq','1-302-683-1694','https://via.placeholder.com/200x200.png/0044dd?text=people+expedita','Expedita rerum quod non inventore et ipsam et officia eius labore at.',NULL,'2026-08-11 03:28:13','2026-08-11 03:28:13',NULL),(48,2,'active',0,'Ressie Tromp','frederick.nader@example.org',NULL,'$2y$12$nuyw74lKmk69WPVlUu.yQOUJJbcEcyciauXhzFzixsM1mIFIbtKIK','(870) 912-0778','https://via.placeholder.com/200x200.png/00aa88?text=people+est','Nihil nemo repellendus et sequi quidem ut magni cumque quidem.',NULL,'2026-08-11 03:28:13','2026-08-11 03:28:13',NULL),(50,1,'active',0,'Horace Abbott','valerie95@example.org',NULL,'$2y$12$6up4NEtkkMbvt0FNqLgLYe73r5pxsVBn5AE6sII5VZH8ZsaTXdmuy','(904) 738-1961','https://via.placeholder.com/200x200.png/0099cc?text=people+aliquam','Architecto rem nulla libero et voluptatem deserunt dolor perspiciatis.',NULL,'2026-08-11 03:28:13','2026-08-11 03:28:13',NULL),(51,2,'active',0,'Bennett Pagac','lorenza.moore@example.com',NULL,'$2y$12$TXit6x9FxYFEQi2Q9SpSk.Jj0rjt0f2B5ieMb0FO5ChGz1HiQgT66','734.667.0449','https://via.placeholder.com/200x200.png/00bb44?text=people+voluptas','Nobis assumenda consequuntur doloribus laudantium aut.',NULL,'2026-08-11 03:28:13','2026-08-11 03:28:13',NULL),(55,2,'active',0,'Hilma Mitchell','blick.aracely@example.net',NULL,'$2y$12$dSRlkfERudkrOHgDBJ/FbOIuO6QhfCGwho9v0e9wXjkJQnXsAVOj2','+13306105395','https://via.placeholder.com/200x200.png/003399?text=people+enim','Omnis qui earum reprehenderit tempora possimus nisi ut.',NULL,'2026-08-11 03:28:14','2026-08-11 03:28:14',NULL),(56,2,'active',0,'Roosevelt Stracke','alfred31@example.com',NULL,'$2y$12$nTFXFLHnIKjrvty6LMjduezAWr81CDi/.7sROM/usPkLwn/yOv0Nq','1-832-848-1111','https://via.placeholder.com/200x200.png/000000?text=people+eligendi','Quia vero ducimus officia ut neque nobis nostrum pariatur illo.',NULL,'2026-08-11 03:28:14','2026-08-11 03:28:14',NULL),(58,1,'active',0,'Ellie Brakus','rigoberto.ohara@example.com',NULL,'$2y$12$YcslYIjIoJk.suSc2hzpAOySOBrMkdQ0XmB0TPKysJu9WZguc8fZa','(308) 403-2401','https://via.placeholder.com/200x200.png/00ccaa?text=people+voluptatum','Placeat ea expedita fugit est quos pariatur aut voluptate at aut.',NULL,'2026-08-11 03:28:15','2026-08-11 03:28:15',NULL),(59,2,'active',0,'Enrico Simonis','gottlieb.dedric@example.net',NULL,'$2y$12$VrzIwQjYN1RN4HqsrdbW6eSgD7y5ucuwNuNelkk0EdhuD3pdbosvW','+1-832-571-9452','https://via.placeholder.com/200x200.png/004499?text=people+dolorem','Alias doloremque ullam sequi sunt saepe quis quas rerum natus.',NULL,'2026-08-11 03:28:15','2026-08-11 03:28:15',NULL),(60,2,'active',0,'Frida Rath','johnston.leatha@example.com',NULL,'$2y$12$xpG7C.rPmOk.20gkP8quUeMaR1mT5nVnnRG7SJ5g/ckmBKXDh0zeK','445.358.2245','https://via.placeholder.com/200x200.png/0099ee?text=people+exercitationem','Sit voluptatem ea id repellat sunt aut voluptatem expedita.',NULL,'2026-08-11 03:28:15','2026-08-11 03:28:15',NULL),(61,1,'active',0,'Devante Terry','russel.swaniawski@example.org',NULL,'$2y$12$qf8Cnbht3RcpLEjNLb0MXeB2KrmChdF1FN8n3OcfhY.WidIO1O0tK','+1-920-851-5576','https://via.placeholder.com/200x200.png/0011cc?text=people+nesciunt','Iste et blanditiis quia non qui.',NULL,'2026-08-11 03:28:15','2026-08-11 03:28:15',NULL),(63,1,'active',0,'Asia O\'Conner','bins.aryanna@example.net',NULL,'$2y$12$g1EnuE6SDCO0rpnDbhHYMuoQ1923oyp0Y5FVpl7T82kvj5VFr6WtK','+1 (341) 691-5616','https://via.placeholder.com/200x200.png/0066ff?text=people+iure','Illo deleniti deserunt fugiat quia sequi placeat dolorem consectetur et et.',NULL,'2026-08-11 03:28:16','2026-08-11 03:28:16',NULL),(66,2,'active',0,'Kali Auer','edwina.rippin@example.net',NULL,'$2y$12$OlXWKGqmrrJtxLMmDd97DeYXqoQYnuar.COMlLGYu7i0ksiC39RXm','+1 (681) 334-3585','https://via.placeholder.com/200x200.png/00aa66?text=people+quisquam','Voluptatum dolore nostrum nihil eveniet consequatur quo.',NULL,'2026-08-11 03:28:16','2026-08-11 03:28:16',NULL),(67,2,'active',0,'Prof. Tatyana Aufderhar I','rutherford.ashton@example.com',NULL,'$2y$12$Lb36yMvUU1kQgyv.ECS7aumN4EHo5u1EjXB3twappWKe8bFgcuw/C','512.294.7072','https://via.placeholder.com/200x200.png/00ee88?text=people+eos','Cum enim id itaque in rem modi occaecati ut.',NULL,'2026-08-11 03:28:16','2026-08-11 03:28:16',NULL),(68,2,'active',0,'Prof. Brice Grady PhD','anais.buckridge@example.net',NULL,'$2y$12$3WDLZxeKZYEWzVBrqPme8eu0Wgda43jO48qHfgjE/MxJ3tPWl8eLu','+1.281.251.2945','https://via.placeholder.com/200x200.png/0055bb?text=people+aut','Eligendi fuga nam impedit pariatur et dolores quis voluptas aliquid ipsum.',NULL,'2026-08-11 03:28:16','2026-08-11 03:28:16',NULL),(70,1,'active',0,'Caesar Buckridge','ellie.rowe@example.com',NULL,'$2y$12$bZepIT9clV06mKwBsxdoDe8qHYWuSGH6H5MVX5MHbl0lLvrhI4o/G','1-607-902-7135','https://via.placeholder.com/200x200.png/008833?text=people+dignissimos','Est consequuntur pariatur magni sint provident distinctio non accusamus sapiente impedit.',NULL,'2026-08-11 03:28:17','2026-08-11 03:28:17',NULL),(71,1,'active',0,'Sallie Kuhn PhD','bartell.jamarcus@example.com',NULL,'$2y$12$4xuinuAr67NVC0gcjdbEeO.IO0DoH5G6wWEmUvnJOzi5rFCDPmRCG','1-218-993-3766','https://via.placeholder.com/200x200.png/00dd33?text=people+sint','Laboriosam eos dignissimos praesentium similique iusto consequatur est magnam a ipsum.',NULL,'2026-08-11 03:28:17','2026-08-11 03:28:17',NULL),(73,1,'active',0,'Dr. Harmony Padberg','yokeefe@example.net',NULL,'$2y$12$Y14AYQM78jJAj/2XMqndSeghAbHKFD8/js2ipOvToro7tv0TU8yy6','+1-619-652-4723','https://via.placeholder.com/200x200.png/009966?text=people+quia','Error dolores iusto eveniet nemo ratione commodi est omnis laborum vero.',NULL,'2026-08-11 03:28:17','2026-08-11 03:28:17',NULL),(75,1,'active',0,'Prof. Jettie Kuhic DDS','diamond91@example.org',NULL,'$2y$12$IDSuH7gf6i1l8Dozj7p5uOD4olawOAYJvuJPkJNfsMuEh3WA81Jza','(646) 854-7445','https://via.placeholder.com/200x200.png/000044?text=people+voluptas','Laborum aut ut quia est quo sequi at fugit repudiandae.',NULL,'2026-08-11 03:28:18','2026-08-11 03:28:18',NULL),(77,2,'active',0,'Federico Hodkiewicz','bnolan@example.org',NULL,'$2y$12$NnkKUiOkSlfr0fLhBOVatOwiNTEE7/k305Fpv8Ugx7DZYyeABElyq','+1.717.485.6698','https://via.placeholder.com/200x200.png/004400?text=people+atque','Illo error voluptates omnis ducimus.',NULL,'2026-08-11 03:28:18','2026-08-11 03:28:18',NULL),(78,1,'active',0,'Mr. Jovanny West MD','ferry.haylie@example.com',NULL,'$2y$12$kfNhPC6gU19A8cUkIwopHu.fJhJqNot6HuD.WlmwdNwOOw4wNsEl2','531-363-4435','https://via.placeholder.com/200x200.png/00bb11?text=people+unde','Unde quaerat quibusdam praesentium molestias repudiandae et ex maiores.',NULL,'2026-08-11 03:28:18','2026-08-11 03:28:18',NULL),(79,1,'active',0,'Prof. Francesco Raynor I','francesca.schmitt@example.net',NULL,'$2y$12$wiOpEkbPLGZV2BF2VedIke8Rakv5SKvl1fnq.QueEfPBjNDmWJ2H2','351.378.6822','https://via.placeholder.com/200x200.png/0044ee?text=people+asperiores','Cumque cum omnis fugit ipsum non rerum a enim voluptate aut.',NULL,'2026-08-11 03:28:18','2026-08-11 03:28:18',NULL),(80,2,'active',0,'Jaleel Satterfield','lockman.domenick@example.com',NULL,'$2y$12$0060f6bEq4Zc8y16EzYc6O4/cR3kRI3LPVOytf5f2ilOsMJpKaLwS','+1-347-582-2578','https://via.placeholder.com/200x200.png/00bb44?text=people+qui','Quibusdam nesciunt voluptatem repellat consequuntur.',NULL,'2026-08-11 03:28:18','2026-08-11 03:28:18',NULL),(81,1,'active',0,'Mrs. Zelma Pouros','franecki.madyson@example.net',NULL,'$2y$12$9jxFvc4pAs2PvVuwGFt.3.IPRynFiDW4bDlhaaIDW7AN0buarF3P2','838-606-8256','https://via.placeholder.com/200x200.png/00bb77?text=people+ex','Vel et ut vel quod veritatis ut.',NULL,'2026-08-11 03:28:19','2026-08-11 03:28:19',NULL),(83,1,'active',0,'Sophie Marks','eulah.connelly@example.com',NULL,'$2y$12$q0RfZ/mxv/AgAl0QPfvDEuC4vhOjiRxaYZLby14PtRiGPvORNwpNK','989-799-0167','https://via.placeholder.com/200x200.png/002211?text=people+et','Iure aperiam qui libero repudiandae assumenda ut voluptas voluptas est.',NULL,'2026-08-11 03:28:19','2026-08-11 03:28:19',NULL),(86,1,'active',0,'Dr. Berta Leuschke','ohara.marjory@example.org',NULL,'$2y$12$xgIRr1i6W5yz5A8jgZWZFu1bqo.af.pQLlp4yyEtWih0bV7yQTpdm','336.975.2332','https://via.placeholder.com/200x200.png/00eeaa?text=people+officia','Veniam voluptas aut officiis reprehenderit quo.',NULL,'2026-08-11 03:28:19','2026-08-11 03:28:19',NULL),(89,2,'active',0,'Art Kuhic','hwindler@example.org',NULL,'$2y$12$yUGnqnrMxdR0DicM69prKuwxd35O4o1ZjXnA5FcrWgI3bMkX1rLQ.','+12677255630','https://via.placeholder.com/200x200.png/00eebb?text=people+placeat','Minima et harum quam voluptas nostrum a neque consequatur.',NULL,'2026-08-11 03:28:20','2026-08-11 03:28:20',NULL),(90,1,'active',0,'Rey Toy','sheldon.lindgren@example.net',NULL,'$2y$12$rCi3E54KqSsMzzKOx5SHZe8QJRTq2iYvlNHM4uaw/.7dXAhI9dFHi','(551) 273-3443','https://via.placeholder.com/200x200.png/0033cc?text=people+sed','Enim ab distinctio iusto expedita earum ut nihil quia.',NULL,'2026-08-11 03:28:20','2026-08-11 03:28:20',NULL),(91,1,'active',0,'Julio Mohr','losinski@example.com',NULL,'$2y$12$BWGdkl/qiqmdVzjleeAiQeFFvGedYFwCeEjgeYtjn9n7RWo/.NHti','443.555.5755','https://via.placeholder.com/200x200.png/000000?text=people+ipsum','Minus similique consequuntur repudiandae sint cumque voluptate doloremque suscipit repellendus.',NULL,'2026-08-11 03:28:20','2026-08-11 03:28:20',NULL),(92,1,'active',0,'Ronny Erdman','goyette.dean@example.com',NULL,'$2y$12$QrNpnuq/lf4C9tXhsxNxJeqfpnJoMNMm7DAi.LSBWYz4icCIiFnYe','918-903-4450','https://via.placeholder.com/200x200.png/005533?text=people+excepturi','Officia aut alias vel cupiditate dicta ut et expedita neque sed.',NULL,'2026-08-11 03:28:21','2026-08-11 03:28:21',NULL),(93,2,'active',0,'Conner Jacobson','nikolaus.nakia@example.com',NULL,'$2y$12$nvzzni4INW1WAA9eei/j0.UF80/IlEC7v8wMaMSUabyUNVN2ehFBq','+1 (847) 416-7278','https://via.placeholder.com/200x200.png/0022ff?text=people+quia','Ipsum qui ut adipisci odit consequatur eos dignissimos.',NULL,'2026-08-11 03:28:21','2026-08-11 03:28:21',NULL),(97,2,'active',0,'Prof. Dean Wolff','xschmidt@example.net',NULL,'$2y$12$YJ2V8jQ0rza62271IFxzietx7DzkMld2DcjbFhelMetCtK9ZJw2pW','+1-661-577-3617','https://via.placeholder.com/200x200.png/00aa11?text=people+accusamus','Harum rerum recusandae eaque suscipit eum et alias voluptatum.',NULL,'2026-08-11 03:28:21','2026-08-11 03:28:21',NULL),(98,2,'active',0,'Murl Treutel','stephon.shanahan@example.com',NULL,'$2y$12$E3wL88iRk5PksVFOiowTcu7vqaIQAd71gK0NIWm4zoROU7rtyKAT6','341.480.5431','https://via.placeholder.com/200x200.png/004488?text=people+enim','Velit voluptatem qui sed suscipit nemo.',NULL,'2026-08-11 03:28:22','2026-08-11 03:28:22',NULL),(99,2,'active',0,'Sandra Oberbrunner','klein.mary@example.com',NULL,'$2y$12$jYzhZk93Z49F2IG9SE1x2.xIWqE362ZntM2A4QfU.SWws0oKTg2hC','(414) 896-1261','https://via.placeholder.com/200x200.png/005599?text=people+ut','Eos optio dolorum animi quia nemo deserunt praesentium non minus explicabo.',NULL,'2026-08-11 03:28:22','2026-08-11 03:28:22',NULL),(105,2,'active',0,'Ricky Eichmann','johnny52@example.org',NULL,'$2y$12$QrX7madqShKJVHHvpOGGCO6kX3YI3NHBnqokFCC4AP8UEuw7.f7A.','(212) 234-7457','https://via.placeholder.com/200x200.png/003399?text=people+maiores','Minus quia dolorem in molestias fugiat et omnis at.',NULL,'2026-08-11 03:28:23','2026-08-11 03:28:23',NULL),(107,2,'active',0,'Jolie Kozey','jedidiah73@example.com',NULL,'$2y$12$H8zPh7KJgFGclQUTzj572uLvUS7BoeKA4WhkVuerPccnDaklSPSWW','+1 (938) 705-4623','https://via.placeholder.com/200x200.png/001133?text=people+possimus','Est et ut facere et asperiores sed libero et eius cumque quidem.',NULL,'2026-08-11 03:28:23','2026-08-11 03:28:23',NULL),(108,2,'active',0,'Dana Williamson','igerhold@example.org',NULL,'$2y$12$SzhaZ/Ijw3DtD8RPCeQ.6eIxBeepp6Lr6ES8tjRdWXYhQjSVvDASi','+1.872.208.2069','https://via.placeholder.com/200x200.png/00bb88?text=people+repellendus','Quia quidem aperiam commodi saepe aperiam eaque ab.',NULL,'2026-08-11 03:28:23','2026-08-11 03:28:23',NULL),(110,2,'active',0,'Elisabeth Lueilwitz','marilyne.kuhlman@example.net',NULL,'$2y$12$G1BlpnCWeb9Zb1AmK5JUZ.rdQV21txvMs6.ieWyIkpE73aulvKbey','(762) 820-8869','https://via.placeholder.com/200x200.png/0000dd?text=people+ducimus','Porro facere voluptatem libero tenetur in.',NULL,'2026-08-11 03:28:24','2026-08-11 03:28:24',NULL),(112,1,'active',0,'Dr. Clyde Bechtelar DDS','mayra39@example.com',NULL,'$2y$12$Laj9Y0Y1WFZ0HvfI6P1Tn.4yxwiSNUkc4PRDoXPrNMaJFN5nZpnoC','+12024861815','https://via.placeholder.com/200x200.png/0055ee?text=people+assumenda','Dicta esse fugit rem aut ipsam.',NULL,'2026-08-11 03:28:24','2026-08-11 03:28:24',NULL),(113,2,'active',0,'Dr. Roslyn Stroman DDS','arlene.olson@example.com',NULL,'$2y$12$nkOPKQ7lashkm6lyZ3dfEOTNrrcEUZH0LbEmOhqqit8eprL1gmnSa','(561) 851-6078','https://via.placeholder.com/200x200.png/0000cc?text=people+voluptates','Molestias ratione amet iure neque eum et iusto recusandae nemo est.',NULL,'2026-08-11 03:28:24','2026-08-11 03:28:24',NULL),(115,2,'active',0,'Ms. Orie Lemke','dominic.weissnat@example.com',NULL,'$2y$12$M1.nv7lCW5JiG.u7Aq9dEugrqoVb5bTP5qwSz8FSddH3uRs4AdVCu','772-501-0269','https://via.placeholder.com/200x200.png/0066ff?text=people+omnis','Iste necessitatibus dolorem maxime sunt similique voluptates laborum velit in.',NULL,'2026-08-11 03:28:24','2026-08-11 03:28:24',NULL),(116,2,'active',0,'Krista Mohr','wgrant@example.org',NULL,'$2y$12$PfqGdRi7bN4aWsKWOqR4Wu9B83t/aygkbdkCwsiYgW368CXqYpkFy','908-685-9848','https://via.placeholder.com/200x200.png/000033?text=people+quia','Ipsa exercitationem incidunt sit voluptatem veniam quo porro inventore.',NULL,'2026-08-11 03:28:25','2026-08-11 03:28:25',NULL),(117,1,'active',0,'Mr. Odell Keebler III','conrad.koch@example.net',NULL,'$2y$12$H1rAt8FSuZxDDGBUax9HNOA0.ukmnZqiXzeBt/td072OwwaFI55Vi','843-817-4226','https://via.placeholder.com/200x200.png/0077dd?text=people+natus','Consequatur nam ratione earum animi aut in quibusdam et aut aut sint.',NULL,'2026-08-11 03:28:25','2026-08-11 03:28:25',NULL),(118,2,'active',0,'Ari Weimann','jamil.mcdermott@example.net',NULL,'$2y$12$rtlFKpnk4gE1nINP9VF7OuZZS99mTH0r/4blqHAARAFCBsPcpxH2S','+13465866613','https://via.placeholder.com/200x200.png/002200?text=people+qui','Natus et natus illum non maiores omnis.',NULL,'2026-08-11 03:28:25','2026-08-11 03:28:25',NULL),(119,1,'active',0,'Prof. Billy Goldner','shanelle38@example.com',NULL,'$2y$12$3SjbkylRRkmpI6qrVKzg7.8diXMaEhD4yzYnEzcMY0RvgM3yP9SCu','+1-708-603-9721','https://via.placeholder.com/200x200.png/008844?text=people+quis','Quod omnis ducimus atque distinctio fuga quod.',NULL,'2026-08-11 03:28:25','2026-08-11 03:28:25',NULL),(122,1,'active',0,'Prof. Timothy Block','dietrich.alanis@example.net',NULL,'$2y$12$gV3ETYhkOs7YC7wIVWxAxu1QRoQ1dSTyf/cXi8/.UlhpxW7o80M1m','(423) 483-1267','https://via.placeholder.com/200x200.png/004455?text=people+maiores','Voluptas iusto sint neque facere laboriosam tempore eveniet rerum odio totam.',NULL,'2026-08-11 03:28:26','2026-08-11 03:28:26',NULL),(123,1,'active',0,'Dr. Brenda Schmeler Jr.','aniya.batz@example.com',NULL,'$2y$12$Z8.k7wuEqRt4zbGfLfCyhumFV1A5tZ83aHlrZF.On06OOyIiIuJCe','1-562-928-5346','https://via.placeholder.com/200x200.png/00cc11?text=people+voluptatum','Sunt enim fugit dolores aut quam.',NULL,'2026-08-11 03:28:26','2026-08-11 03:28:26',NULL),(125,2,'active',0,'Skyla King','hester38@example.com',NULL,'$2y$12$ZpPpYzJQQrKT0mt8RealQO2mL7HuqcfWur/L813Ye23sr6h.VGera','954.324.6774','https://via.placeholder.com/200x200.png/001177?text=people+odio','Enim omnis quae unde consequatur et voluptatem qui.',NULL,'2026-08-11 03:28:26','2026-08-11 03:28:26',NULL),(126,2,'active',0,'Liam Smith','hunter.schultz@example.org',NULL,'$2y$12$nHSCXoN2WAN.xmPkhrkIBeKdlmj5G9Lrvx1bdzT2/ls6Yqkf5TFSi','717-599-5248','https://via.placeholder.com/200x200.png/007799?text=people+aliquam','Magnam deleniti accusamus accusamus ex quas sapiente ut minus.',NULL,'2026-08-11 03:28:26','2026-08-11 03:28:26',NULL),(129,1,'active',0,'Owen Cormier MD','elebsack@example.net',NULL,'$2y$12$kekQdqsc2BzT2l3XbUNSPesriMfeP77xWjCFpIJqCD2eX2uutp5HG','862-386-5699','https://via.placeholder.com/200x200.png/0022aa?text=people+esse','Rem sint voluptas delectus ea magni.',NULL,'2026-08-11 03:28:27','2026-08-11 03:28:27',NULL),(130,2,'active',0,'Prof. Lavern Cassin Sr.','bstrosin@example.net',NULL,'$2y$12$T6zU92uMXIZLRrQql/ctcudy9U9ZbL3MhUK4W0TGWUnuezcxQXppS','+1-929-578-7813','https://via.placeholder.com/200x200.png/00ccdd?text=people+enim','Et mollitia ut vero libero optio ea ratione sit sit dolorem consectetur.',NULL,'2026-08-11 03:28:27','2026-08-11 03:28:27',NULL),(131,2,'active',0,'Wilfrid Rau I','rortiz@example.com',NULL,'$2y$12$J2KDo6kDjhU187TWwnSSZe.ih45wDDPUFMmezYxxBzGlOpxaWQoFm','+1 (435) 434-3556','https://via.placeholder.com/200x200.png/00eeff?text=people+ullam','Animi eligendi non tempora quibusdam et alias quaerat id illum.',NULL,'2026-08-11 03:28:27','2026-08-11 03:28:27',NULL),(132,2,'active',0,'Harmony Mayert','lonnie.yost@example.org',NULL,'$2y$12$S.UvkoQnABUkAgUq0iIms.dvVbOdMwQjAI9xkBCnha5jKR15t.hoG','1-480-305-9291','https://via.placeholder.com/200x200.png/006666?text=people+qui','Rerum error quaerat repudiandae sunt sint quia est suscipit impedit harum.',NULL,'2026-08-11 03:28:27','2026-08-11 03:28:27',NULL),(134,2,'active',0,'Randal Pagac Jr.','leo63@example.com',NULL,'$2y$12$UuSUQOrEg65fGT77TYK7CeKX9TldEcimXiC5ObBISQGr.sRwF5uDq','1-470-837-5696','https://via.placeholder.com/200x200.png/008855?text=people+cupiditate','Quaerat sed et voluptatum iste quia eum tempora.',NULL,'2026-08-11 03:28:28','2026-08-11 03:28:28',NULL),(136,1,'active',0,'Prof. Britney Toy','linnea.jones@example.org',NULL,'$2y$12$kNVZEHRJRwV7awhF441TfeVNBk6lujA5rWZAsoBUTeXvjb4gDDB2a','(463) 646-0271','https://via.placeholder.com/200x200.png/009955?text=people+incidunt','Et commodi dolore ullam sed excepturi qui est.',NULL,'2026-08-11 03:28:28','2026-08-11 03:28:28',NULL),(137,2,'active',0,'Marvin Weissnat','gwilkinson@example.net',NULL,'$2y$12$20Ks2ZXr2s/Uarho4v97P.R/UgTavl5e5Nwl8kywhxObz8KyQTzmy','+1.283.471.3282','https://via.placeholder.com/200x200.png/0066ff?text=people+voluptatibus','Debitis magnam quia ipsa et ut nostrum quis recusandae.',NULL,'2026-08-11 03:28:28','2026-08-11 03:28:28',NULL),(142,2,'active',0,'Dario Bailey','kessler.joelle@example.com',NULL,'$2y$12$YxSVPNMp6b4tYeZX.1GIkefoZVwZV3i3g4G6k/gb.M2LordyNtz1q','+12243889690','https://via.placeholder.com/200x200.png/0055ff?text=people+amet','Est ut quia et rerum rerum nemo.',NULL,'2026-08-11 03:28:29','2026-08-11 03:28:29',NULL),(143,2,'active',0,'Prof. Toni Steuber','streich.marc@example.com',NULL,'$2y$12$8Blbbw3tKW6P9ocR2pvchO.wDQMH41vjf0tP8eEHB7Uq1/q/1XcEC','+1.321.975.9803','https://via.placeholder.com/200x200.png/009966?text=people+sequi','Odio et accusamus temporibus libero incidunt aut.',NULL,'2026-08-11 03:28:29','2026-08-11 03:28:29',NULL),(146,1,'active',0,'Mrs. Kailee Gleason','blair67@example.org',NULL,'$2y$12$4diLJXO8sm7VU7ercm/L7ulW5VjRkB4nVGsODzbebUrVYwpCtjDAi','+1-218-536-2946','https://via.placeholder.com/200x200.png/003311?text=people+dolores','Veniam qui molestiae doloremque sint optio velit consequatur.',NULL,'2026-08-11 03:28:30','2026-08-11 03:28:30',NULL),(147,2,'active',0,'Selena Friesen III','carmine32@example.net',NULL,'$2y$12$X3oRnfDjy2LlB5pJVSliru8a2RrZ4ANlK/yawwSICwC5hMBNFGamu','(909) 769-9390','https://via.placeholder.com/200x200.png/00eeaa?text=people+qui','Dolorum ut quia quam minima et enim.',NULL,'2026-08-11 03:28:30','2026-08-11 03:28:30',NULL),(150,2,'active',0,'Miss Anahi Walker','jlynch@example.net',NULL,'$2y$12$uagFFsHEAFW/n2bMYAjFsemshJwvfjoU.0XM17J9cXFC8.snm5RLe','1-517-293-6376','https://via.placeholder.com/200x200.png/0022dd?text=people+fugiat','Quas voluptate fugit et harum est alias ipsum nulla aperiam consectetur.',NULL,'2026-08-11 03:28:30','2026-08-11 03:28:30',NULL),(151,2,'active',0,'Catharine Rempel Sr.','martine.olson@example.net',NULL,'$2y$12$dE/g5CHCknAj9hBf3k2.uOjj1LiOmP1z9TFJ5YpiJP/KWRjn6eW0q','+17543104141','https://via.placeholder.com/200x200.png/00bb00?text=people+in','Fugiat cumque quae laudantium ratione numquam dignissimos similique.',NULL,'2026-08-11 03:28:31','2026-08-11 03:28:31',NULL),(153,2,'active',0,'Jaunita Spinka','mabelle32@example.com',NULL,'$2y$12$s3p2boiRjsO/qo0oC0QV0.FYMEyPTkSMafD0EMClHs5pQbDXWO3LS','(707) 271-0529','https://via.placeholder.com/200x200.png/000099?text=people+voluptatem','Ab inventore est aut enim sapiente ratione quidem vero ea incidunt.',NULL,'2026-08-11 03:28:31','2026-08-11 03:28:31',NULL),(154,2,'active',0,'Ms. Lia Kuphal II','hodkiewicz.meaghan@example.net',NULL,'$2y$12$z1KemCMEmyD3lsfEGbdnv.P0GSPj2mZPpaupap7ktwtKewpoBqoau','(440) 457-6274','https://via.placeholder.com/200x200.png/00aa99?text=people+hic','Iusto dolore molestiae ut in et est.',NULL,'2026-08-11 03:28:31','2026-08-11 03:28:31',NULL),(155,2,'active',0,'Ettie Gutmann','vandervort.oran@example.net',NULL,'$2y$12$RGS.W9Lxv5gP46VNP33NEeOLLm9WYX/G7Hb6GA1GJeEHussRmCJ6C','(434) 904-1048','https://via.placeholder.com/200x200.png/00aa44?text=people+et','Et non aut rerum rem maxime.',NULL,'2026-08-11 03:28:31','2026-08-11 03:28:31',NULL),(156,2,'active',0,'Mrs. Rylee Little IV','mosciski.tremayne@example.com',NULL,'$2y$12$dCYMoyDTeYT/.0efowPnp.CuKxu2S7uVMYXt.Ou2yeurqpXNF4AT.','(713) 508-3822','https://via.placeholder.com/200x200.png/0022ff?text=people+voluptas','Et aut cupiditate repellat voluptas maxime molestiae dolorum.',NULL,'2026-08-11 03:28:31','2026-08-11 03:28:31',NULL),(157,2,'active',0,'Desmond Langosh','nestor62@example.org',NULL,'$2y$12$gT2M3Dnwa2sTL8Hdx82lB.kog9y84qJ8q4G77spV7UZtNdRRAUHf6','682-724-1373','https://via.placeholder.com/200x200.png/003377?text=people+consequuntur','Quod animi rerum molestias est.',NULL,'2026-08-11 03:28:32','2026-08-11 03:28:32',NULL),(158,2,'active',0,'Heath Stracke','ecorwin@example.net',NULL,'$2y$12$Wund/9CFOKZuVrQ39e3ETe58zWNoEuoKFG/u2XvzUsAnIUlV7J2dC','+1.907.295.3244','https://via.placeholder.com/200x200.png/00dd44?text=people+hic','Perferendis et architecto consectetur et unde repellat.',NULL,'2026-08-11 03:28:32','2026-08-11 03:28:32',NULL),(159,1,'active',0,'Zella Berge','lambert.erdman@example.org',NULL,'$2y$12$H62JVJ4vBy9Cv5qV3qIxVuyBhiAMYmTru57TdDxsaiLzB1zMmP4pK','+1 (936) 954-3414','https://via.placeholder.com/200x200.png/007722?text=people+consequatur','Ut rem fuga occaecati sint consequatur rem et quia.',NULL,'2026-08-11 03:28:32','2026-08-11 03:28:32',NULL),(160,1,'active',0,'Ms. Kelli Little PhD','mkuhic@example.net',NULL,'$2y$12$1ZpATGr5SOgRyRhGlt1kr.qhPNplJO2aACiq9ldL2A0KPuGH6K/yG','774-843-3008','https://via.placeholder.com/200x200.png/009977?text=people+placeat','Neque sint cupiditate consequatur voluptatum commodi id quam sint dolore.',NULL,'2026-08-11 03:28:32','2026-08-11 03:28:32',NULL),(161,1,'active',0,'Mr. Alexis Kerluke','harvey.marvin@example.org',NULL,'$2y$12$/4xAqlqy4l..EZTgg/XWFeGaHVoYT4VXnydW0zCcipiHrdQR9BZtm','331.958.6777','https://via.placeholder.com/200x200.png/00bbcc?text=people+iste','Qui voluptatem saepe et a facere accusantium voluptatum.',NULL,'2026-08-11 03:28:32','2026-08-11 03:28:32',NULL),(162,2,'active',0,'Dr. Nikolas Fahey','weber.bryce@example.org',NULL,'$2y$12$8UgyOKmoTAUVloKIj6Tw8OqmaVYGdcpqkF6mm1NJ7383ZSrNTf3BK','678-846-3403','https://via.placeholder.com/200x200.png/00bbcc?text=people+eius','Sint assumenda praesentium ratione quia eos assumenda reiciendis repellat qui.',NULL,'2026-08-11 03:28:33','2026-08-11 03:28:33',NULL),(163,2,'active',0,'Kelli Schinner','robbie.muller@example.net',NULL,'$2y$12$USlptqHh7R7M6ljEMrGjJe8TuEQgkmQm0ud5y.fZwV0dJFmgrmLfy','+1 (786) 994-4219','https://via.placeholder.com/200x200.png/001133?text=people+blanditiis','Enim harum id quo eos sint.',NULL,'2026-08-11 03:28:33','2026-08-11 03:28:33',NULL),(498,1,'active',0,'Ariel Volkman','xrogahn@example.org',NULL,'$2y$12$YLH0pxOjuDpz9Bj.q.m4OOZ0eghWLRoZYfhr8ltJn0np.qsBV7PqS','+1 (614) 557-3833','https://via.placeholder.com/200x200.png/00bbcc?text=people+et','Quia aut sed porro ullam consequatur ea aut rerum.',NULL,'2026-08-11 04:29:25','2026-08-11 04:29:25',NULL),(499,1,'active',0,'Miss Paige Thompson I','pprosacco@example.net',NULL,'$2y$12$ag0lsflfLQAjQgO6c0HDDuYq19pSieFMWAeDGDKxEVfBzku5YAmyq','+1-407-652-9659','https://via.placeholder.com/200x200.png/00eeff?text=people+totam','Et nostrum vero non sit sit.',NULL,'2026-08-11 04:29:25','2026-08-11 04:29:25',NULL),(501,1,'active',0,'Mrs. Betty Armstrong','emard.bethel@example.org',NULL,'$2y$12$L9w6YcDsSENsqr12een49OnlvPAzkR5W/hyHBgZIEkHIuSKCihdGe','1-385-462-5669','https://via.placeholder.com/200x200.png/003344?text=people+possimus','Laudantium odio cumque ipsam amet aut voluptate aliquam.',NULL,'2026-08-11 04:29:26','2026-08-11 04:29:26',NULL),(502,1,'active',0,'Bernadette D\'Amore MD','hane.herbert@example.net',NULL,'$2y$12$ivTd9gnerO3oZ/0SBu2I7e9To0qoiYrjVMZAIcCqU2p4x8ujnc6tm','843.243.5630','https://via.placeholder.com/200x200.png/00bbff?text=people+a','Expedita quo delectus ut omnis impedit provident cumque mollitia.',NULL,'2026-08-11 04:29:26','2026-08-11 04:29:26',NULL),(503,1,'active',0,'Gloria Shields Jr.','ciara17@example.net',NULL,'$2y$12$/RoNScYyTqj5OfSBukbEwuOxJTjzI7YYFM3dMBibJRxKcFoabzrYG','+1.336.531.6169','https://via.placeholder.com/200x200.png/0044ee?text=people+eos','Quia qui voluptas quae sunt dolores et optio veritatis.',NULL,'2026-08-11 04:29:26','2026-08-11 04:29:26',NULL),(504,1,'active',0,'Dr. Lilla Harvey PhD','bernard.mertz@example.net',NULL,'$2y$12$F9i4BrbjOS3SfgygRaScvOIbGLPQ0FiJ.yo30VRWGk3eWYSa2T5WW','305.207.3007','https://via.placeholder.com/200x200.png/0000bb?text=people+tempore','Harum natus assumenda voluptatem quo repudiandae ut.',NULL,'2026-08-11 04:29:26','2026-08-11 04:29:26',NULL),(505,1,'active',0,'Darius Feeney II','hane.ryan@example.net',NULL,'$2y$12$RNbvMXx5PF4B5CUiWZUt9exb3BCnL8RDbRE/CMxG8GuK4F7QEhR8G','872-951-3738','https://via.placeholder.com/200x200.png/00eeee?text=people+eaque','Facilis quibusdam blanditiis ut ratione velit voluptate error aut.',NULL,'2026-08-11 04:29:26','2026-08-11 04:29:26',NULL),(506,1,'active',0,'Brigitte Weissnat I','edwardo30@example.com',NULL,'$2y$12$5wsI9HQwR7nljAQLaFz/Xuo1zSdSA.7r/tUfJC32ltbYOFrAOwqzS','+1.360.881.3645','https://via.placeholder.com/200x200.png/00aa33?text=people+perferendis','Molestiae temporibus omnis nihil consequatur omnis minima sint sapiente.',NULL,'2026-08-11 04:29:27','2026-08-11 04:29:27',NULL),(507,1,'active',0,'Guiseppe Bechtelar II','johnpaul.bogisich@example.net',NULL,'$2y$12$u2iGhItgI7KNt5D0HqCeFeCAY6olOSU3pzftBNg2lnm6s7/80H5Ku','+1-302-875-2156','https://via.placeholder.com/200x200.png/0011bb?text=people+quia','Tenetur eius iste perspiciatis nihil delectus quibusdam a.',NULL,'2026-08-11 04:29:27','2026-08-11 04:29:27',NULL),(508,1,'active',0,'Ms. Jennie Thiel','cummings.cyril@example.net',NULL,'$2y$12$IEZYe/mxZ4gfny/fi4mdiuRKWb2XXiOwyEORW5SSII84OT72lXZSm','1-385-299-3002','https://via.placeholder.com/200x200.png/005555?text=people+et','Dignissimos reiciendis porro hic neque dignissimos dolorem illum.',NULL,'2026-08-11 04:29:27','2026-08-11 04:29:27',NULL),(511,3,'active',0,'Mango','mango@gmail.com',NULL,'$2y$12$8e3Z.SF4kkenGpHQgClD4uTWg73peevrbQI6VQ7WhDvO5.EL/qYs6',NULL,'avatars/SIpptAWvvDewmOjHOfDIIcq51iC0nZRU534xIW93.jpg',NULL,NULL,'2026-08-12 10:44:32','2026-08-13 10:54:53',NULL),(512,3,'active',0,'Diana','diana@gmail.com',NULL,'$2y$12$YaZaIyzhVOxuI1ERecaCIeazEN36CZLNcAsOLseV78m01mbDHIT5.','0912345678','avatars/CGzf3FpLax96PyRr1oTfewSgccUETfew3P89uULL.jpg',NULL,NULL,'2026-08-13 11:10:42','2026-08-14 10:24:07',NULL),(513,3,'active',0,'John Doe','john@gmail.com',NULL,'$2y$12$CIMVD12EwmaECRHb1JOzoelZuj9AT6lHkbugsPN9iidK9A7dNMG3W',NULL,'avatars/mAIpZw83Fj3VSZfYnUzHPNgKy4E05mG1GGRAUTP4.jpg',NULL,NULL,'2026-08-13 12:54:53','2026-08-13 12:57:30',NULL),(514,3,'active',0,'Jane Doe','jane@gmail.com',NULL,'$2y$12$mTh2i5unt19y6kiC8i5mqeqgXKqX4e9.urrmScCJmERAnFJJjLZZq',NULL,'avatars/H2dIBwTGLTkYP16g9uESKgJkzf4O4wSq8MiHwhJm.jpg',NULL,NULL,'2026-08-13 12:55:16','2026-08-13 12:57:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-14 23:48:21
