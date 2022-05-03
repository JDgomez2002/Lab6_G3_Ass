@Laboratorio 6
@Grupo 3
@Melanie Maldonado
@Gonzalo Santizo
@Javier Vasquez
@Jose Daniel Gomez


	.text
	.align		2
	.global		main
	.type		main, %function
main:
	stmfd	sp!, {lr}
	ldr r0,=menu @@formato de bienvenida
	bl puts
	@@se lee el nombre que ingresa el usuario
	ldr r0,=ingrese_nombre @@formato de ingresar nombre
	bl puts 
	ldr r0,=nombre @@ variable que almacena el nombre
	ldr r1,=nombre_valor @@guarda el string del nombre
	bl scanf


	@@- se repite la instruccion de nombre pero para el apellido
	ldr r0,=ingrese_apellido
	bl puts 
	ldr r0,=apellido
	ldr r1,=apellido_valor
	bl scanf


	@@contar letras 
	@@seccion de nombre
	ldr r5,=nombre_valor @@se cuentan  individualmente las letras en la variable nombre
	ldr r7,=longitud_nombre_valor @@se le asigna un contador
	mov r6,#0 @contador de letras
	bl Contar_Letras @@ saltamos a la branch donde se cuentan las letras
	str r6,[r7] @Guardar conteo de letras


    @@ se repite la seccion de nombre para contar apellido
	@@Seccion de apellido  
	ldr r5,=apellido_valor
	ldr r7,=longitud_apellido_valor
	mov r6,#0 @contador de letras
	bl Contar_Letras 
	str r6,[r7] @Guardar conteo de letras


	@@Se contaran vocales en esta seccion

	@contar vocales nombre
	ldr r5,=nombre_valor @@ se carga la variable que contiene el nombre
	ldr r7,=Vocales_Nombre @@ se crea un contador para guardar el numero de vocales
	mov r6,#0 @contador de vocales
	bl Contar_Vocales @@saltamos a la branch contar vocales
	str r6,[r7] @Guardar resultado

	@apellido, se repiten las mismas instrucciones
	ldr r5,=apellido_valor
	ldr r7,=Vocales_Apellido
	mov r6,#0 @contador de vocales
	bl Contar_Vocales
	str r6,[r7] @Guardar conteo de letras
	mov r7,#0

    
	@@ aqui evaluamos condiciones
	@igual longitud
	ldr r5,=longitud_nombre_valor @@comparamos la longitud del nombre con la del apellido
	ldr r6,=longitud_apellido_valor
	ldr r5,[r5]
	ldr r6,[r6]
	cmp r6,r5
	addeq r7,#1
	beq Misma_Longitud @@ saltar a la branch Misma longitud


Comparar_Vocales:
	@funcion para comparar vocales 
	ldr r5,=Vocales_Nombre @@variables de vocales de nombre
	ldr r6,=Vocales_Apellido
	ldr r5,[r5]
	ldr r6,[r6]
	cmp r6,r5
	addeq r7,r7,#1
	beq Misma_Vocales


Comparar_Letra:
	@letras inicial y final 
	ldr r5,=nombre_valor @@cargamos variables de nombre y apellido
	ldr r6,=apellido_valor
	ldrb r5,[r5]
	ldrb r6,[r6]
	cmp r6,r5 @compara el primer valor si son iguales realizar la segunda comparacion
	beq last_letter
	@guardar punteo
	ldr r6,=Total_Puntos
	str r7,[r6]
	b salida

    
/*---contar longitud de la palabra
		r5 tiene que contener la palabra que queremos contar o no funciona.
		como se discutio en clase se usa ldrb para moverse 1 posicion--*/
Contar_Letras:
	@Se almacena la a direccion en r5
	@@Se carga el valor de la nueva dirección en r1
    @@Se hace un offset de 1 bytes a r5
	ldrb r1,[r5],#1
	cmp r1,#0 @verficiar si ya ha llegado al final del array
	addne r6,#1
	bne Contar_Letras
	bx lr @return
/*---contar longitud de la palabra
		r5 debe de contener la palabra antes de usar el metodo,
		el puntero del array debe de estar colocado en la correspondiente posicion antes de usar para poder guardar--*/
Contar_Vocales:
	@Se almacena la a direccion en r5
	@@Se carga el valor de la nueva dirección en r1
    @@Se hace un offset de 1 bytes a r5
	ldrb r1,[r5],#1
	@si es una vocal aumentar contador
	cmp r1,#'a'
	addeq r6,#1

	cmp r1,#'e'
	addeq r6,#1

	cmp r1,#'i'
	addeq r6,#1

	cmp r1,#'o'
	addeq r6,#1

	cmp r1,#'u'
	addeq r6,#1

	cmp r1,#0  @verficiar si ya ha llegado al final del array
	bne Contar_Vocales
	bx lr @return


// new new shit here // 

Misma_Longitud:
	ldr r0,=samelenght
	bl puts
	b Comparar_Vocales
Misma_Vocales:
	ldr r0,=samevowels
	bl puts
	b Comparar_Letra
same_startend:
	ldr r0,=samestartend
	bl puts
	b  savescore
last_letter: 
	@obtener el largo de las palabras
	ldr r5,=longitud_nombre_valor
	ldr r6,=longitud_apellido_valor
	ldr r5,[r5]
	ldr r6,[r6]
	@decrementar en 1 el tamaño de palabras
	sub r6,#1
	sub r5,#1
	@mover el puntero de las letras a la ultima de cada palabra
	ldr r8,=nombre_valor 
	ldr r4,=apellido_valor
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
	ldr r6,=Total_Puntos
	str r7,[r6]
salida:
	ldr r0,=result
	ldr r1,=Total_Puntos
	ldr r1,[r1]
	bl printf
/*--salida del sistema--*/
	mov	r3, #0
	mov	r0, r3
	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr


.data
.align 2
menu: 
    .asciz "\nMi Primer Bebe!\nBienvenido!\nEn este programa podras comprobar la compatibilidad del nombre y apellido de tu futuro bebe...\nDeberas ingresar su nombre y apellido, y el numero de letras de los mismos!\n"

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
    .asciz "%19s"

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


@@vocales en el nombre y su tamaño

Vocales_Nombre: 
    .word 0
Vocales_Apellido: 
    .word 0

Total_Puntos:
    .word 0 

samelenght: 
    .asciz "\n"
samevowels: 
    .asciz "\n"
samestartend: 
    .asciz "\n"

result: 
    .asciz "el punteo total es de: %d \n"
