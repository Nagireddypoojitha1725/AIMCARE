<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

require "Database.php"; // Ensure this file contains proper database connection code

$response = [];

try {
    // Fetch all patient details from the database
    $sql = "SELECT * FROM patients";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    
    $patients = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if ($patients) {
        $response['status'] = "success";
        $response['patients'] = $patients;
    } else {
        $response['status'] = "error";
        $response['message'] = "No patient details found.";
    }

    $stmt->closeCursor();
} catch (Exception $e) {
    $response['status'] = "error";
    $response['message'] = "An error occurred: " . $e->getMessage();
}

$conn = null;

echo json_encode($response);
?>
