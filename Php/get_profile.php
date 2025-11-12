<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Set response headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Include DB connection
require 'config.php';

// Prepare SQL query to join user_profiles and register
$sql = "
    SELECT 
        up.id AS profile_id,
        up.user_id,
        r.firstName,
        r.lastName,
        r.email,
        up.gender,
        up.date_of_birth,
        up.weight,
        up.height,
        up.created_at
    FROM user_profiles up
    INNER JOIN register r ON up.user_id = r.id
    ORDER BY up.created_at DESC
";

$result = $conn->query($sql);

if (!$result) {
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $conn->error
    ]);
    exit;
}

// Collect all rows
$profiles = [];
while ($row = $result->fetch_assoc()) {
    $profiles[] = $row;
}

// Return as JSON
echo json_encode([
    "status" => "success",
    "data" => $profiles
]);

$conn->close();
?>
