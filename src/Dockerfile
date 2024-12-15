# Etapa base con una imagen ligera de Linux
FROM ubuntu:20.04

# Establecer variables para no interactuar con prompts durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar paquetes, instalar dependencias necesarias y limpiar cachés
RUN apt-get update && \
 apt-get install -y \
 apt-transport-https \
 bash \
 curl \
 git \
 python3 \
 python3-pip \
 software-properties-common \
 unzip \
 wget && \
 curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
 echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
 apt-get update && apt-get install -y terraform && \
 curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*

# Instalar módulos y paquetes de Python necesarios
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && \
 rm -f /tmp/requirements.txt

# Crear un directorio de trabajo para los scripts y configuraciones
WORKDIR /app

# Copiar los scripts de Terraform, Bash y Python al contenedor
COPY ./scripts /app/scripts
COPY ./infra /app/infra

# Dar permisos de ejecución a los scripts de Bash
RUN chmod +x /app/scripts/*.sh

# Variable de entrada predeterminada (opcional)
CMD ["bash"]
