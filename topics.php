<?php
include 'db.php';
session_start();
if (!isset($_SESSION['user_id'])) header("Location: index.php");

$topics = $conn->query("SELECT * FROM topics");
?>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="style.css"></head>
<body>
<div class="container">
    <h2>Izvēlies tematu</h2>
    <?php while($row = $topics->fetch_assoc()): ?>
        <a href="test.php?topic_id=<?php echo $row['id']; ?>">
            <button><?php echo $row['title']; ?></button>
        </a>
    <?php endwhile; ?>
    <br><br>
    <a href="history.php"><button style="background:#28a745">Vēsture</button></a>
</div>
</body>
</html>