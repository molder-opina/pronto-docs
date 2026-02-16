---
ID: ERR-20260203-AUDIO-ASSETS-EMPTY
FECHA: 2026-02-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Archivos de audio en static_content están vacíos
DESCRIPCION: Los sonidos para llamada de mesero apuntan a audio en static_content, pero los archivos existentes están en tamaño 0 bytes. Esto produce reproducción silenciosa.
PASOS_REPRODUCIR: 1) Abrir UI cliente y disparar llamada de mesero. 2) Ver request de /assets/audio/bell1.mp3. 3) Comprobar que el archivo es 0 bytes y no se escucha audio.
RESULTADO_ACTUAL: Los archivos de audio están vacíos, no hay sonido.
RESULTADO_ESPERADO: Archivos de audio con contenido válido.
UBICACION: pronto-static/src/static_content/assets/audio/bell1.mp3; pronto-static/src/static_content/assets/audio/bell2.mp3; pronto-static/src/static_content/assets/audio/whistle.mp3
EVIDENCIA: ls muestra tamaño 0 bytes en los tres archivos.
HIPOTESIS_CAUSA: Assets placeholder no reemplazados en static_content.
ESTADO: RESUELTO
SOLUCION: Generados archivos de audio válidos usando ffmpeg:
- bell1.mp3: 2.9KB (440Hz + 880Hz, 0.3s)
- bell2.mp3: 2.9KB (523Hz + 1046Hz, 0.3s)
- whistle.mp3: 2.1KB (2000Hz con fade, 0.2s)
FECHA_RESOLUCION: 2026-02-09
---
