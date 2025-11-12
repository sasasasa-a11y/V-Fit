<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$user_id = $_POST['user_id'] ?? '';
$date = $_POST['date'] ?? '';

if (!$user_id || !$date) {
    echo json_encode(["status" => false, "message" => "User ID and date required"]);
    exit;
}

$stmt = $conn->prepare("SELECT * FROM workout_schedule WHERE user_id = ? AND date = ?");
$stmt->bind_param("is", $user_id, $date);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode(["status" => true, "data" => $data]);
?>
