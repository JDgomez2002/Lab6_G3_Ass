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

@Compare lenght of names
    mov r7,#0
	ldr r5,=longitud_apellido_valor
	ldr r6,=longitud_nombre_valor
	ldr r5,[r5]
	ldr r6,[r6]
	cmp r6,r5
	addeq r7,r7,#1
    ldr r0,=longitud_nombre
    mov r1,r7
    bl printf

@Compare Vowels

    @print prueba
    ldr r0,= Test1
    bl puts






@@contar vocales
@nombre
	ldr r5,=name
	ldr r7,=vowelsn
	mov r6,#0 @contador de vocales
	bl count_vows
	str r6,[r7] @Guardar conteo de vocales
	@apellido
	ldr r5,=lname
	ldr r7,=vowelsln
	mov r6,#0 @contador de vocales
	bl count_vows
	str r6,[r7] @Guardar conteo de letras
	mov r7,#0

count_vows:
	@Se almacena la a direccion en r5
	@@Se carga el valor de la nueva direccion en r1
    @@Se hace un offset de 1 bytes a r5
	ldrb r1,[r5],#1
	@si es una vocal aumentar contador
	cmp r1,#'a'
	addeq r6,#1
	cmp r1,#'A'
	addeq r6,#1
	cmp r1,#'e'
	addeq r6,#1
	cmp r1,#'E'
	addeq r6,#1
	cmp r1,#'i'
	addeq r6,#1
	cmp r1,#'I'
	addeq r6,#1
	cmp r1,#'o'
	addeq r6,#1
	cmp r1,#'O'
	addeq r6,#1
	cmp r1,#'u'
	addeq r6,#1
	cmp r1,#'U'
	addeq r6,#1
	cmp r1,#0  @verficiar si ya ha llegado al final del array
	bne count_vows
	bx lr @return


.data
.align 2
menu: 
    .asciz "\nMi Primer Bebe!\nBienvenido!\nEn este programa podras comprobar la compatibilidad del nombre y apellido de tu futuro bebe...\nDeberas ingresar su nombre y apellido, y el numro de letras de los mismos!\n"

ingrese_nombre: 
    .asciz "\nIngrese nombre: "

nombre: 
    .asciz "%19s"

nombre_valor:
    .asciz "                   "

ingrese_apellido: 
    .asciz "\nIngrese apellido: "

apellido_valor:
    .asciz "                   "

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

Test1:
    .asciz "Llegamos aqui"
