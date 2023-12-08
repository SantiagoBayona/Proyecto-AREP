#!/usr/bin/env bash
# requires: Python, PowerShell, Permission to run PS scripts
# permissions for this PS session only:   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

$ErrorActionPreference = "Stop"

# Find appropriate exe for running Python 3.
function Test-Python3 {
    try {
        $ver = & $python3 -c "import sys; print(sys.version[0])" 2>&1
        $ver -eq 3
    } catch {
        $false
    }
}

$python3 = "python3.exe"
if (!(Test-Python3)) {
    $python3 = "python.exe"
    if (!(Test-Python3)) {
        "`nERROR: Python 3 must be runnable via python3.exe or python.exe"
        exit
    }
}
"`nRunning Python 3 via: $python3"

# Check to see if root CA file exists, download if not
If (!(Test-Path ".\root-CA.crt")) {
    "`nDownloading AWS IoT Root CA certificate from AWS..."
    Invoke-WebRequest -Uri https://www.amazontrust.com/repository/AmazonRootCA1.pem -OutFile root-CA.crt
}

# Check to see if AWS Device SDK for Python exists, download if not
If (!(Test-Path ".\aws-iot-device-sdk-python-v2")) {
    "`nCloning the AWS SDK...\n"
    git clone https://github.com/aws/aws-iot-device-sdk-python-v2 --recursive
}

# Check to see if AWS Device SDK for Python is already installed, install if not
& $python3 -c "import awsiot"
if (!$?) {
    "`nInstalling AWS SDK..."
    & $python3 -m pip install .\aws-iot-device-sdk-python-v2\
    if (!$?) {
        "`nERROR: Failed to install SDK."
        exit
    }
}

# Genera un arreglo de 4 números aleatorios entre 1 y 100

function Get-RandomNumbers {
    # Genera un arreglo de 4 números aleatorios entre 1 y 100
    $random_numbers = @()
    for ($i=0; $i -lt 4; $i++) {
        $random_numbers += Get-Random -Minimum 1 -Maximum 101
    }

    $comma_separated_numbers = $random_numbers -join ','
    return $comma_separated_numbers
}


"`nRunning pub/sub sample application..."
$pythonCommand = "& $python3 aws-iot-device-sdk-python-v2\samples\pubsub.py --endpoint a1ju55jz0xj2gp-ats.iot.us-east-1.amazonaws.com --ca_file root-CA.crt --cert test_device1.cert.pem --key test_device1.private.key --client_id arep --topic aws/arep --message ""$(Get-RandomNumbers)"" --count 0"

Invoke-Expression -Command $pythonCommand
