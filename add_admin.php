<?php
include 'db.php';

// Insert admin user
$username = 'Rukitis';
$password = password_hash('Admin321', PASSWORD_DEFAULT); // Hash the password
$role = 'admin';

$stmt = $conn->prepare("INSERT INTO users (username, password, role) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE password = VALUES(password), role = VALUES(role)");
$stmt->bind_param("sss", $username, $password, $role);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    echo "Admin user added/updated successfully.";
} else {
    echo "Error adding admin user.";
}

$stmt->close();
$conn->close();
?>