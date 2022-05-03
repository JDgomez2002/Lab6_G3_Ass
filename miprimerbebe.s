@Laboratorio 6
@Grupo 3
@Melanie Maldonado
@Gonzalo Santizo
@Javier Vasquez
@Jose Daniel Gomez

.text
.align 2
.global main
.type main, %function
main:
stmfd sp!, {lr}

@Menu
    ldr r0,= menu
    bl puts
    @ingreso del nombre
    ldr r0,= ingrese_nombre
    bl puts
    ldr r0, = nombre
    ldr r1, = nombre_valor
    bl scanf

    @ingreso del apellido
    ldr r0,= ingrese_apellido
    bl puts
    ldr r0, = apellido
    ldr r1, = apellido_valor
    bl scanf

    @ingreso longitud nombre
    ldr r0,= ingrese_lenght_nom
    bl puts
    ldr r0, = longitud_nombre
    ldr r1, = longitud_nombre_valor
    bl scanf

    @ingreso longitud apellido
    ldr r0,= ingrese_lenght_apell
    bl puts
    ldr r0, = longitud_apellido
    ldr r1, = longitud_apellido_valor
    bl scanf

@Comparacion1-Mismo numero de letras
    ldr r0, = [longitud_nombre_valor]
    ldr r3,[r0]

    ldr r0, = [longitud_apellido_valor]
    ldr r4,[r0]

    mov r8, #0
    @add r8, #1 
    cmp r3, r4
    addeq r8, #1 
    
@Comparacion2-Mismo numero de vocales
    
    

.data
.align 2
menu: 
    .asciz "\nMi Primer Bebe!\nBienvenido!\nEn este programa podras comprobar la compatibilidad del nombre y apellido de tu futuro bebe...\nDeberas ingresar su nombre y apellido, y el numro de letras de los mismos!\n\n"

ingrese_nombre: 
    .asciz "\nIngrese nombre: "

nombre: 
    .asciz "%19s"

nombre_valor:
    .asciz "                                                    "

ingrese_apellido: 
    .asciz "\nIngrese apellido: "

apellido_valor:
    .asciz ""

apellido:
    .asciz "%s"

ingrese_lenght_nom:
    .asciz "\nIngrese longitud del nombre: "

longitud_nombre:
    .asciz "%d"

longitud_nombre_valor: 
    .word 0

ingrese_lenght_apell:
    .asciz "\nIngrese longitud del apellido: "

longitud_apellido:
    .asciz "%d"

longitud_apellido_valor:
    .word 0