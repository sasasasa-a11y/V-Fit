<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$user_id = $_POST['user_id'] ?? '';
$title   = $_POST['title'] ?? '';
$time    = $_POST['time'] ?? '';
$date    = $_POST['date'] ?? '';

if (!$user_id || !$title || !$time || !$date) {
    echo json_encode(["status" => false, "message" => "All fields are required"]);
    exit;
}

$stmt = $conn->prepare("INSERT INTO workout_schedule (user_id, title, time, date) VALUES (?, ?, ?, ?)");
$stmt->bind_param("isss", $user_id, $title, $time, $date);

if ($stmt->execute()) {
    echo json_encode(["status" => true, "message" => "Workout added"]);
} else {
    echo json_encode(["status" => false, "message" => "Insert failed"]);
}
?>
