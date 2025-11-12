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

// 1. Get from register table
$registerStmt = $conn->prepare("SELECT firstName, lastName, email FROM register WHERE id = ?");
$registerStmt->bind_param("i", $user_id);
$registerStmt->execute();
$registerResult = $registerStmt->get_result();

if ($registerResult->num_rows === 0) {
    echo json_encode([
        "status" => false,
        "message" => "User not found in register table"
    ]);
    exit;
}

$registerData = $registerResult->fetch_assoc();
$fullName = $registerData['firstName'] . ' ' . $registerData['lastName'];
$email = $registerData['email'];

// 2. Get from user_profile table
$profileStmt = $conn->prepare("SELECT height, weight, date_of_birth FROM user_profile WHERE user_id = ?");
$profileStmt->bind_param("i", $user_id);
$profileStmt->execute();
$profileResult = $profileStmt->get_result();

if ($profileResult->num_rows === 0) {
    echo json_encode([
        "status" => false,
        "message" => "Profile data not found"
    ]);
    exit;
}

$profileData = $profileResult->fetch_assoc();

// 3. Combine and send
echo json_encode([
    "status" => true,
    "data" => [
        "name" => $fullName,
        "email" => $email,
        "height" => $profileData['height'],
        "weight" => $profileData['weight'],
        "date_of_birth" => $profileData['date_of_birth']
    ]
]);
