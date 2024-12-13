<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require "Database.php"; // Ensure this file contains proper database connection code

// Get the raw POST data as a string
$json_data = file_get_contents("php://input");

// Decode the JSON data into an associative array
$request_data = json_decode($json_data, true);

$response = [];

if (isset($request_data['username']) && !empty($request_data['username']) && 
    isset($request_data['email']) && !empty($request_data['email']) && 
    isset($request_data['password']) && !empty($request_data['password']) &&
    isset($request_data['confirmPassword']) && !empty($request_data['confirmPassword'])) {
    
    $username = $request_data['username'];
    $email = $request_data['email'];
    $password = $request_data['password'];
    $confirmPassword = $request_data['confirmPassword'];

    if ($password !== $confirmPassword) {
        $response['status'] = "error";
        $response['message'] = "Passwords do not match";
    } else {
        // Check if the username or email already exists
        $sql = "SELECT * FROM register WHERE username = :username OR email = :email";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':username', $username, PDO::PARAM_STR);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();
        $existingUser = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($existingUser) {
            $response['status'] = "error";
            $response['message'] = "Username or email already exists";
        } else {
            // Hash the password before storing
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

            // Insert new user into the database
            $sql = "INSERT INTO register (username, email, password) VALUES (:username, :email, :password)";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':username', $username, PDO::PARAM_STR);
            $stmt->bindParam(':email', $email, PDO::PARAM_STR);
            $stmt->bindParam(':password', $hashedPassword, PDO::PARAM_STR);
            if ($stmt->execute()) {
                $response['status'] = "success";
                $response['message'] = "Registration successful!";
            } else {
                $response['status'] = "error";
                $response['message'] = "Failed to register user. Please try again.";
            }
        }

        $stmt->closeCursor();
    }
} else {
    $response['status'] = "error";
    $response['message'] = "Please provide username, email, password, and confirm password";
}

$conn = null;

echo json_encode($response);
?>
