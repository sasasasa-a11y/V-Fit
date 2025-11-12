<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$user_id = $_GET['user_id'] ?? '';

if (!$user_id) {
    echo json_encode(["status" => false, "message" => "User ID is required"]);
    exit;
}

$query = "SELECT workout_date, completion FROM workouts WHERE user_id = ? ORDER BY workout_date ASC";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = [
        "workout_date" => $row["workout_date"],
        "completion" => (float)$row["completion"]
    ];
}

echo json_encode(["status" => true, "data" => $data]);
