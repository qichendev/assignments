# Qis Weather App

A desktop weather application built with Python and PySide6 that displays current weather conditions, forecast, date, and time with automatic updates.

## Features

- **Real-time Weather Data**: Fetches current weather from OpenWeather API
- **Dual Temperature Display**: Shows both Celsius and Fahrenheit
- **Weekly Forecast**: 7-day weather forecast with temperature ranges
- **Automatic Updates**: Configurable update intervals (default: 5 minutes)
- **Countdown Timer**: Shows time until next weather update
- **JSON Configuration**: Simple JSON configuration file support
- **Responsive UI**: Modern dark theme with weather icons and emojis

## Requirements

- Python 3.8+
- PySide6
- requests

## Installation

1. Clone or download the project files
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Configuration

The app uses a JSON configuration file. Create `config.json` in the same directory as the main script:

### JSON Format (config.json)
```json
{
  "city": "Toronto",
  "state_code": "ON",
  "country_code": "CA",
  "update_interval_minutes": 10,
  "api_key": "your_api_key_here"
}
```

### Configuration Parameters
- **city**: City name (e.g., "Toronto", "London", "Paris")
- **state_code**: State/province code (e.g., "ON", "CA", "NY")
- **country_code**: Country code (e.g., "CA", "US", "GB")
- **update_interval_minutes**: Weather update frequency in minutes
- **api_key**: Your OpenWeatherMap API key

### Default Values
If no configuration file is found, the app will use these defaults:
- City: Sarnia, ON, CA
- Update interval: 5 minutes
- API key: Demo key (limited functionality)

## Usage

1. **Get an API Key**: Sign up at [OpenWeatherMap](https://openweathermap.org/api) to get a free API key
2. **Configure**: Create `config.json` with your city and API key
3. **Run**: Execute the main script:
   ```bash
   python qis_weather_app.py
   ```

## Features

### Main Display
- Current temperature in both Celsius and Fahrenheit
- Weather condition with descriptive icon
- City name and current date
- Weather details (feels like, humidity, wind, pressure, visibility)

### Forecast Panel
- 7-day weather forecast
- Daily high/low temperatures in both scales
- Weather condition icons
- Today's forecast highlighted

### Update System
- Automatic weather updates at configurable intervals
- Countdown timer showing time until next update
- Manual refresh capability
- Error handling with retry logic

## Customization

### Changing Cities
Edit your `config.json` file to change the city:
- Use the format: "City, State, Country"
- Example: "London, England, GB" or "Paris, France, FR"

### Update Intervals
Modify the `update_interval_minutes` value in your config file:
- Minimum: 1 minute
- Recommended: 5-30 minutes
- Consider API rate limits for free accounts

### API Key
Replace the default API key with your own OpenWeatherMap API key for production use.

## Troubleshooting

### Common Issues

1. **"Could not fetch weather data"**
   - Check your internet connection
   - Verify your API key is correct
   - Ensure the city name is valid

2. **Configuration not loading**
   - Check JSON syntax in config.json
   - Ensure configuration file is in the same directory
   - Verify file permissions

3. **App not starting**
   - Check Python version (3.8+ required)
   - Verify all dependencies are installed
   - Check console for error messages

## API Usage

This app uses the OpenWeatherMap API:
- **Current Weather**: Real-time weather data
- **5-Day Forecast**: Hourly forecast data for the next 5 days
- **Free Tier**: 1000 calls per day (sufficient for personal use)

## Development

### Project Structure
```
qis_weather_app/
├── qis_weather_app.py    # Main application
├── requirements.txt       # Python dependencies
├── config.json           # JSON configuration file
└── README.md             # This file
```

### Code Organization
- **Configuration Management**: `load_config()` function
- **Weather API**: `fetch_weather_data()` function
- **GUI**: `QisWeatherApp` class with PySide6
- **Temperature Conversion**: `celsius_to_fahrenheit()` utility

## License

This project is created for educational purposes as part of a Python programming assignment.

## Support

For issues or questions:
1. Check the troubleshooting section
2. Verify your configuration
3. Check the console output for error messages
4. Ensure all dependencies are properly installed
