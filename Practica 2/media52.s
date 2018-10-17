# Práctica 5.2 - Sumar N enteros sin signo de 32 bits sobre dos registros de 32 bits mediante extensión con ceros
# autor: Francisco Domínguez Lorente
# Como me estaba haciendo un lío mental he ido añadiendo comentarios a la mayoría de instrucciones
# Para compilar:
# for i in $(seq 1 8); do rm media;
# gcc -x assembler-with-cpp -D TEST=$i -no-pie media.s -o media; printf "__TEST%02d__%35s\n" $i "" | tr " " "-" ; ./media; done


.section .data
#ifndef TEST
#define TEST 9
#endif
		.macro linea
	#if TEST==1
			.int 1,1,1,1
			.int 1,1,1,1
			.int 1,1,1,1
			.int 1,1,1,1
	#elif TEST==2
			.int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
			.int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
			.int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
			.int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
	#elif TEST==3
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
	#elif TEST==4
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
	#elif TEST==5
			.int -1,-1,-1,-1
			.int -1,-1,-1,-1
			.int -1,-1,-1,-1
			.int -1,-1,-1,-1
	#elif TEST==6
			.int 200000000, 200000000, 200000000, 200000000
			.int 200000000, 200000000, 200000000, 200000000
			.int 200000000, 200000000, 200000000, 200000000
			.int 200000000, 200000000, 200000000, 200000000
	#elif TEST==7
			.int 300000000, 300000000, 300000000, 300000000
			.int 300000000, 300000000, 300000000, 300000000
			.int 300000000, 300000000, 300000000, 300000000
			.int 300000000, 300000000, 300000000, 300000000
	#elif TEST==8
			.int 5000000000, 5000000000, 5000000000, 5000000000
			.int 5000000000, 5000000000, 5000000000, 5000000000
			.int 5000000000, 5000000000, 5000000000, 5000000000
			.int 5000000000, 5000000000, 5000000000, 5000000000
	#else
			.error "Definir un valor entre 1 y 8"
	#endif
			.endm
lista:	linea
longlista:  .int   (.-lista)/4
resultado:	.quad   0
formato:	.ascii "resultado \t = 		%18lu (uns)\n"
			.ascii "		\t\t = 0x%18lx (hex)\n"
			.asciz "		\t\t = 0x %08x %08x \n"

# Para saber como se compila el programa
# opción: 4) usar tb main
# 4) gcc media.s -o media -no-pie				8664 B

.section .text
main:   .global  main

# Trabajar
	mov     $lista, %rbx
	mov  longlista, %ecx
	call suma		# == suma(&lista, longlista);
	mov  %eax, resultado
	mov  %edx, resultado+4

# Imprimir_C
	mov   $formato, %rdi
	mov   resultado,%rsi
	mov   resultado,%rdx
	mov   resultado+4,%ecx
	mov   resultado,%r8d
	mov          $0,%eax	# varargin sin xmm
	call  printf		# == printf(formato, res, res);

# Acabar_C
	mov  resultado, %edi
	call _exit		# ==  exit(resultado)
	ret

suma:
	mov  $0, %eax	# Nuestro índice
	mov  $0, %edx	# Índice de destino
	mov  $0, %rsi	# Acumulador
bucle:
	add  (%rbx, %rsi, 4), %eax	# Sumamos las partes menos significativas, esto es nuestro número en %rbx con %eax
	adc   $0, %rdx		# Sumamos las partes más significativas, 0 y %edx y el acarreo (si lo hubiera)
	inc   %rsi			# Aumentamos nuestro índice para que el bucle tenga sentido
	cmp   %rsi, %rcx	# Comparamos si el índice es igual a la longitud de la lista para seguir o no en el bucle
	jne    bucle		# Volvemos al bucle
	ret
