.data
.align 2

formato:	.string "%19s" @@formato de entrada
@@Se especifica el tama�o del buffer con %[tama�o]s
buffer:		.asciz "                    " @@buffer de entrada
@@Se aloca el tama�o necesario para guardar la string recibida
@@El tama�o que se le especifica a scanf debe ser por lo menos uno menos que el tama�o real del buffer
@@Esto se hace para evitar segfaults

out:		.asciz "%d: %c\n" @@formato de salida para un n�mero y un caracter
outNumber:		.asciz "%d\n" @@formato de salida para un n�mero


.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}

	ldr r0, =formato
	ldr r1, =buffer
	bl scanf
	@@Se toma el input del usuario y se lo guarda en memoria en la direcci�n en r1
	@@debe haber suficiente espacio en esta direcci�n, si no, el sistema operativo detecta que scanf
	@@intent� escribir en memoria que no le pertenece al proceso y lo termina (da segfault)

	@@Se inicializa r6 con la direcci�n inicial del buffer
	@@El buffer se tratar� como un arreglo de caracteres (bytes)
	@@scanf siempre termina el arreglo con el caracter de terminaci�n nulo, c�digo ascii 0
	ldr r6, =buffer

	@@Se inicializa el contador
	mov r5, #0

loop:
	@@Se carga el formato de salida en r0
	ldr r0, =out

	@@Se copia el contador en r1 para que printf lo muestre en la primera posici�n
	mov r1, r5

	@@Se carga el caracter (byte) del caracter al que apunta r6 en r2 para que printf lo muestre en la segunda posici�n
	@@Luego se le a�ade 1 a r6 para que apunte al siguiente caracter en la siguiente iteraci�n (uso de post-index)
	@@Se le a�ade 1 porque cada caracter ocupa un solo byte
	ldrb r2, [r6], #1

	@@Se compara r2 (el valor del caracter), con 0, el c�digo ascii del caracter nulo
	cmp r2, #0

	@@Si son iguales, significa que el caracter que se acaba de leer, es el final de la string
	@@Ojo, este final no es el final del buffer en s�, es el final de lo que ingres� el usuario
	beq end

	@@Si no estamos al final de la string, imprimimos el caracter y su posici�n en la string
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
