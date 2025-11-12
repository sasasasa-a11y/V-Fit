<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$user_id = isset($_GET['user_id']) ? intval($_GET['user_id']) : 0;

$stmt = $conn->prepare("SELECT alarm_time, repeat_days, is_on FROM alarms WHERE user_id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$alarms = [];
while ($row = $result->fetch_assoc()) {
    $alarms[] = $row;
}

echo json_encode([
    "status" => true,
    "alarms" => $alarms
]);
?>
