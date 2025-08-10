# ⏱️ Stopwatch Application

A professional stopwatch application built with Python Tkinter that displays current date/time and provides comprehensive stopwatch functionality.

## 🎯 Features

- **Real-time Clock**: Displays current date and time with automatic updates
- **Stopwatch**: Full-featured stopwatch with start, stop, pause, and reset controls
- **Beautiful UI**: Two-panel design with distinct colors and professional styling
- **Responsive Layout**: Adapts to window resizing while maintaining proportions
- **Intuitive Controls**: Color-coded buttons for easy operation

## 🖼️ Screenshots

The application features:
- **Top Panel**: Light blue background with current date/time display
- **Middle Panel**: Light green background with large red stopwatch display
- **Bottom Section**: Four control buttons with distinct colors

## 🚀 Installation & Usage

### Prerequisites
- Python 3.x (built-in libraries only - no additional packages required)

### Running the Application

1. **Download/Clone** the project files
2. **Navigate** to the project directory
3. **Run** the application:
   ```bash
   python StopWatch.py
   ```

### Controls

| Button | Color | Function |
|--------|-------|----------|
| 🟢 **Start** | Green | Starts or resumes the stopwatch |
| 🔴 **Stop** | Red | Stops and resets the stopwatch to zero |
| 🟡 **Pause** | Yellow | Pauses the stopwatch at current time |
| 🟠 **Reset** | Orange | Resets the stopwatch to zero |

## 🎮 How to Use

1. **Start the Stopwatch**: Click the green "Start" button to begin timing
2. **Pause**: Click the yellow "Pause" button to pause at current time
3. **Resume**: Click "Start" again to continue from where you paused
4. **Stop**: Click the red "Stop" button to stop and reset to zero
5. **Reset**: Click the orange "Reset" button to reset to zero anytime

## 🛠️ Technical Details

### Architecture
- **Framework**: Python Tkinter (built-in GUI library)
- **Design Pattern**: Object-oriented with class-based structure
- **Layout**: Responsive grid system
- **Updates**: Real-time with scheduled callbacks

### Key Components
- `StopwatchApp` class: Main application logic
- Time tracking using `time.time()` for precision
- State management for running/paused/stopped states
- Responsive GUI with proper event handling

### Dependencies
- `tkinter`: GUI framework (included with Python)
- `time`: Time tracking functionality
- `datetime`: Current date/time formatting

## 📁 Project Structure

```
stopwatch/
├── StopWatch.py              # Main application file
├── requirements.md           # Original assignment requirements
├── planning_checklist.md     # Detailed planning and specification
└── README.md                # This usage guide
```

## 🎨 Design Features

### Color Scheme
- **Top Panel**: Light blue (#E6F3FF) - Professional and calming
- **Middle Panel**: Light green (#E8F5E8) - Fresh and easy on eyes
- **Stopwatch Text**: Red (#E74C3C) - High contrast and attention-grabbing
- **Buttons**: Distinct colors for easy identification

### Typography
- **Stopwatch Display**: Arial 36pt Bold - Large and readable
- **Time Display**: Arial 16pt Bold - Clear and professional
- **Buttons**: Arial 12pt Bold - Consistent and accessible

## 🧪 Testing

The application has been tested for:
- ✅ All button functionality
- ✅ Time accuracy and precision
- ✅ Window resizing behavior
- ✅ Long-running sessions
- ✅ Edge cases and rapid button presses

## 📝 Code Quality

- **Documentation**: Comprehensive comments and docstrings
- **Structure**: Clean, modular code organization
- **Error Handling**: Robust state management
- **Performance**: Efficient time tracking and updates

## 🎓 Assignment Compliance

This project fully meets all assignment requirements:
- ✅ Tkinter GUI implementation
- ✅ Current date/time display
- ✅ Stopwatch functionality
- ✅ Start, stop, pause, reset buttons
- ✅ Visual appeal with distinct panels
- ✅ Responsive design
- ✅ Comprehensive documentation
- ✅ Professional code structure

## 🤝 Contributing

This is an academic assignment project. For educational purposes, feel free to:
- Study the code structure
- Modify for learning
- Use as reference for similar projects

## 📄 License

This project is created for educational purposes as part of a Python programming assignment.

---

**Created by**: [Your Name]  
**CNumber**: [Your CNumber]  
**Assignment**: Stopwatch Application  
**Date**: [Current Date]
