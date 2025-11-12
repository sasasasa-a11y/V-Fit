<?php
$host = "localhost";
$user = "root";
$pass = ""; // or "your_mysql_password"
$db   = "V-fit"; // your database name

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Database connection failed"]));
}
?>
