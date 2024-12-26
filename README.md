# Project README

## Overview
This Flutter application is a multi-module project designed to provide advanced functionalities such as speech recognition, voice chat, and dynamic content rendering. The application focuses on creating an interactive user experience by integrating voice-based tasks and learning modules.

## Technologies and Libraries Used
- **Flutter**: Framework for building the application. (Version 3.24.5)
- **Dart**: Programming language for Flutter.
- **Audio Libraries**:
  - `flutter_audio_capture`: Capturing real-time audio.
  - `fftea`: Performing Fast Fourier Transform (FFT) for frequency analysis.
  - `record`: Managing audio recording.
  - `flutter_tts`: Text-to-speech functionality.
  - `speech_to_text`: Speech recognition.
- **State Management**: Using Riverpod for efficient state management.
- **Routing**: Flutter Navigator for handling routes.

## Project Structure
The project is organized into the following key directories:

- **`lib/app.dart`**: Main application entry point.
- **`lib/src`**: Contains features like speech recognition and voice chat.
- **`lib/models`**: Data models for managing app data.
- **`lib/providers`**: Riverpod providers for state management.
- **`lib/repositories`**: Handles data fetching and backend interactions.
- **`lib/services`**: Contains core services, including audio and speech processing.
- **`lib/widgets`**: Custom UI components.

## Setup and Installation

### Prerequisites
- Flutter SDK installed ([installation guide](https://flutter.dev/docs/get-started/install)).
- Dart SDK (comes with Flutter).
- Android Studio or VS Code for development.
- Emulator or physical device for testing.

### Installation Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/samtuga1/prodigal
   ```

2. Navigate to the project directory:
   ```bash
   cd prodigal
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Unzip the cfg.zip and place the cfg folder inside the assets folder.

5. Run build runner:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

6. Run the app:
   - For development mode:
     ```bash
     flutter run -t lib/main_dev.dart
     ```
   - For production mode:
     ```bash
     flutter run -t lib/main_prod.dart
     ```

## Features

### Speech Module
- **Real-time Speech Recognition**: Converts spoken words into text.
- **Text-to-Speech Integration**: Reads out text input by the user.
- **Visualization**: Provides frequency spectrum visualizations.
  
NB: Android now has an issue with the speech to text, where it is unable to recognize the speech.
    This is a very common issue that exists in most androids. I will be able to solve the issue if I look into it critically with time.

### Voice Chat Module
- **Live Audio Streaming**: Facilitates real-time voice communication.
- **Audio Processing**: Captures and analyzes audio for advanced tasks.

### Task Module
- **Dynamic Rendering**: Fetches and displays tasks (text, image, audio-based) from backend data.
- **Interactive UI**: Engages users with real-time feedback.

## Assumptions and Decisions
- **Voice Features**: The app assumes device permissions for microphone and storage are granted.
- **Backend Integration**: Currently uses mock APIs or predefined JSON for testing.
- **Audio Sample Rate**: Fixed at 44000 Hz for optimal performance.
