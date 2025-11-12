<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$id = $_POST['id'] ?? '';

if (!$id) {
    echo json_encode(["status" => false, "message" => "Workout ID is required"]);
    exit;
}

$check = $conn->prepare("SELECT * FROM workout_schedule WHERE id = ?");
$check->bind_param("i", $id);
$check->execute();
$result = $check->get_result();

if ($result->num_rows === 0) {
    echo json_encode(["status" => false, "message" => "Workout not found"]);
    exit;
}

$delete = $conn->prepare("DELETE FROM workout_schedule WHERE id = ?");
$delete->bind_param("i", $id);

if ($delete->execute()) {
    echo json_encode(["status" => true, "message" => "Workout deleted successfully"]);
} else {
    echo json_encode(["status" => false, "message" => "Failed to delete workout"]);
}
?>
