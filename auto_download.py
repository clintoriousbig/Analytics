import os
from datetime import date, timedelta

# === Change working directory to where main.py is ===
os.chdir("/Users/clintgilmore/Desktop/Analytics")

# === Config ===
api_key = "8cadc4fe3b16b550bccfe627d87f2ccf-3cb0415e8c938c03e4c08d5c4dee3bf6"
start_date = "2018-01-01"
end_date = str(date.today() - timedelta(days=1))  # yesterday's date

# Folder to save files
output_folder = '/Users/clintgilmore/Desktop/Analytics/DATA'
os.makedirs(output_folder, exist_ok=True)

# === Daily Data ===
daily_instruments = {
    "AU200_AUD": "AUS",
    "SPX500_USD": "SPX",
    "UK100_GBP": "UK",
    "XAU_USD": "XAU",
    "BCO_USD": "BCO",
    "AUD_USD": "AUD"
}

for instrument_code, name in daily_instruments.items():
    filename = f"{output_folder}/{name}1d.csv"
    command = f"python3 main.py {instrument_code} {start_date} {end_date} D {api_key} {filename}"
    print(f"Running: {command}")
    os.system(command)

# === Hourly Data for AUS and SPX ===
hourly_instruments = {
    "AU200_AUD": "AUS",
    "SPX500_USD": "SPX"
}

for instrument_code, name in hourly_instruments.items():
    filename = f"{output_folder}/{name}1h.csv"
    command = f"python3 main.py {instrument_code} {start_date} {end_date} H1 {api_key} {filename}"
    print(f"Running: {command}")
    os.system(command)

# === 5-Minute Data for AUS and SPX ===
for instrument_code, name in hourly_instruments.items():
    filename = f"{output_folder}/{name}5m.csv"
    command = f"python3 main.py {instrument_code} {start_date} {end_date} M5 {api_key} {filename}"
    print(f"Running: {command}")
    os.system(command)

# === 10-Minute Data for AUS and SPX ===
for instrument_code, name in hourly_instruments.items():
    filename = f"{output_folder}/{name}10m.csv"
    command = f"python3 main.py {instrument_code} {start_date} {end_date} M10 {api_key} {filename}"
    print(f"Running: {command}")
    os.system(command)
