<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$user_id = $_GET['user_id'] ?? '';

if (!$user_id) {
    echo json_encode([
        "status" => false,
        "message" => "User ID is required"
    ]);
    exit;
}

// Get last 7 sleep entries (sorted by date)
$query = $conn->prepare("SELECT sleep_date, hours_slept FROM sleep_data WHERE user_id = ? ORDER BY sleep_date DESC LIMIT 7");
$query->bind_param("i", $user_id);
$query->execute();
$result = $query->get_result();

$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = [
        "sleep_date" => $row['sleep_date'],
        "hours_slept" => floatval($row['hours_slept'])
    ];
}

echo json_encode([
    "status" => true,
    "data" => array_reverse($data) // reverse to show oldest -> newest
]);
?>
