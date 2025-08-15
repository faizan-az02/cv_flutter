# Flutter + Flask Demo App

A simple demo application showcasing how to integrate a Flutter frontend with a Flask backend. The app demonstrates basic API communication between a mobile app and a local web server.

## Features

- **Flutter Frontend**: Clean Material Design UI with state management
- **Flask Backend**: Simple REST API with CORS support
- **Cross-Platform**: Works on Android, iOS, web, and desktop
- **Network Communication**: Real HTTP requests between frontend and backend
- **Error Handling**: Graceful handling of network errors and loading states

## Running the Application

### Step 1: Start the Flask Backend
```bash
cd backend
python app.py
```

You should see output like:
```
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://192.168.100.9:5000
```

### Step 2: Run the Flutter App
```bash
flutter run
```

## Configuration

### Network Configuration

The app automatically detects the platform and uses the appropriate IP address:

- **Android Emulator**: `10.0.2.2:5000`
- **Physical Android Device**: `192.168.100.9:5000` (your computer's IP)
- **iOS Simulator**: `127.0.0.1:5000`
- **Web/Desktop**: `127.0.0.1:5000`

### Finding Your Computer's IP Address

For physical device testing, you need to know your computer's IP address:

**Windows:**
```bash
ipconfig
```
Look for your Wi-Fi adapter's IPv4 address.


## API Endpoints

### GET /api/hello
Returns a simple greeting message.

## Code Explanation

### Flask Backend (`backend/app.py`)
- Uses Flask-CORS for cross-origin requests
- `host='0.0.0.0'` allows external connections
- Simple JSON API endpoint

### Flutter API Service (`lib/services/api_service.dart`)
- Handles HTTP requests to Flask backend
- Platform-specific IP address selection
- Error handling for network requests

### Flutter UI (`lib/main.dart`)
- Stateful widget with loading states
- Async/await for non-blocking API calls
- Error handling and user feedback

## History:
-Everything I went through to get to the final CV, Flutter, Flask milestone.

### Initial Commit:
- Simple Flutter Page
- Flask API - Sending a json format message upon pressing the button, displaying it on screen. 

### Second Phase:
- Improved UI
- Flask API - Gets data upon request, shows it on screen, handles edge cases i.e. API not running, timeouts etc. UI responds accordingly.