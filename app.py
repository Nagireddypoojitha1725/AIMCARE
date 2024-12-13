from flask import Flask, request, jsonify
from keras.models import load_model
from PIL import Image, ImageOps
import numpy as np
import logging
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Set up logging
logging.basicConfig(level=logging.INFO)

# Load the model
model = load_model("model.h5", compile=False)

# Function to process the image and return the prediction
def process_image(image):
    size = (224, 224)  # Resize the image to fit the model input size
    image = ImageOps.fit(image, size, Image.Resampling.LANCZOS)
    image_array = np.asarray(image)
    normalized_image_array = (image_array.astype(np.float32) / 127.5) - 1

    # Prepare the data for prediction
    data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)
    data[0] = normalized_image_array

    # Perform prediction
    prediction = model.predict(data)
    logging.info(f"Prediction probabilities: {prediction}")  # Log the prediction probabilities

    # Apply your custom logic for normal/abnormal classification
    if prediction[0][0] > 0.3:
        result = "Normal"
    else:
        result = "Alzheimer’s Disease"

    return result, prediction  # Return both the result and the prediction

# Route to handle image prediction requests
@app.route("/predict", methods=["POST"])
def predict():
    if "image" not in request.files:
        logging.error("No image uploaded")
        return jsonify({"error": "No image uploaded"}), 400
    # Load the image from the request
    image = request.files["image"]

    try:
        # Check if the file is an image
        img = Image.open(image.stream).convert("RGB")

    except Exception as e:
        logging.error(f"Error opening image: {e}")
        return jsonify({"error": "Invalid image format"}), 400

    # Get the prediction result (normal or abnormal) and prediction probabilities
    result, prediction = process_image(img)
    confidence_score = float(prediction[0][0])  # Extract confidence score

    # Sending data to PHP backend to store it in the database
    files = {'image': image.stream}
    data = {
        'class_name': result,
        'confidence_score': confidence_score
    }
    php_response = requests.post('http://180.235.121.245/Alzeihmersdisease/upload_image.php', files=files, data=data)

    if php_response.status_code == 200:
        return jsonify({
            "class_name": result,
            "confidence_score": confidence_score,
            "db_response": php_response.json()  # Response from PHP
        })
    else:
        return jsonify({"error": "Failed to save prediction to the database"}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5004)