// La sintaxis moderna del ensamblador ARM, unifica la sintaxis para ARM y Thumb
.syntax unified
// Configura el procesador objetivo (para el cual se generará código)
.cpu cortex-m3
// Declara que no hay unidad de punto flotante
.fpu softvfp
// Cambia a modo Thumb (nuestro procesador SOLO SOPORTA ESTE MODO)
.thumb

// Sección de código ejecutable
.text

// main es un símbolo de enlace externo (visible globalmente)
.global main
main:
    bl hexadecimalAAscii
// para la máquina con un lazo infinito (. es la dirección actual)
    b . 

// Datos en RAM inicializados
.data

// Tomado como entrada por hexadecimalAAscii
REGHEX: .byte 0x3C
// Tomado como salida por hexadecimalAAscii
REGASC: .byte 0

// Continúa con código
.text
/*
Realizar una rutina usando tablas, para la conversión de números hexadecimales
del registro en RAM “REGHEX” (solo parte baja, o sea 4 bits) a caracteres ASCII.
El valor convertido se debe guardar en el registro en RAM “REGASC”.
*/
hexadecimalAAscii:
// R0 es la dirección de la variable de entrada
    ldr R0,=REGHEX
// R1 es la dirección de la variable de salida
    ldr R1,=REGASC
// R2 es la dirección base del arreglo con la tabla de conversión
    ldr R2,=tablaHexadecimalAAscii
// R0 es el valor hexadecimal cargado de la variable
    ldrb R0,[R0]
// Operación de máscara para seleccionar solo los 4 bit menos significativos
    and R0,#0b1111
// Leo de la tabla el caracter en la posición dada por R0
// (R2 es la base de la tabla), cada elemento de la tabla es 1 byte
// Guardo el valor en la posición de la tabla indexada por el valor
// hexadecimal (R2+R0) en R0
    ldrb R0,[R2,R0]
// Guardo el valor recuperado (que es el caracter ascii correspondiente al
// valor hexadecimal) en la variable de destino
    strb R0,[R1]
// Retorna al programa principal
    bx lr

// Datos dentro de .text
.pool
tablaHexadecimalAAscii: .ascii "0123456789ABCDEF"