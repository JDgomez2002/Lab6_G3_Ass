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

Menu:
   ldr r0, = bienvenida
   bl puts 
   ldr r0, = menu_principal
   bl puts
   ldr r0, = ingrese_desicion
   bl puts
   ldr r0, = formato_asciz_char
   ldr r1, = desicion_valor
   bl scanf

opcion_menu:
   ldr r4 = desicion_valor
   ldr r4,[r4]
   cmp r4,#'1'
   beq Agregar_producto
   cmpne r4, #'2'
   beq Facturar
   cmpne r4, #'3'
   beq Salir
   bne Error

Agregar_producto:
   ldr r0, = menu_compra
   bl puts
   ldr r0, = ingrese_desicion
   bl puts
   ldr r0, = formato_asciz_char
   ldr r1, = desicion_valor
   bl scanf
   

Facturar:


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
   .asciz "\nBienvenido al control de Supermercado!!!\nEn este programa podras realizar compras y facturarlas!\n"

menu_principal:
   .asciz "\nMENU PRINCIPAL\n1. Agregar producto al carrito\n2.Facturar\n3.Salir"

menu_compra:
   .asciz "\nMENU DE COMPRA\n1.Leche:\n   Cantidad de Existencias: 20\n   Precio Unitario: Q18.00\n2.P. Galletas:\n   Cantidad de Existencias: 32\n   Precio Unitario: Q25.00\n3.Mantequilla:\n   Cantidad de Existencias: 15\n   Precio Unitario: Q10.00\n4.Queso:\n   Cantidad de Existencias: 15\n   Precio Unitario: Q35.00\n5.Uni. Pan:\n   Cantidad de Existencias: 20\n   Precio Unitario: Q4.00\n6.Jalea:\n   Cantidad de Existencias: 18\n   Precio Unitario: Q26.00\n7.Uni. Yogurt:\n   Cantidad de Existencias: 35\n   Precio Unitario: Q8.00\n8.Lb. Manzana:\n   Cantidad de Existencias: 35\n   Precio Unitario: Q19.00\n"

ingrese_desicion:
   .asciz "\nIngrese su desicion: "

formato_asciz_char:
   .asciz "%c"

desicion_valor:
   .byte 0

despedida:
   .asciz "\nMuchas gracias por comprar con nosotros!\n\nEsperamos verlo pronto!!!\n\n"

error:
   .asciz "\nIngreso incorrecto, siga instrucciones por favor...\n"