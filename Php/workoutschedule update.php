<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$id = $_POST['id'] ?? '';
$time = $_POST['time'] ?? '';

if (!$id || !$time) {
    echo json_encode(["status" => false, "message" => "Workout ID and new time are required"]);
    exit;
}

$stmt = $conn->prepare("UPDATE workout_schedule SET time = ? WHERE id = ?");
$stmt->bind_param("si", $time, $id);

if ($stmt->execute()) {
    echo json_encode(["status" => true, "message" => "Workout time updated successfully"]);
} else {
    echo json_encode(["status" => false, "message" => "Failed to update workout time"]);
}
$stmt->close();
$conn->close();
?>
