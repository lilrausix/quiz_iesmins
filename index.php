<?php
include 'db.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user = $_POST['username'];
    $pass = password_hash($_POST['password'], PASSWORD_DEFAULT);
    
    if (isset($_POST['register'])) {
        $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
        $stmt->bind_param("ss", $user, $pass);
        $stmt->execute();
        $user_id = $conn->insert_id;
        $_SESSION['user_id'] = $user_id;
        $_SESSION['role'] = 'user';
        $_SESSION['username'] = $user;
        header("Location: topics.php");
    } else {
        $stmt = $conn->prepare("SELECT id, password, role FROM users WHERE username = ?");
        $stmt->bind_param("s", $user);
        $stmt->execute();
        $res = $stmt->get_result()->fetch_assoc();
        if ($res && password_verify($_POST['password'], $res['password'])) {
            $_SESSION['user_id'] = $res['id'];
            $_SESSION['role'] = $res['role'];
            $_SESSION['username'] = $user;
            header("Location: topics.php");
        }
    }
}
?>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="style.css"></head>
<body>
<div class="container">
    <h2>Autorizācija</h2>
    <form method="POST">
        <input type="text" name="username" placeholder="Lietotājvārds" required>
        <input type="password" name="password" placeholder="Parole" required>
        <button type="submit" name="login">Ienākt</button>
        <button type="submit" name="register" style="background:#007bff">Reģistrēties</button>
    </form>
</div>
</body>
</html>