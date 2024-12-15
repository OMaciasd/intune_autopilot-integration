from azure.identity import DefaultAzureCredential
from azure.mgmt.intune import IntuneManagementClient

# Autenticación
credential = DefaultAzureCredential()
client = IntuneManagementClient(credential, "<SUBSCRIPTION_ID>")

# Ejemplo: Listar aplicaciones gestionadas por Intune
apps = client.managed_apps.list()
for app in apps:
    print(app.display_name)
