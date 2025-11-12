<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

// Read form-data
$user_id = $_POST['user_id'] ?? '';
$sleep_date = $_POST['sleep_date'] ?? '';
$hours_slept = $_POST['hours_slept'] ?? '';

if (!$user_id || !$sleep_date || !$hours_slept) {
    echo json_encode([
        "status" => false,
        "message" => "Missing required fields"
    ]);
    exit;
}

// Check if record exists
$check = $conn->prepare("SELECT id FROM sleep_data WHERE user_id = ? AND sleep_date = ?");
$check->bind_param("is", $user_id, $sleep_date);
$check->execute();
$result = $check->get_result();

if ($result->num_rows > 0) {
    // Update existing
    $update = $conn->prepare("UPDATE sleep_data SET hours_slept = ? WHERE user_id = ? AND sleep_date = ?");
    $update->bind_param("dis", $hours_slept, $user_id, $sleep_date);
    $success = $update->execute();
} else {
    // Insert new
    $insert = $conn->prepare("INSERT INTO sleep_data (user_id, sleep_date, hours_slept) VALUES (?, ?, ?)");
    $insert->bind_param("isd", $user_id, $sleep_date, $hours_slept);
    $success = $insert->execute();
}

if ($success) {
    echo json_encode([
        "status" => true,
        "message" => "Sleep data saved"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Failed to save sleep data"
    ]);
}
?>
