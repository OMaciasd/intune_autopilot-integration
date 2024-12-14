import requests
import os

TOKEN = os.getenv("ACCESS_TOKEN")

url = "https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations"

headers = {
    'Authorization': 'Bearer tu_access_token',
    'Content-Type': 'application/json'
}

data = {
    "displayName": "AppLocker Policy for Windows Devices",
    "description": "AppLocker configuration to block unwanted apps",
    "platform": "windows10AndLater",
    "isAssigned": True,
    "settings": {
        "applockerConfiguration": {
            "allowDefaultRules": True,
            "rules": [
                {
                    "action": "allow",
                    "ruleType": "executable",
                    "path": "C:\\Program Files\\*",
                    "user": "all"
                },
                {
                    "action": "deny",
                    "ruleType": "executable",
                    "path": "C:\\Program Files\\UnwantedApp\\*",
                    "user": "all"
                }
            ]
        }
    }
}

try:
    response = requests.post(
        url,
        headers=headers,
        json=data,
        timeout=10
    )
    response.raise_for_status()
    print(response.status_code, response.json())

except requests.exceptions.Timeout:
    print(
        "Error: El servidor no respondió dentro del límite."
    )
except requests.exceptions.RequestException as e:
    print(f"Error en la solicitud: {e}")

# Configuración
tenant_id = "YOUR_TENANT_ID"
client_id = "YOUR_CLIENT_ID"
if not TOKEN:
    raise ValueError(
        "ACCESS_TOKEN no está definido en las variables de entorno."
    )
auth_url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token"
graph_url = (
    "https://graph.microsoft.com/v1.0/deviceManagement/"
    "windowsAutopilotDeviceIdentities"
)

# Autenticación


def get_access_token():
    jls_extract_var = "TOKEN"
    payload = {
        "client_id": client_id,
        jls_extract_var: TOKEN,
        "grant_type": "client_credentials",
        "scope": "https://graph.microsoft.com/.default"
    }
    try:
        response = requests.post(
            auth_url, data=payload, timeout=10
        )
        response.raise_for_status()
        return response.json()["access_token"]
        print("Solicitud exitosa:", response.json())
    except requests.exceptions.Timeout:
        print("Error: El servidor no respondió dentro del tiempo límite.")
    except requests.exceptions.RequestException as e:
        print(f"Error en la solicitud: {e}")

# Registrar Dispositivo


def register_device(access_token, device_info):
    headers = {
        "Authorization": f"Bearer {access_token}",
        "Content-Type": "application/json"
    }
    try:
        response = requests.post(
            graph_url,
            headers=headers,
            json=device_info,
            timeout=10
        )
        response.raise_for_status()
        return response.json()["access_token"]
        print("Solicitud exitosa:", response.json())
    except requests.exceptions.Timeout:
        print("Error: El servidor no respondió dentro del tiempo límite.")
    except requests.exceptions.RequestException as e:
        print(f"Error en la solicitud: {e}")
    if response.status_code == 201:
        print(f"Dispositivo registrado: {device_info['serialNumber']}")
    else:
        print(f"Error: {response.status_code} - {response.text}")


# Datos de los Dispositivos
devices = [
    {
        "orderIdentifier": "Order001",
        "serialNumber": "1234567890",
        "productKey": "XXXXX-XXXXX-XXXXX-XXXXX",
        "groupTag": "ITDept",
        "assignedUserPrincipalName": "user1@domain.com"
    },
    {
        "orderIdentifier": "Order002",
        "serialNumber": "0987654321",
        "productKey": "YYYYY-YYYYY-YYYYY-YYYYY",
        "groupTag": "HRDept",
        "assignedUserPrincipalName": "user2@domain.com"
    }
]

# Ejecutar
if __name__ == "__main__":
    token = get_access_token()
    for device in devices:
        register_device(token, device)
