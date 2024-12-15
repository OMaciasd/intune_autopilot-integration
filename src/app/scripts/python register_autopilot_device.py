import requests
import os

BASE_URL = (
    "https://graph.microsoft.com/v1.0/deviceManagement/"
    "windowsAutopilotDeviceIdentities"
)
TOKEN = os.getenv("ACCESS_TOKEN")

if not TOKEN:
    raise ValueError(
        "ACCESS_TOKEN no está definido en las variables de entorno."
    )

headers = {
    "Authorization": f"Bearer {TOKEN}",
    "Content-Type": "application/json"
}

# Resto del código...


headers = {
    "Authorization": f"Bearer {TOKEN}",
    "Content-Type": "application/json"
}

payload = {
    "serialNumber": "12345-67890",
    "deviceId": "example-device-id",
    "groupTag": "AutopilotGroup"
}

try:
    response = requests.post(
        BASE_URL, headers=headers, json=payload, timeout=10
    )
    response.raise_for_status()
    print("Solicitud exitosa:", response.json())
except requests.exceptions.Timeout:
    print("Error: El servidor no respondió dentro del tiempo límite.")
except requests.exceptions.RequestException as e:
    print(f"Error en la solicitud: {e}")

if response.status_code == 201:
    print("Dispositivo registrado con éxito.")
else:
    print("Error:", response.json())
