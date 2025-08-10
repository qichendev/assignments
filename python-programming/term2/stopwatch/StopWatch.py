"""
Stopwatch Application
Name: [Your Name]
CNumber: [Your CNumber]

A Python Tkinter application that displays current date/time and provides
stopwatch functionality with start, stop, pause, and reset controls.
"""

import tkinter as tk
from tkinter import ttk
import time
from datetime import datetime

class StopwatchApp:
    def __init__(self, root):
        """
        Initialize the stopwatch application with GUI components
        """
        self.root = root
        self.root.title("Stopwatch Application")
        self.root.geometry("600x400")
        self.root.resizable(True, True)
        
        # Stopwatch variables
        self.running = False
        self.paused = False
        self.start_time = 0
        self.pause_time = 0
        self.elapsed_time = 0
        
        # Configure grid weights for responsive layout
        self.root.grid_rowconfigure(0, weight=1)
        self.root.grid_rowconfigure(1, weight=2)
        self.root.grid_rowconfigure(2, weight=1)
        self.root.grid_columnconfigure(0, weight=1)
        
        self.create_widgets()
        self.update_current_time()
    
    def create_widgets(self):
        """
        Create and configure all GUI widgets
        """
        # Top panel - Current Date and Time
        self.time_frame = tk.Frame(self.root, bg="#E6F3FF", relief="raised", bd=2)
        self.time_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=5)
        self.time_frame.grid_columnconfigure(0, weight=1)
        
        # Current time label
        self.time_label = tk.Label(
            self.time_frame,
            text="",
            font=("Arial", 16, "bold"),
            bg="#E6F3FF",
            fg="#2C3E50"
        )
        self.time_label.grid(row=0, column=0, pady=20)
        
        # Middle panel - Stopwatch
        self.stopwatch_frame = tk.Frame(self.root, bg="#E8F5E8", relief="raised", bd=2)
        self.stopwatch_frame.grid(row=1, column=0, sticky="nsew", padx=10, pady=5)
        self.stopwatch_frame.grid_columnconfigure(0, weight=1)
        
        # Stopwatch label
        self.stopwatch_label = tk.Label(
            self.stopwatch_frame,
            text="00:00:00",
            font=("Arial", 36, "bold"),
            bg="#E8F5E8",
            fg="#E74C3C"
        )
        self.stopwatch_label.grid(row=0, column=0, pady=40)
        
        # Bottom panel - Control Buttons
        self.button_frame = tk.Frame(self.root, bg="#F8F9FA", relief="raised", bd=2)
        self.button_frame.grid(row=2, column=0, sticky="nsew", padx=10, pady=5)
        self.button_frame.grid_columnconfigure((0,1,2,3), weight=1)
        
        # Create control buttons with distinct colors and styles
        self.create_buttons()
    
    def create_buttons(self):
        """
        Create and configure control buttons with different colors and styles
        """
        # Start button (Green)
        self.start_button = tk.Button(
            self.button_frame,
            text="Start",
            font=("Arial", 12, "bold"),
            bg="#27AE60",
            fg="white",
            relief="raised",
            bd=3,
            command=self.start_stopwatch,
            width=10,
            height=2
        )
        self.start_button.grid(row=0, column=0, padx=5, pady=10)
        
        # Stop button (Red)
        self.stop_button = tk.Button(
            self.button_frame,
            text="Stop",
            font=("Arial", 12, "bold"),
            bg="#E74C3C",
            fg="white",
            relief="raised",
            bd=3,
            command=self.stop_stopwatch,
            width=10,
            height=2
        )
        self.stop_button.grid(row=0, column=1, padx=5, pady=10)
        
        # Pause button (Yellow)
        self.pause_button = tk.Button(
            self.button_frame,
            text="Pause",
            font=("Arial", 12, "bold"),
            bg="#F39C12",
            fg="white",
            relief="raised",
            bd=3,
            command=self.pause_stopwatch,
            width=10,
            height=2
        )
        self.pause_button.grid(row=0, column=2, padx=5, pady=10)
        
        # Reset button (Orange)
        self.reset_button = tk.Button(
            self.button_frame,
            text="Reset",
            font=("Arial", 12, "bold"),
            bg="#E67E22",
            fg="white",
            relief="raised",
            bd=3,
            command=self.reset_stopwatch,
            width=10,
            height=2
        )
        self.reset_button.grid(row=0, column=3, padx=5, pady=10)
    
    def update_current_time(self):
        """
        Update the current date and time display every second
        """
        current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.time_label.config(text=current_time)
        self.root.after(1000, self.update_current_time)
    
    def start_stopwatch(self):
        """
        Start or resume the stopwatch
        """
        if not self.running:
            if not self.paused:
                # Starting fresh
                self.start_time = time.time()
                self.elapsed_time = 0
            else:
                # Resuming from pause
                self.start_time = time.time() - self.pause_time
                self.paused = False
            
            self.running = True
            self.update_stopwatch()
    
    def stop_stopwatch(self):
        """
        Stop the stopwatch and reset to zero
        """
        self.running = False
        self.paused = False
        self.elapsed_time = 0
        self.stopwatch_label.config(text="00:00:00")
    
    def pause_stopwatch(self):
        """
        Pause the stopwatch
        """
        if self.running and not self.paused:
            self.paused = True
            self.running = False
            self.pause_time = time.time() - self.start_time
    
    def reset_stopwatch(self):
        """
        Reset the stopwatch to zero
        """
        self.running = False
        self.paused = False
        self.elapsed_time = 0
        self.stopwatch_label.config(text="00:00:00")
    
    def update_stopwatch(self):
        """
        Update the stopwatch display
        """
        if self.running:
            current_time = time.time()
            self.elapsed_time = current_time - self.start_time
            
            # Convert elapsed time to hours, minutes, seconds
            hours = int(self.elapsed_time // 3600)
            minutes = int((self.elapsed_time % 3600) // 60)
            seconds = int(self.elapsed_time % 60)
            
            # Format time display
            time_string = f"{hours:02d}:{minutes:02d}:{seconds:02d}"
            self.stopwatch_label.config(text=time_string)
            
            # Schedule next update
            self.root.after(10, self.update_stopwatch)

def main():
    """
    Main function to create and run the stopwatch application
    """
    root = tk.Tk()
    app = StopwatchApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()
