<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$firstName = $_POST['firstName'] ?? '';
$lastName  = $_POST['lastName'] ?? '';
$email     = $_POST['email'] ?? '';
$phone     = $_POST['phone'] ?? '';
$password  = $_POST['password'] ?? '';

if (!$firstName || !$lastName || !$email || !$phone || !$password) {
    echo json_encode(["status" => "error", "message" => "All fields are required"]);
    exit;
}

// Insert into register table
$stmt = $conn->prepare("INSERT INTO register (firstName, lastName, email, phone, password) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $firstName, $lastName, $email, $phone, $password);

if ($stmt->execute()) {
    $userId = $conn->insert_id;

    // Insert into login table
    $loginStmt = $conn->prepare("INSERT INTO login (email, password) VALUES (?, ?)");
    $loginStmt->bind_param("ss", $email, $password);
    $loginStmt->execute();

    echo json_encode(["status" => "success", "message" => "Registration successful", "user_id" => $userId]);
} else {
    echo json_encode(["status" => "error", "message" => "Registration failed"]);
}
?>
