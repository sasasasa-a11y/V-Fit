<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require 'config.php';

// Upload directory
$uploadDir = 'photo/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

// Collect form data
$title           = $_POST['title'] ?? '';
$caloriesburn    = $_POST['caloriesburn'] ?? '';
$description     = $_POST['description'] ?? '';
$p1              = $_POST['p1'] ?? '';
$p2              = $_POST['p2'] ?? '';
$p3              = $_POST['p3'] ?? '';
$p4              = $_POST['p4'] ?? '';
$p1description   = $_POST['p1description'] ?? '';
$p2description   = $_POST['p2description'] ?? '';
$p3description   = $_POST['p3description'] ?? '';
$p4description   = $_POST['p4description'] ?? '';

// Handle file upload
$imageFileName = '';
if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
    $imageTmpPath = $_FILES['image']['tmp_name'];
    $imageName = basename($_FILES['image']['name']);
    $imageFileName = uniqid() . '_' . preg_replace('/\s+/', '_', $imageName);
    $destination = $uploadDir . $imageFileName;

    if (!move_uploaded_file($imageTmpPath, $destination)) {
        echo json_encode([
            "status" => false,
            "message" => "Failed to move uploaded image."
        ]);
        exit;
    }
} else {
    echo json_encode([
        "status" => false,
        "message" => "Image upload required."
    ]);
    exit;
}

// Check for missing fields
$fields = [
    'title' => $title,
    'caloriesburn' => $caloriesburn,
    'description' => $description,
    'p1' => $p1, 'p2' => $p2, 'p3' => $p3, 'p4' => $p4,
    'p1description' => $p1description,
    'p2description' => $p2description,
    'p3description' => $p3description,
    'p4description' => $p4description,
    'imageFileName' => $imageFileName
];

$missing = [];
foreach ($fields as $key => $val) {
    if (empty($val)) $missing[] = $key;
}

if (!empty($missing)) {
    echo json_encode([
        "status" => false,
        "message" => "Missing fields: " . implode(', ', $missing)
    ]);
    exit;
}

// Insert into DB
$sql = "INSERT INTO excercise (
    title, image, caloriesburn, description,
    p1, p2, p3, p4,
    p1description, p2description, p3description, p4description
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    echo json_encode([
        "status" => false,
        "message" => "Database prepare failed: " . $conn->error
    ]);
    exit;
}

$stmt->bind_param(
    "ssssssssssss",
    $title, $imageFileName, $caloriesburn, $description,
    $p1, $p2, $p3, $p4,
    $p1description, $p2description, $p3description, $p4description
);

if ($stmt->execute()) {
    echo json_encode([
        "status" => true,
        "message" => "Exercise inserted successfully",
        "image" => $imageFileName
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Database insert error: " . $stmt->error
    ]);
}

$stmt->close();
$conn->close();
?>
