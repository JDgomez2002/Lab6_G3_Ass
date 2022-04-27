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
    ldr r0,=menu
    bl puts
    ldr r0,=ingreso
    bl puts
    ldr r0,=opcion
    ldr r1,=comando
    bl scanf




.data
.align 2
menu: .asciz "\nMi Primer Bebe!\nBienvenido!\n-. resta\n*. mul\n/. div\n=.