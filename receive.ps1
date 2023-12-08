# Ajusta las variables según tu configuración
$endpoint = "a1ju55jz0xj2gp-ats.iot.us-east-1.amazonaws.com"
$clientID = "sdk-java"
$topic = "aws/res"
$certFile = "test_device1.cert.pem"
$keyFile = "test_device1.private.key"
$rootCAFile = "root-CA.crt"

# Comando para suscribirse al tema y mostrar los mensajes
$message = mosquitto_sub -h $endpoint -p 8883 -i $clientID -t $topic -C 1 --cafile $rootCAFile --cert $certFile --key $keyFile

# Muestra el último mensaje
Write-Host "$message"


