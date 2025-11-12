<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$user_id = $_POST['user_id'] ?? '';

if (!$user_id) {
    echo json_encode(["status" => false, "message" => "User ID is required"]);
    exit;
}

// Fetch User Main Info
$userQuery = $conn->prepare("SELECT name, bmi_value, bmi_category, sleep_duration, calories_burned, water_intake FROM users WHERE id = ?");
$userQuery->bind_param("i", $user_id);
$userQuery->execute();
$userResult = $userQuery->get_result();

if ($userResult->num_rows === 0) {
    echo json_encode(["status" => false, "message" => "User not found"]);
    exit;
}

$user = $userResult->fetch_assoc();

// Fetch Water Logs
$waterQuery = $conn->prepare("SELECT time_slot, amount FROM water_logs WHERE user_id = ?");
$waterQuery->bind_param("i", $user_id);
$waterQuery->execute();
$waterResult = $waterQuery->get_result();

$waterLogs = [];
while ($row = $waterResult->fetch_assoc()) {
    $waterLogs[] = $row;
}

// Fetch Workouts
$workoutQuery = $conn->prepare("SELECT title, image, calories, time, progress FROM workouts WHERE user_id = ?");
$workoutQuery->bind_param("i", $user_id);
$workoutQuery->execute();
$workoutResult = $workoutQuery->get_result();

$workouts = [];
while ($row = $workoutResult->fetch_assoc()) {
    $workouts[] = $row;
}

// Final Response
$response = [
    "status" => true,
    "data" => [
        "name" => $user['name'],
        "bmi_value" => $user['bmi_value'],
        "bmi_category" => $user['bmi_category'],
        "sleep_duration" => $user['sleep_duration'],
        "calories_burned" => $user['calories_burned'],
        "water_intake" => $user['water_intake'],
        "water_logs" => $waterLogs,
        "workouts" => $workouts
    ]
];

echo json_encode($response);
?>
