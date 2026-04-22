<?php
include 'db.php';
session_start();
if (!isset($_SESSION['user_id'])) header("Location: index.php");

$user_id = $_SESSION['user_id'];
$query = $conn->prepare("SELECT qa.*, t.title FROM quiz_attempts qa JOIN topics t ON qa.topic_id = t.id WHERE qa.user_id = ? ORDER BY qa.date_taken DESC");
$query->bind_param("i", $user_id);
$query->execute();
$result = $query->get_result();
$attempts = [];
while($row = $result->fetch_assoc()) {
    $attempts[] = $row;
}
?>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="style.css"></head>
<body>
<div class="container">
    <h2>Tava uzdevumu vēsture</h2>
    <?php if (empty($attempts)): ?>
        <p>Tu vēl neesi pabeidzis nevienu testu.</p>
    <?php else: ?>
        <table>
            <tr>
                <th>Temats</th>
                <th>Rezultāts</th>
                <th>Datums</th>
            </tr>
            <?php foreach($attempts as $attempt): ?>
                <tr>
                    <td><?php echo htmlspecialchars($attempt['title']); ?></td>
                    <td><?php echo $attempt['score']; ?>/<?php echo $attempt['total_questions']; ?></td>
                    <td><?php echo $attempt['date_taken']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php endif; ?>
    <a href="topics.php"><button>Atpakaļ</button></a>
</div>
</body>
</html>