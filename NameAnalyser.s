/*--
Universidad del Valle
Assembler y organizacion de computadoras
seccion 20
laboratorio 7 Parte A
Arturo Argueta	21527
Astrid Glauser  21299
--*/
.data
.align 2
entryformat: .asciz "%19s"
@@Nombre y Apellido a guardar
name: .asciz "                    "
lname: .asciz "                    "
@@vocales en el nombre y su tamaño
vowelsn: .word 0
lenghtn: .word 0
@@vocales en el apellido y su tamaño
vowelsln: .word 0
lenghtln: .word 0
format1: .asciz "Ingrese nombre"
format2: .asciz "Ingrese apellido"
format3: .asciz "%d \n"
format4: .asciz "Criterios cumplidos: \n"
samelenght: .asciz "nombre y apellido tienen la misma cantidad de letras \n"
samevowels: .asciz "nombre y apellido tienen la misma cantidad de vocales \n"
samestartend: .asciz "nombre y apellido tienen la misma letra al inicio y final \n"
score: .word 0 @implica el punteo
result: .asciz "el punteo total es de: %d \n"
wellcome: .asciz "bienvenido al analizador de compatibilidad de nombre y apellido \n no exceda las 19 letras"



@@ codigo de assembler: se coloca en la seccion .text
	.text
	.align		2
	@@ etiqueta "main" llama a la funcion global
	.global		main
	.type		main, %function
main:
	@@ grabar registro de enlace en la pila
	stmfd	sp!, {lr}
	ldr r0,=wellcome
	bl puts
	/*--leer nombre--*/
	ldr r0,=format1
	bl puts 
	ldr r0,=entryformat
	ldr r1,=name
	bl scanf
	@@-leer apellido
	ldr r0,=format2
	bl puts 
	ldr r0,=entryformat
	ldr r1,=lname
	bl scanf
	@@contar letras 
	@@nombre
	ldr r5,=name
	ldr r7,=lenghtn
	mov r6,#0 @contador de letras
	bl count_length 
	str r6,[r7] @Guardar conteo de letras
	@@apellido 
	ldr r5,=lname
	ldr r7,=lenghtln
	mov r6,#0 @contador de letras
	bl count_length 
	str r6,[r7] @Guardar conteo de letras
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
	/*- evaluar condiciones -*/
	ldr r0,=format4
	bl puts
	@igual longitud
	ldr r5,=lenghtn
	ldr r6,=lenghtln
	ldr r5,[r5]
	ldr r6,[r6]
	cmp r6,r5
	addeq r7,#1
	beq same_lenght
compare_vows:
	@igual cantidad de vocales
	ldr r5,=vowelsn
	ldr r6,=vowelsln
	ldr r5,[r5]
	ldr r6,[r6]
	cmp r6,r5
	addeq r7,r7,#1
	beq same_vowels 
compare_letters:
	@letras inicial y final 
	ldr r5,=name
	ldr r6,=lname
	ldrb r5,[r5]
	ldrb r6,[r6]
	cmp r6,r5 @compara el primer valor si son iguales realizar la segunda comparacion
	beq last_letter
	@guardar punteo
	ldr r6,=score
	str r7,[r6]
	b salida
/*---contar longitud de la palabra
		r5 debe de contener la palabra antes de usar el metodo,
		el puntero del array debe de estar colocado en la correspondiente posicion antes de usar--*/
count_length:
	@Se almacena la a direccion en r5
	@@Se carga el valor de la nueva dirección en r1
    @@Se hace un offset de 1 bytes a r5
	ldrb r1,[r5],#1
	cmp r1,#0 @verficiar si ya ha llegado al final del array
	addne r6,#1
	bne count_length
	bx lr @return
/*---contar longitud de la palabra
		r5 debe de contener la palabra antes de usar el metodo,
		el puntero del array debe de estar colocado en la correspondiente posicion antes de usar para poder guardar--*/
count_vows:
	@Se almacena la a direccion en r5
	@@Se carga el valor de la nueva dirección en r1
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
same_lenght:
	ldr r0,=samelenght
	bl puts
	b compare_vows
same_vowels:
	ldr r0,=samevowels
	bl puts
	b compare_letters
same_startend:
	ldr r0,=samestartend
	bl puts
	b  savescore
last_letter: 
	@obtener el largo de las palabras
	ldr r5,=lenghtn
	ldr r6,=lenghtln
	ldr r5,[r5]
	ldr r6,[r6]
	@decrementar en 1 el tamaño de palabras
	sub r6,#1
	sub r5,#1
	@mover el puntero de las letras a la ultima de cada palabra
	ldr r8,=name 
	ldr r4,=lname
	add r4,r6
	add r8,r5
	@comparar las letras, si son iguales aumentar el conteo
	ldrb r4,[r4]
	ldrb r8,[r8]
	cmp r8,r4
	addeq r7,#1
	beq same_startend
savescore:
	@guardar punteo
	ldr r6,=score
	str r7,[r6]
salida:
	ldr r0,=result
	ldr r1,=score
	ldr r1,[r1]
	bl printf
/*--salida del sistema--*/
	mov	r3, #0
	mov	r0, r3
	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr
