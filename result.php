<?php
include 'db.php';
session_start();
$score = $_GET['score'] ?? 0;
$total = $_GET['total'] ?? 0;
$topic_id = $_GET['topic_id'] ?? 0;
$wrong = isset($_GET['wrong']) ? json_decode(urldecode($_GET['wrong']), true) : [];

// Insert into database
if (isset($_SESSION['user_id']) && $topic_id > 0) {
    $stmt = $conn->prepare("INSERT INTO quiz_attempts (user_id, topic_id, score, total_questions) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("iiii", $_SESSION['user_id'], $topic_id, $score, $total);
    $stmt->execute();
}
?>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="style.css"></head>
<body>
<div class="container">
    <h2>Rezultāts</h2>
    <p><?php echo htmlspecialchars($_SESSION['username']); ?>, tu atbildēji pareizi uz <?php echo $score; ?> no <?php echo $total; ?> jautājumiem.</p>
    <?php if (!empty($wrong)): ?>
    <button onclick="showWrong()">Parādīt nepareizās atbildes</button>
    <div id="wrongAnswers" style="display:none;">
        <h3>Nepareizās atbildes:</h3>
        <ul>
        <?php foreach ($wrong as $w): ?>
            <li>
                <strong>Jautājums:</strong> <?php echo htmlspecialchars($w['question']); ?><br>
                <strong>Tava atbilde:</strong> <?php echo htmlspecialchars($w['selected']); ?><br>
                <strong>Pareizā atbilde:</strong> <?php echo htmlspecialchars($w['correct']); ?>
            </li>
        <?php endforeach; ?>
        </ul>
    </div>
    <?php endif; ?>
    <a href="topics.php"><button>Mēģināt vēlreiz</button></a>
    <a href="index.php"><button style="background:gray">Iziet</button></a>
</div>
<script>
function showWrong() {
    document.getElementById('wrongAnswers').style.display = 'block';
}
</script>
</body>
</html>