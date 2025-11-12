<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $bedtime = $_POST['bedtime'] ?? '';
    $alarm   = $_POST['alarm_time'] ?? '';
    $log_date = $_POST['date'] ?? date('Y-m-d');

    if (empty($bedtime) || empty($alarm)) {
        echo json_encode(["status" => "error", "message" => "Bedtime and Alarm time required"]);
        exit;
    }

    try {
        $bed = new DateTime($bedtime);
        $alarmDt = new DateTime($alarm);
        if ($alarmDt <= $bed) {
            $alarmDt->modify('+1 day');
        }

        $diff = $bed->diff($alarmDt);
        $hours = $diff->h + ($diff->i / 60);
        $hours = round($hours, 2);

        $stmt = $pdo->prepare("INSERT INTO sleep_tracker (log_date, bedtime, alarm_time, sleep_duration) VALUES (?, ?, ?, ?)");
        $stmt->execute([$log_date, $bed->format('H:i:s'), $alarmDt->format('H:i:s'), $hours]);

        echo json_encode(["status" => "success", "sleep_duration" => $hours]);
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
    exit;
}

echo json_encode(["status" => "error", "message" => "POST request required"]);

