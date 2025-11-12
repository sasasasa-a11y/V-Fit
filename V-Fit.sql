-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 14, 2025 at 12:45 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `V-Fit`
--

-- --------------------------------------------------------

--
-- Table structure for table `alarms`
--

CREATE TABLE `alarms` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alarm_time` time NOT NULL,
  `repeat_days` varchar(100) NOT NULL,
  `is_on` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `daily_workouts`
--

CREATE TABLE `daily_workouts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `time` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_workouts`
--

INSERT INTO `daily_workouts` (`id`, `user_id`, `title`, `time`, `date`, `created_at`) VALUES
(1, 1, 'Upper Body Workout', '07:30 AM', '2025-07-14', '2025-07-14 04:47:29'),
(2, 1, 'Upperbody', '10:37 AM', '2025-07-14', '2025-07-14 05:05:10'),
(3, 1, 'Ab Workout', '07:00 AM', '2025-07-14', '2025-07-14 05:43:16'),
(4, 1, 'Upperbody', '11:28 AM', '2025-07-14', '2025-07-14 05:57:19');

-- --------------------------------------------------------

--
-- Table structure for table `excercise`
--

CREATE TABLE `excercise` (
  `id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL DEFAULT '""',
  `image` varchar(300) NOT NULL DEFAULT '""',
  `caloriesburn` varchar(300) NOT NULL DEFAULT '""',
  `description` varchar(300) NOT NULL DEFAULT '""',
  `p1` varchar(300) NOT NULL DEFAULT '"""',
  `p2` varchar(300) NOT NULL DEFAULT '"""',
  `p3` varchar(300) NOT NULL DEFAULT '"""',
  `p4` varchar(300) NOT NULL DEFAULT '"""',
  `p1description` varchar(300) NOT NULL DEFAULT '"""',
  `p2description` varchar(300) NOT NULL DEFAULT '"""',
  `p3description` varchar(300) NOT NULL DEFAULT '"""',
  `p4description` varchar(300) NOT NULL DEFAULT '"""'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `excercise`
--

INSERT INTO `excercise` (`id`, `title`, `image`, `caloriesburn`, `description`, `p1`, `p2`, `p3`, `p4`, `p1description`, `p2description`, `p3description`, `p4description`) VALUES
(2, 'Warm up', '6870ce0e5db80_Ex1.png', '250 Calories Burn', 'The initial preparation is essential before exercising to prevent injury and increase the feeling of body flexibility. A warm up exercise is easy, you can do it without any strict techniques.', 'Spread Your Arms', 'Body Twisting', 'Neck Rotations', 'Light Jog in Place', 'To make the warm up feel more relaxed, stretch your arms as you start this movement. No bending of hands', 'Waist twisting is a common but effective warm up move. Keep your posture straight while doing this.', 'Slowly rotate your neck clockwise and anti-clockwise to loosen up your neck and upper spine.', 'Jogging in place helps activate the lower body and elevate the heart rate gently before the workout'),
(3, 'JumpingJackView', '6870d2074a5ea_Image.png', '300Calories Burn', 'Jumping jacks are a full-body conditioning exercise that help improve cardiovascular endurance and muscle tone. They are commonly used in warm-up routines', 'Start Position', 'Jump and Spread', 'Return Position', 'Repeat', 'Stand straight with feet together and hands by your sides', 'Jump while spreading your legs and lifting arms overhead', 'Land softly back with feet together and arms by your sides', 'Continue jumping in rhythm for the selected repetitions'),
(4, 'SkippingView', '6870e058d4cc4_Image.png', '400Calories Burn', 'Skipping is a high-intensity cardiovascular exercise that engages your entire body. It’s excellent for burning calories, improving coordination, and increasing endurance', 'Hold the Rope', 'Start Slow', 'Maintain Rhythm', 'Land Softly', 'Grip the handles of the skipping rope firmly, one in each hand', 'Begin with small jumps just high enough to let the rope pass beneath your feet', 'Rotate the rope with your wrists, not arms, and jump consistently', 'Land on the balls of your feet with knees slightly bent to absorb impact'),
(5, 'SquatsView', '6870e17d441e4_Image.png', '200Calories Burn', 'Squats are a full-body exercise that targets the thighs, hips, and buttocks. They help strengthen the lower body and core, and improve flexibility and posture', 'Stand Tall', 'Lower Down', 'Hold Position', 'Rise Back Up', 'Place your feet shoulder-width apart, toes slightly out', 'Bend your knees and push your hips back as if sitting on a chair', 'Go as low as you can, keeping your back straight', 'Push through your heels and return to the starting position'),
(6, 'ArmRaisesView', '6872188ad13f2_Image.png', '100 Calories Burn', 'Arm raises help warm up the shoulders and improve mobility. They are effective for increasing circulation and preparing for upper-body exercises', 'Stand Upright', 'Raise Arms Forward', 'Hold the Position', 'Lower Slowly', 'Stand with your feet shoulder-width apart and arms relaxed by your sides', 'Slowly lift your arms forward until they reach shoulder height', 'Pause briefly at the top, keeping arms parallel to the floor', 'Return your arms to the starting position in a controlled motion'),
(7, 'DrinkandRest', '6872197e3c9da_Image.png', '0 Calories Burn', 'Rest and hydration are crucial between and after workouts. They help your body recover and maintain performance levels', 'Sit Down Comfortably', 'Drink Water', 'Breathe Deeply', 'Be comfort', 'Find a quiet space to rest and allow your heart rate to come down', 'Rehydrate yourself with a glass of water or electrolyte drink', 'Take slow, deep breaths to help your muscles relax and recover', 'Be comfort as per your wish'),
(8, 'InclinePushUps', '68721bfa2e109_Image.png', '150 Calories Burn', 'Incline push-ups target your chest, shoulders, and triceps while being easier on the wrists. They\'re a great variation for beginners or warm-up routines.', 'Position Yourself', 'Place Hands & Lower', 'Push Back Up', 'Repeat it', 'Stand facing a sturdy elevated surface like a bench or step', 'Put your hands shoulder-width apart and lower your body towards the surface', 'Push through your palms to return to the starting position. Keep your body straight', 'Repeat it necessary'),
(9, 'PushUps', '68721d4367be8_Image.png', '200 Calories Burn', 'Push-ups are a fundamental strength training exercise that works the chest, shoulders, triceps, and core. Keep a straight body line and control the motion', 'Get Into Position', 'Lower Your Body', 'Push Back Up', 'Repeat it', 'Start in a plank position with hands slightly wider than shoulders', '\"Bend elbows to lower your chest toward the ground while keeping your core tight', 'Extend your arms to return to the start position. Repeat with control', 'Repeat continuous '),
(10, 'Cobra Sketch', '68721e1ddd918_Image.png', '180 Calories Burn', 'Cobra Sketch is a stretching pose from yoga that helps in improving spinal flexibility and relieving lower back tension. Breathe deeply and avoid forcing your back too much', 'Lie on Your Belly', 'Lift Your Chest', 'Hold & Breathe', 'Repeat it', 'Start by lying flat on your stomach with your legs extended and palms placed under your shoulders.', 'Press into your hands to lift your chest off the ground, keeping your elbows close', 'Hold the position while breathing deeply. Avoid overextending your lower back.', 'Repeat continuous ');

-- --------------------------------------------------------

--
-- Table structure for table `fullbodyworkout`
--

CREATE TABLE `fullbodyworkout` (
  `warmup` varchar(300) NOT NULL DEFAULT '""',
  `jumpingjack` varchar(300) NOT NULL DEFAULT '""',
  `Skipping` varchar(300) NOT NULL DEFAULT '""',
  `Squats` varchar(300) NOT NULL DEFAULT '""',
  `armsraise` varchar(300) NOT NULL DEFAULT '""',
  `drinkandrest` varchar(300) NOT NULL DEFAULT '""',
  `inclinePushUps` varchar(300) NOT NULL DEFAULT '""',
  `PushUps` varchar(300) NOT NULL DEFAULT '""',
  `CobraSketch` varchar(300) NOT NULL DEFAULT '""'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `email`, `password`) VALUES
(1, 'chinnu21@gmail.com', 'Chinnu@123'),
(2, 'Sathyapriyapandikumar@gmail.com', 'Sathya@123'),
(3, '252434028.sclas@saveetha.com', 'User@123'),
(4, 'priya12@gmail.com', 'Priya@123');

-- --------------------------------------------------------

--
-- Table structure for table `meals`
--

CREATE TABLE `meals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `meal_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `time` varchar(20) NOT NULL,
  `emoji` varchar(10) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `reminder` tinyint(1) DEFAULT 0,
  `meal_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nutrition_stats`
--

CREATE TABLE `nutrition_stats` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `day` varchar(10) NOT NULL,
  `calories` int(11) DEFAULT 0,
  `fibre` int(11) DEFAULT 0,
  `fats` int(11) DEFAULT 0,
  `sugar` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `id` int(11) NOT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`id`, `firstName`, `lastName`, `email`, `phone`, `password`) VALUES
(1, 'hemanth', 'sai', 'chinnu21@gmail.com', '9100800764', 'Chinnu@123'),
(2, 'sathya', 'priya', 'Sathyapriyapandikumar@gmail.com', '8300750553', 'Sathya@123'),
(3, 'sathya', 'priya', '252434028.sclas@saveetha.com', '9087120461', 'User@123'),
(4, 'priya', 'sathya', 'priya12@gmail.com', '9876543212', 'Priya@123');

-- --------------------------------------------------------

--
-- Table structure for table `sleep_alarms`
--

CREATE TABLE `sleep_alarms` (
  `id` int(11) NOT NULL,
  `bedtime` time NOT NULL,
  `repeat_option` varchar(50) NOT NULL,
  `sleep_duration` varchar(30) NOT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sleep_alarms`
--

INSERT INTO `sleep_alarms` (`id`, `bedtime`, `repeat_option`, `sleep_duration`, `created_at`) VALUES
(1, '22:30:00', 'Mon to Fri', '8 hours 0 minutes', '2025-07-04');

-- --------------------------------------------------------

--
-- Table structure for table `sleep_data`
--

CREATE TABLE `sleep_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sleep_date` date NOT NULL,
  `hours_slept` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sleep_data`
--

INSERT INTO `sleep_data` (`id`, `user_id`, `sleep_date`, `hours_slept`) VALUES
(1, 1, '2025-07-06', 10),
(2, 1, '2025-07-08', 9.1),
(3, 1, '2025-07-09', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sleep_schedule`
--

CREATE TABLE `sleep_schedule` (
  `id` int(11) NOT NULL,
  `entry_date` date NOT NULL,
  `bedtime` time NOT NULL,
  `wakeup` time NOT NULL,
  `sleep_duration` decimal(4,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sleep_schedule`
--

INSERT INTO `sleep_schedule` (`id`, `entry_date`, `bedtime`, `wakeup`, `sleep_duration`, `created_at`) VALUES
(1, '2025-07-16', '22:15:00', '06:45:00', 8.50, '2025-07-04 06:20:31');

-- --------------------------------------------------------

--
-- Table structure for table `sleep_tracker`
--

CREATE TABLE `sleep_tracker` (
  `id` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `bedtime` time NOT NULL,
  `alarm_time` time NOT NULL,
  `sleep_duration` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `bmi_value` float DEFAULT NULL,
  `bmi_category` varchar(100) DEFAULT NULL,
  `sleep_duration` varchar(20) DEFAULT NULL,
  `calories_burned` int(11) DEFAULT NULL,
  `water_intake` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `height` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id`, `user_id`, `gender`, `date_of_birth`, `weight`, `height`) VALUES
(1, 1, 'Male', '2004-02-06', 70, 180),
(2, 1, 'Female', '2004-08-05', 70, 190),
(3, 1, 'Female', '2010-08-09', 79, 158),
(4, 1, 'Female', '1997-08-09', 80, 134);

-- --------------------------------------------------------

--
-- Table structure for table `water_logs`
--

CREATE TABLE `water_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `time_slot` varchar(20) DEFAULT NULL,
  `amount` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workouts`
--

CREATE TABLE `workouts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `workout_date` date NOT NULL,
  `completion` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workout_schedule`
--

CREATE TABLE `workout_schedule` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `time` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alarms`
--
ALTER TABLE `alarms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daily_workouts`
--
ALTER TABLE `daily_workouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `excercise`
--
ALTER TABLE `excercise`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nutrition_stats`
--
ALTER TABLE `nutrition_stats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `sleep_alarms`
--
ALTER TABLE `sleep_alarms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sleep_data`
--
ALTER TABLE `sleep_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_sleep_day` (`user_id`,`sleep_date`);

--
-- Indexes for table `sleep_schedule`
--
ALTER TABLE `sleep_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sleep_tracker`
--
ALTER TABLE `sleep_tracker`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `water_logs`
--
ALTER TABLE `water_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `workouts`
--
ALTER TABLE `workouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workout_schedule`
--
ALTER TABLE `workout_schedule`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alarms`
--
ALTER TABLE `alarms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daily_workouts`
--
ALTER TABLE `daily_workouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `excercise`
--
ALTER TABLE `excercise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `meals`
--
ALTER TABLE `meals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nutrition_stats`
--
ALTER TABLE `nutrition_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `register`
--
ALTER TABLE `register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sleep_alarms`
--
ALTER TABLE `sleep_alarms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sleep_data`
--
ALTER TABLE `sleep_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sleep_schedule`
--
ALTER TABLE `sleep_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sleep_tracker`
--
ALTER TABLE `sleep_tracker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `water_logs`
--
ALTER TABLE `water_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workouts`
--
ALTER TABLE `workouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workout_schedule`
--
ALTER TABLE `workout_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `register` (`id`);

--
-- Constraints for table `water_logs`
--
ALTER TABLE `water_logs`
  ADD CONSTRAINT `water_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
