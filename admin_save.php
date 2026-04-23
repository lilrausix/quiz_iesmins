<?php
include 'db.php';
session_start();

// Check if admin is logged in (but since login is JS, perhaps skip for now, or add session)

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$topicTitle = $_POST['topic_title'] ?? '';
$questions = json_decode($_POST['questions'] ?? '[]', true);

if (empty($topicTitle) || empty($questions)) {
    echo json_encode(['success' => false, 'message' => 'Missing topic title or questions']);
    exit;
}

// Insert topic
$stmt = $conn->prepare("INSERT INTO topics (title) VALUES (?)");
$stmt->bind_param("s", $topicTitle);
$stmt->execute();
$topicId = $stmt->insert_id;
$stmt->close();

if (!$topicId) {
    echo json_encode(['success' => false, 'message' => 'Failed to insert topic']);
    exit;
}

// Insert questions
$stmt = $conn->prepare("INSERT INTO questions (topic_id, question_text, correct_answer, wrong_1, wrong_2, wrong_3) VALUES (?, ?, ?, ?, ?, ?)");
foreach ($questions as $q) {
    $questionText = $q['question'];
    $answers = $q['answers'];
    if (count($answers) < 2) continue;
    $correct = $answers[0];
    $wrong1 = $answers[1] ?? '';
    $wrong2 = $answers[2] ?? '';
    $wrong3 = $answers[3] ?? '';
    $stmt->bind_param("isssss", $topicId, $questionText, $correct, $wrong1, $wrong2, $wrong3);
    $stmt->execute();
}
$stmt->close();

echo json_encode(['success' => true, 'message' => 'Topic and questions saved successfully']);
$conn->close();
?>