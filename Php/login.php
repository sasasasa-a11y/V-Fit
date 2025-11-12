<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

$email    = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (!$email || !$password) {
    echo json_encode(["status" => "error", "message" => "Email and password are required"]);
    exit;
}

// Match credentials from login table only
$stmt = $conn->prepare("SELECT * FROM login WHERE email = ? AND password = ?");
$stmt->bind_param("ss", $email, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();

    // Fallback: If user_id is null, use id as user_id
    $user_id = $user['user_id'] ?? null;
    if (!$user_id) {
        $user_id = $user['id'];
    }

    echo json_encode([
        "status" => "success",
        "message" => "Login successful",
        "data" => [
            "id"        => (int) $user['id'],
            "user_id"   => (int) $user_id,
            "email"     => $user['email'],
            "password"  => $user['password']
        ]
    ]);
} else {
    echo json_encode(["status" => "error", "message" => "Invalid email or password"]);
}
?>
