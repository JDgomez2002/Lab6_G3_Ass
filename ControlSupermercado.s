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

ldr r0, = bienvenida
bl puts

Menu:
   /*impresion de menu y pide comando*/
   Menu:
   ldr r0,=menu_principal
   bl puts
   ldr r0,=ingrese_desicion
   bl puts
   ldr r0,=formato_asciz_char_menu
   ldr r1,=desicion_valor
   bl scanf



opcion_menu:
   ldr r4, = desicion_valor
   ldrb r4,[r4]
   cmp r4, #'1'
   beq Agregar_producto
   cmpne r4, #'2'
   beq Facturar
   cmpne r4, #'3'
   beq Salir
   bne Error

/*
	ldrb r1,[r5],#1
   strb r1,[r5]
*/
Agregar_producto:
   ldr r0, = menu_compra
   bl puts
   ldr r0, = ingrese_desicion
   bl puts
   ldr r0, = formato_asciz_char_producto
   ldr r1, = desicion_valor_compra
   bl scanf





   
   @Clasificar productos
   ldr r5, = desicion_valor_compra
   ldrb r4,[r5]
   ldr r6, = productos
   cmp r4, #'1' @ LECHE
   strb r4, [r6]
   cmpne r4, #'2'@ GALLETAS
   strb r4, [r6]
   cmpne r4, #'3' @ MANTEQUILLA
   strb r4, [r6]
   cmpne r4, #'4'@ QUESO
   strb r4, [r6]
   cmpne r4, #'5'@ UNIPAN
   strb r4, [r6]
   cmpne r4, #'6' @ JALEA
   strb r4, [r6]
   cmpne r4, #'7' @ UNIYOGURT
   strb r4, [r6]
   cmpne r4, #'8' @ LB MANZANAS
   strb r4, [r6]
   

   @cantidad de productos
   ldr r0, = solcitar_cantidad_productos
   bl puts
   ldr r0, = formato_decimal
   ldr r1, = cantidad_producto
   bl scanf
   ldr r0, = cantidad_producto
   ldrb r0, [r0]
   ldr r1, = cantidad_productos_valor
   strb r0, [r1]

   ldr r0, = producto_agregado
   bl puts
   b Menu

Facturar:
   @@Bloque de leer nombre 
	@@se lee el nombre que ingresa el usuario
	ldr r0,=ingrese_nombre @@formato de ingresar nombre
	bl puts 
	ldr r0,=nombre @@ variable que almacena el nombre
	ldr r1,=nombre_valor @@guarda el string del nombre
	bl scanf
   ldr r0, = factura1
   bl puts
   ldr r0, = nombre_factura
   bl puts
   ldr r0, = nombre_valor
   bl puts
   ldr r0, = factura_productos
   bl puts


Salir:
   ldr r0, = despedida
   bl puts
   mov r0, #0
   mov r3, #0
   ldmfd sp!, {lr}
   bx lr

Error:
   ldr r0, = error
   bl puts
   bl getchar
   b Menu

@-----------------------------------------------------------------------------------------------------
@------------------------------------------DATA-------------------------------------------------------
@-----------------------------------------------------------------------------------------------------

.data
.align 2

bienvenida:
   .asciz "\nTBienvenido al control de Supermercado!!!\nEn este programa podras realizar compras y facturarlas!\n"

menu_principal:
   .asciz "\nMENU PRINCIPAL\n1. Agregar producto al carrito\n2.Facturar\n3.Salir"

menu_compra:
   .asciz "\nMENU DE COMPRA\n1.Leche:\n   Cantidad de Existencias: 20\n   Precio Unitario: Q18.00\n2.P. Galletas:\n   Cantidad de Existencias: 32\n   Precio Unitario: Q25.00\n3.Mantequilla:\n   Cantidad de Existencias: 15\n   Precio Unitario: Q10.00\n4.Queso:\n   Cantidad de Existencias: 15\n   Precio Unitario: Q35.00\n5.Uni. Pan:\n   Cantidad de Existencias: 20\n   Precio Unitario: Q4.00\n6.Jalea:\n   Cantidad de Existencias: 18\n   Precio Unitario: Q26.00\n7.Uni. Yogurt:\n   Cantidad de Existencias: 35\n   Precio Unitario: Q8.00\n8.Lb. Manzana:\n   Cantidad de Existencias: 35\n   Precio Unitario: Q19.00\n"

ingrese_desicion:
   .asciz "\nIngrese su desicion: "

formato_asciz_char_menu:
   .asciz "%c"

formato_asciz_char_producto:
   .asciz "%c"

desicion_valor:
   .byte 0

desicion_valor_compra:
   .byte 0

despedida:
   .asciz "\n-----------------------------\n\nMuchas gracias por comprar con nosotros!\n\nEsperamos verlo pronto!!!\n\n"

error:
   .asciz "\n\tIngreso incorrecto, siga instrucciones por favor...\n"

ingrese_nombre: 
   .asciz "\nPor favor ingresa el nombre de la factura: "

nombre: 
    .asciz "%19s"

nombre_valor:
    .asciz "                   "

productos:
   .asciz "                   "

cantidad_producto:
   .word 0

solcitar_cantidad_productos:
   .asciz "\nIngrese la cantidad de producto deseado: "

formato_decimal:
   .asciz "%d"

cantidad_productos_valor:
   .asciz "                   "

producto_agregado:
   .asciz "\nProducto agregado al carrito exitosamente!!!\n"

factura1:
   .asciz "\n---------- FACTURA ----------\n"

nombre_factura:
   .asciz "Nombre del cliente: "

factura_productos:
   .asciz "\nCarrito:"
