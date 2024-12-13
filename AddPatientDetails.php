<?php
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

if (isset($request_data['patientName']) && !empty($request_data['patientName']) && 
    isset($request_data['patientId']) && !empty($request_data['patientId']) && 
    isset($request_data['age']) && !empty($request_data['age']) && 
    isset($request_data['sex']) && !empty($request_data['sex'])) {
    
    $patientName = $request_data['patientName'];
    $patientId = $request_data['patientId'];
    $age = $request_data['age'];
    $sex = $request_data['sex'];

    // Insert new patient details into the database
    $sql = "INSERT INTO patients (patientName, patientId, age, sex) VALUES (:patientName, :patientId, :age, :sex)";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':patientName', $patientName, PDO::PARAM_STR);
    $stmt->bindParam(':patientId', $patientId, PDO::PARAM_STR);
    $stmt->bindParam(':age', $age, PDO::PARAM_INT);
    $stmt->bindParam(':sex', $sex, PDO::PARAM_STR);
    if ($stmt->execute()) {
        $response['status'] = "success";
        $response['message'] = "Patient details added successfully!";
    } else {
        $response['status'] = "error";
        $response['message'] = "Failed to add patient details. Please try again.";
    }

    $stmt->closeCursor();
} else {
    $response['status'] = "error";
    $response['message'] = "Please provide all required fields";
}

$conn = null;

echo json_encode($response);
?>
