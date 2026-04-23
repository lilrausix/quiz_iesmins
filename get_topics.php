<?php
include 'db.php';

header('Content-Type: application/json');

$topics = $conn->query("SELECT id, title FROM topics");
$result = [];

while ($row = $topics->fetch_assoc()) {
    $result[] = $row;
}

echo json_encode($result);
$conn->close();
?>