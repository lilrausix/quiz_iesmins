<?php
include 'db.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request']);
    exit;
}

$topicId = $_POST['topic_id'] ?? 0;

if (!$topicId) {
    echo json_encode(['success' => false, 'message' => 'Missing topic ID']);
    exit;
}

// Delete questions first
$conn->query("DELETE FROM questions WHERE topic_id = $topicId");
// Then delete topic
$conn->query("DELETE FROM topics WHERE id = $topicId");

echo json_encode(['success' => true, 'message' => 'Topic deleted']);
$conn->close();
?>