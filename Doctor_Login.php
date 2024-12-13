<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require "Database.php"; // Ensure this file contains proper database connection code

$json_data = file_get_contents("php://input");
$request_data = json_decode($json_data, true);

$response = [];

if (isset($request_data['username']) && !empty($request_data['username']) && 
    isset($request_data['password']) && !empty($request_data['password'])) {
    
    $username = $request_data['username'];
    $password = $request_data['password'];

    $sql = "SELECT * FROM register WHERE username = :username";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':username', $username, PDO::PARAM_STR);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password'])) {
        $response['status'] = "success";
        $response['message'] = "Login successful!";
    } else {
        $response['status'] = "error";
        $response['message'] = "Invalid username or password";
    }

    $stmt->closeCursor();
} else {
    $response['status'] = "error";
    $response['message'] = "Please provide username and password";
}

$conn = null;

// Always send JSON response
echo json_encode($response);
?>
