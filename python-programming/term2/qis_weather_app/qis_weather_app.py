"""
Qis Weather App
Name: Qi Chen
CNumber: c0944666

A desktop weather application that displays current weather conditions,
forecast, date, and time with automatic updates.
"""

import sys
import os
import json
import requests
from datetime import datetime
from collections import defaultdict

from PySide6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QLabel,
    QVBoxLayout, QHBoxLayout, QFrame, QMessageBox
)
from PySide6.QtCore import Qt, QTimer
from PySide6.QtGui import QFont, QFontDatabase

# --- Configuration Management ---
def load_config():
    """Load configuration from JSON file with fallback to defaults."""
    config_file = "config.json"
    
    default_config = {
        "city": "Sarnia",
        "state_code": "ON", 
        "country_code": "CA",
        "update_interval_minutes": 5,
        "api_key": "52931dfa0c8cd00b48d905c2950665c2"
    }
    
    if os.path.exists(config_file):
        try:
            with open(config_file, 'r', encoding='utf-8') as f:
                config = json.load(f)
                if config:
                    return {**default_config, **config}
        except Exception as e:
            print(f"Error loading {config_file}: {e}")
    
    print("No valid configuration file found, using defaults")
    return default_config

# Load configuration
CONFIG = load_config()
API_KEY = CONFIG["api_key"]
CITY = CONFIG["city"]
STATE_CODE = CONFIG["state_code"]
COUNTRY_CODE = CONFIG["country_code"]
UPDATE_INTERVAL_MINUTES = CONFIG["update_interval_minutes"]
BASE_URL = "http://api.openweathermap.org/data/2.5/"

def celsius_to_fahrenheit(celsius):
    """Convert Celsius temperature to Fahrenheit."""
    return (celsius * 9/5) + 32

def get_weather_icon_emoji(icon_code):
    """Maps OpenWeatherMap icon codes to emojis."""
    mapping = {
        "01d": "☀️", "01n": "🌙",
        "02d": "🌤️", "02n": "☁️",
        "03d": "☁️", "03n": "☁️",
        "04d": "☁️", "04n": "☁️",
        "09d": "🌧️", "09n": "🌧️",
        "10d": "🌦️", "10n": "🌧️",
        "11d": "⛈️", "11n": "⛈️",
        "13d": "❄️", "13n": "❄️",
        "50d": "🌫️", "50n": "🌫️",
    }
    return mapping.get(icon_code, "❓")

def fetch_weather_data(city_query, api_key):
    """Fetches and processes weather data from OpenWeatherMap."""
    params = {"q": city_query, "appid": api_key, "units": "metric"}

    try:
        # Fetch current weather
        response_current = requests.get(f"{BASE_URL}weather", params=params)
        response_current.raise_for_status()
        current_data = response_current.json()

        # Fetch 5-day forecast
        response_forecast = requests.get(f"{BASE_URL}forecast", params=params)
        response_forecast.raise_for_status()
        forecast_data = response_forecast.json()

        # Process current weather with both Celsius and Fahrenheit
        current_temp_c = current_data['main']['temp']
        current_temp_f = celsius_to_fahrenheit(current_temp_c)
        
        processed_data = {
            "CITY": f"{current_data['name']}, {STATE_CODE}",
            "DATE": datetime.now().strftime("%A, %d %B %Y"),
            "CURRENT_TEMP_C": int(round(current_temp_c)),
            "CURRENT_TEMP_F": int(round(current_temp_f)),
            "CONDITION": current_data['weather'][0]['description'].title(),
            "ICON": get_weather_icon_emoji(current_data['weather'][0]['icon']),
            "DETAILS": [
                (f"{int(round(current_data['main']['feels_like']))}°C", "Feels Like", "🌡️"),
                (f"{int(round(celsius_to_fahrenheit(current_data['main']['feels_like'])))}°F", "Feels Like", "🌡️"),
                (f"{current_data['main']['humidity']}%", "Humidity", "💧"),
                (f"{int(round(current_data['wind']['speed'] * 3.6))} km/h", "Wind", "💨"),
                (f"{current_data['main']['pressure']} hPa", "Pressure", "📊"),
                (f"{current_data.get('visibility', 10000) / 1000:.1f} km", "Visibility", "👁️")
            ]
        }

        # Process forecast data with both temperature scales
        daily_forecasts = defaultdict(lambda: {'temps': [], 'icons': []})
        for item in forecast_data['list']:
            date = datetime.fromtimestamp(item['dt']).date()
            daily_forecasts[date]['temps'].append(item['main']['temp'])
            daily_forecasts[date]['icons'].append(item['weather'][0]['icon'])

        forecast_list = []
        today = datetime.now().date()

        for i, (date, data) in enumerate(daily_forecasts.items()):
            day_name = "Today" if date == today else date.strftime("%A")

            midday_icons = [
                item['weather'][0]['icon']
                for item in forecast_data['list']
                if datetime.fromtimestamp(item['dt']).date() == date and "12:00:00" in item['dt_txt']
            ]
            icon = get_weather_icon_emoji(midday_icons[0] if midday_icons else max(set(data['icons']), key=data['icons'].count))

            # Add both Celsius and Fahrenheit for forecast
            max_temp_c = max(data['temps'])
            min_temp_c = min(data['temps'])
            max_temp_f = celsius_to_fahrenheit(max_temp_c)
            min_temp_f = celsius_to_fahrenheit(min_temp_c)

            forecast_list.append({
                "day": day_name,
                "icon": icon,
                "temp_c": f"{int(round(max_temp_c))}° / {int(round(min_temp_c))}°",
                "temp_f": f"{int(round(max_temp_f))}° / {int(round(min_temp_f))}°",
                "is_today": date == today,
            })
            if len(forecast_list) >= 7:
                break

        processed_data["FORECAST"] = forecast_list
        return processed_data

    except requests.exceptions.RequestException as e:
        print(f"Error fetching data: {e}")
        return None
    except KeyError as e:
        print(f"Error parsing data, unexpected format: {e}")
        return None


# --- Qis Weather App ---
class QisWeatherApp(QMainWindow):
    def __init__(self, weather_data):
        super().__init__()
        self.weather_data = weather_data
        self.update_interval_seconds = UPDATE_INTERVAL_MINUTES * 60  # Convert minutes to seconds

        if not self.weather_data:
            QMessageBox.critical(self, "Error", "Could not fetch weather data.\nPlease check your internet connection and API key.")
            return

        self.setWindowTitle("Qis Weather App")
        self.setGeometry(100, 100, 1300, 750)
        self.setMinimumSize(1000, 650)
        
        self.time_left = self.update_interval_seconds

        self.setup_fonts()
        self.setup_ui()
        
        self.setup_timers()

    def setup_fonts(self):
        """Initialize custom fonts for the application."""
        font_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "fonts/Inter-Regular.ttf")
        if os.path.exists(font_path):
            font_id = QFontDatabase.addApplicationFont(font_path)
            if font_id != -1:
                font_family = QFontDatabase.applicationFontFamilies(font_id)[0]
                self.default_font = QFont(font_family, 10)
            else:
                self.default_font = QFont("Segoe UI", 10)
        else:
            self.default_font = QFont("Segoe UI", 10)
        self.setFont(self.default_font)

    def setup_ui(self):
        """Initialize the main user interface."""
        container = QWidget()
        self.setCentralWidget(container)
        self.main_layout = QHBoxLayout(container)
        self.main_layout.setSpacing(25)
        self.main_layout.setContentsMargins(25, 25, 25, 25)
        self.setStyleSheet("""
            QMainWindow { background-color: #000000; }
            QLabel { color: #ffffff; background: transparent; }
            QWidget { background: transparent; }
        """)
        self.create_layout()
        
    def setup_timers(self):
        """Initializes and starts the update and countdown timers."""
        # Main timer to fetch new weather data
        self.update_timer = QTimer(self)
        self.update_timer.timeout.connect(self.update_weather_data)
        self.update_timer.start(self.update_interval_seconds * 1000)

        # UI timer to update the countdown label every second
        self.countdown_timer = QTimer(self)
        self.countdown_timer.timeout.connect(self.update_countdown_display)
        self.countdown_timer.start(1000) # 1-second interval

    def update_weather_data(self):
        """Fetches new weather data and triggers a UI refresh."""
        print("Fetching new weather data...")
        location_query = f"{CITY},{STATE_CODE},{COUNTRY_CODE}"
        new_data = fetch_weather_data(location_query, API_KEY)
        
        if new_data:
            self.weather_data = new_data
            self.refresh_ui()
            self.time_left = self.update_interval_seconds  # Reset countdown
            self.update_countdown_display() # Immediately show "Updated" message
        else:
            self.footer_label.setText("Update failed. Retrying...")
            self.time_left = 60 # Retry in 1 minute on failure

    def update_countdown_display(self):
        """Updates the footer label with the time remaining until the next update."""
        if self.time_left > 0:
            minutes = self.time_left // 60
            seconds = self.time_left % 60
            # Set initial text differently
            if self.time_left == self.update_interval_seconds:
                 self.footer_label.setText("Updated just now")
            else:
                self.footer_label.setText(f"Updating in {minutes}:{seconds:02d}")
            self.time_left -= 1
        else:
            self.footer_label.setText("Updating now...")
            
    def refresh_ui(self):
        """Removes old widgets and creates new ones with updated data."""
        # Remove and delete old widgets to prevent memory leaks
        self.main_layout.removeWidget(self.main_weather_card)
        self.main_weather_card.deleteLater()
        self.main_layout.removeWidget(self.forecast_card)
        self.forecast_card.deleteLater()
        
        # Re-create and add the new widgets
        self.main_weather_card = self.create_main_weather_card(self.weather_data)
        self.forecast_card = self.create_forecast_card(self.weather_data["FORECAST"])
        
        self.main_layout.addWidget(self.main_weather_card, 7)
        self.main_layout.addWidget(self.forecast_card, 3)

    def create_layout(self):
        """Create the main layout with weather and forecast cards."""
        # Assign created cards to instance variables for later access
        self.main_weather_card = self.create_main_weather_card(self.weather_data)
        self.forecast_card = self.create_forecast_card(self.weather_data["FORECAST"])
        
        self.main_layout.addWidget(self.main_weather_card, 7)
        self.main_layout.addWidget(self.forecast_card, 3)
    
    def create_main_weather_card(self, data):
        """Create the main weather display card."""
        card = QWidget()
        
        layout = QVBoxLayout(card)
        layout.setSpacing(30)
        layout.setContentsMargins(45, 45, 45, 45)
        
        layout.addLayout(self.create_header_section(data["CITY"], data["DATE"]))
        layout.addLayout(self.create_main_temp_section(data["CURRENT_TEMP_C"], data["CURRENT_TEMP_F"], data["CONDITION"], data["ICON"]))
        layout.addWidget(self.create_divider())
        layout.addLayout(self.create_details_section(data["DETAILS"]))
        layout.addStretch(1)
        layout.addWidget(self.create_footer())
        
        return card
    
    def create_header_section(self, city_name, date_str):
        """Create the header section with city and date."""
        header_layout = QHBoxLayout()
        location_layout = QVBoxLayout()
        
        city = QLabel(city_name)
        city.setFont(QFont(self.default_font.family(), 32, QFont.Bold))
        
        date = QLabel(date_str)
        date.setFont(QFont(self.default_font.family(), 13, QFont.Medium))
        
        location_layout.addWidget(city)
        location_layout.addWidget(date)
        
        # location icon
        geo_icon = QLabel("📍")
        geo_icon.setFont(QFont(self.default_font.family(), 24))
        geo_icon.setAlignment(Qt.AlignCenter)
        
        header_layout.addLayout(location_layout)
        header_layout.addStretch()
        header_layout.addWidget(geo_icon)
        
        return header_layout
    
    def create_main_temp_section(self, temp_c, temp_f, condition_str, icon_str):
        """Create the main temperature display section with both Celsius and Fahrenheit."""
        main_temp_layout = QHBoxLayout()
        
        # Weather icon
        weather_icon = QLabel(icon_str)
        weather_icon.setFont(QFont(self.default_font.family(), 85))
        
        temp_layout = QVBoxLayout()
        
        # Temperature display with both scales
        temperature_c = QLabel(f"{temp_c}°")
        temperature_c.setFont(QFont(self.default_font.family(), 50, QFont.Bold))
        
        temperature_f = QLabel(f"{temp_f}°F")
        temperature_f.setFont(QFont(self.default_font.family(), 36, QFont.Bold))
        
        # Unit labels
        # unit_c = QLabel("Celsius")
        # unit_c.setFont(QFont(self.default_font.family(), 14, QFont.Medium))
        
        # unit_f = QLabel("Fahrenheit")
        # unit_f.setFont(QFont(self.default_font.family(), 14, QFont.Medium))
        
        condition = QLabel(condition_str)
        condition.setFont(QFont(self.default_font.family(), 20, QFont.Medium))
        
        temp_layout.addWidget(temperature_c)
        temp_layout.addWidget(temperature_f)
        # temp_layout.addWidget(unit_c)
        # temp_layout.addWidget(unit_f)
        temp_layout.addSpacing(10)
        temp_layout.addWidget(condition)
        temp_layout.addStretch()
        
        main_temp_layout.addWidget(weather_icon)
        main_temp_layout.addSpacing(30)
        main_temp_layout.addLayout(temp_layout)
        main_temp_layout.addStretch()
        
        return main_temp_layout
    
    def create_divider(self):
        """Create a horizontal divider line."""
        divider = QFrame()
        divider.setFrameShape(QFrame.HLine)
        divider.setFixedHeight(1)
        divider.setStyleSheet("background-color: #ffffff; border: none;")
        return divider
    
    def create_details_section(self, details_data):
        """Create the weather details section."""
        details_layout = QHBoxLayout()
        details_layout.setSpacing(20)
        
        for value, name, icon in details_data:
            details_layout.addWidget(self.create_detail_item(value, name, icon))
        
        return details_layout
    
    def create_detail_item(self, value, name, icon):
        """Create an individual detail item widget."""
        widget = QWidget()
        
        layout = QVBoxLayout(widget)
        layout.setContentsMargins(15, 15, 15, 15)
        layout.setSpacing(8)
        
        # Icon
        icon_label = QLabel(icon)
        icon_label.setFont(QFont(self.default_font.family(), 18))
        icon_label.setAlignment(Qt.AlignCenter)
        
        # Value
        value_label = QLabel(value)
        value_label.setFont(QFont(self.default_font.family(), 14, QFont.Bold))
        value_label.setAlignment(Qt.AlignCenter)
        
        # Name
        name_label = QLabel(name)
        name_label.setFont(QFont(self.default_font.family(), 10))
        name_label.setAlignment(Qt.AlignCenter)
        
        layout.addWidget(icon_label)
        layout.addWidget(value_label)
        layout.addWidget(name_label)
        
        return widget
    
    def create_footer(self):
        """Create the footer with update information."""
        footer_widget = QWidget()
        footer_layout = QHBoxLayout(footer_widget)
        
        update_icon = QLabel("🔄")
        update_icon.setFont(QFont(self.default_font.family(), 12))
        
        # Change footer_text to be an instance variable self.footer_label
        self.footer_label = QLabel()
        self.footer_label.setFont(QFont(self.default_font.family(), 10))
        self.update_countdown_display() # Set its initial text
        
        footer_layout.addWidget(update_icon)
        footer_layout.addWidget(self.footer_label)
        footer_layout.addStretch()
        
        return footer_widget
    
    def create_forecast_card(self, forecast_data):
        """Create the weekly forecast card."""
        card = QWidget()
        
        layout = QVBoxLayout(card)
        layout.setSpacing(18)
        layout.setContentsMargins(25, 25, 25, 25)
        
        title_layout = QHBoxLayout()
        title_icon = QLabel("📅")
        title_icon.setFont(QFont(self.default_font.family(), 20))
        
        title = QLabel("Weekly Forecast")
        title.setFont(QFont(self.default_font.family(), 20, QFont.Bold))
        
        title_layout.addWidget(title_icon)
        title_layout.addWidget(title)
        title_layout.addStretch()
        
        layout.addLayout(title_layout)
        
        for item_data in forecast_data:
            forecast_item = self.create_forecast_item(
                item_data["day"], item_data["icon"], item_data["temp_c"], item_data["temp_f"], item_data["is_today"]
            )
            layout.addWidget(forecast_item)
        
        layout.addStretch()
        return card
    
    def create_forecast_item(self, day, icon, temp_c, temp_f, is_today=False):
        """Create an individual forecast item with both temperature scales."""
        item = QWidget()
        item.setFixedHeight(80)  # Increased height to accommodate both temperatures
        
        layout = QHBoxLayout(item)
        layout.setContentsMargins(20, 15, 20, 15)
        
        font_weight = QFont.Bold if is_today else QFont.Medium
        font_size = 13 if is_today else 12
        
        day_label = QLabel(day)
        day_label.setFont(QFont(self.default_font.family(), font_size, font_weight))
        
        icon_label = QLabel(icon)
        icon_label.setFont(QFont(self.default_font.family(), 24))
        icon_label.setAlignment(Qt.AlignCenter)
        
        # Temperature layout for both scales
        temp_layout = QVBoxLayout()
        temp_c_label = QLabel(temp_c)
        temp_c_label.setFont(QFont(self.default_font.family(), 12, QFont.Medium))
        temp_c_label.setAlignment(Qt.AlignRight | Qt.AlignVCenter)
        
        temp_f_label = QLabel(temp_f)
        temp_f_label.setFont(QFont(self.default_font.family(), 10, QFont.Medium))
        temp_f_label.setAlignment(Qt.AlignRight | Qt.AlignVCenter)
        
        temp_layout.addWidget(temp_c_label)
        temp_layout.addWidget(temp_f_label)
        
        layout.addWidget(day_label, 3)
        layout.addWidget(icon_label, 2)
        layout.addLayout(temp_layout, 3)
        
        return item

if __name__ == "__main__":
    app = QApplication(sys.argv)

    app.setApplicationName("Qis Weather App")
    app.setApplicationVersion("1.0")
    app.setOrganizationName("Weather Qis")

    location_query = f"{CITY},{STATE_CODE},{COUNTRY_CODE}"
    live_weather_data = fetch_weather_data(location_query, API_KEY)

    window = QisWeatherApp(live_weather_data)

    if window.weather_data:
        window.show()
        sys.exit(app.exec())
    else:
        sys.exit(1)