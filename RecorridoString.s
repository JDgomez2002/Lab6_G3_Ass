.data
.align 2

formato:	.string "%19s" @@formato de entrada
@@Se especifica el tamaño del buffer con %[tamaño]s
buffer:		.asciz "                    " @@buffer de entrada
@@Se aloca el tamaño necesario para guardar la string recibida
@@El tamaño que se le especifica a scanf debe ser por lo menos uno menos que el tamaño real del buffer
@@Esto se hace para evitar segfaults

out:		.asciz "%d: %c\n" @@formato de salida para un número y un caracter
outNumber:		.asciz "%d\n" @@formato de salida para un número


.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}

	ldr r0, =formato
	ldr r1, =buffer
	bl scanf
	@@Se toma el input del usuario y se lo guarda en memoria en la dirección en r1
	@@debe haber suficiente espacio en esta dirección, si no, el sistema operativo detecta que scanf
	@@intentó escribir en memoria que no le pertenece al proceso y lo termina (da segfault)

	@@Se inicializa r6 con la dirección inicial del buffer
	@@El buffer se tratará como un arreglo de caracteres (bytes)
	@@scanf siempre termina el arreglo con el caracter de terminación nulo, código ascii 0
	ldr r6, =buffer

	@@Se inicializa el contador
	mov r5, #0

loop:
	@@Se carga el formato de salida en r0
	ldr r0, =out

	@@Se copia el contador en r1 para que printf lo muestre en la primera posición
	mov r1, r5

	@@Se carga el caracter (byte) del caracter al que apunta r6 en r2 para que printf lo muestre en la segunda posición
	@@Luego se le añade 1 a r6 para que apunte al siguiente caracter en la siguiente iteración (uso de post-index)
	@@Se le añade 1 porque cada caracter ocupa un solo byte
	ldrb r2, [r6], #1

	@@Se compara r2 (el valor del caracter), con 0, el código ascii del caracter nulo
	cmp r2, #0

	@@Si son iguales, significa que el caracter que se acaba de leer, es el final de la string
	@@Ojo, este final no es el final del buffer en sí, es el final de lo que ingresó el usuario
	beq end

	@@Si no estamos al final de la string, imprimimos el caracter y su posición en la string
	bl printf
	add r5, r5, #1

	@@Siempre que no estemos al final de la string, regresamos al loop
	b loop

end:
	@@Se muestra el valor final del contador, 
	mov r1, r5
	ldr r0, =outNumber
	bl printf

	@Salida
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
