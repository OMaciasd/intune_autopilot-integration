#!/bin/bash

docker build -t intune-autopilot:latest .

docker run -it --rm \
    -v $(pwd)/scripts:/app/scripts \
    -v $(pwd)/infra:/app/infra \
    intune-autopilot:latest
