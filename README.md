# EXPERIMENTO - PROYECTO FINAL AREP

Instrucciones para ejecutar el experimento

1. Clonar el repositorio

```
git clone https://github.com/SantiagoBayona/Proyecto-AREP
```

## Ejecución

1. En el directorio del repositorio ejecutamos el script receive.ps1

```
.\receive.ps1
```

2. Luego corremos el script start.ps1

```
.\start.ps1
```

Este último script enviará señales repetidamente al servicio IoT Core de AWS las cuales serán procesadas por una función lambda y retornadas nuevamente a IoT Core y, gracias al script receive, se puede mostrar la última señal procesada en la consola del dispositivo IoT simulado
