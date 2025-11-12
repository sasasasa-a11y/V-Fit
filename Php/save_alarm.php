<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

require 'config.php';

$user_id = $_POST['user_id'] ?? '';
$alarm_time = $_POST['alarm_time'] ?? '';
$repeat_days = $_POST['repeat_days'] ?? '';
$is_on = $_POST['is_on'] ?? '1';

if (!$user_id || !$alarm_time || !$repeat_days) {
    echo json_encode([
        "status" => false,
        "message" => "Missing required fields"
    ]);
    exit;
}

$stmt = $conn->prepare("INSERT INTO alarms (user_id, alarm_time, repeat_days, is_on) VALUES (?, ?, ?, ?)");

if ($stmt) {
    $stmt->bind_param("issi", $user_id, $alarm_time, $repeat_days, $is_on);
    if ($stmt->execute()) {
        echo json_encode(["status" => true, "message" => "Alarm saved successfully"]);
    } else {
        echo json_encode(["status" => false, "message" => "Execution failed"]);
    }
    $stmt->close();
} else {
    echo json_encode(["status" => false, "message" => "SQL prepare failed"]);
}

$conn->close();
?>
