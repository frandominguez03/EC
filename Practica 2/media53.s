# Práctica 5.3 - Sumar N enteros con signo de 32 bits sobre dos registros de 32 bits
# autor: Francisco Domínguez Lorente
# Para compilar:
# for i in $(seq 1 19); do rm media;
# gcc -x assembler-with-cpp -D TEST=$i -no-pie media.s -o media; printf "__TEST%02d__%35s\n" $i "" | tr " " "-" ; ./media; done


.section .data
#ifndef TEST
#define TEST 20
#endif
		.macro linea
	#if TEST==1
			.int -1,-1,-1,-1
			.int -1,-1,-1,-1
			.int -1,-1,-1,-1
			.int -1,-1,-1,-1
	#elif TEST==2
			.int 0x04000000, 0x04000000, 0x04000000, 0x04000000
			.int 0x04000000, 0x04000000, 0x04000000, 0x04000000
			.int 0x04000000, 0x04000000, 0x04000000, 0x04000000
			.int 0x04000000, 0x04000000, 0x04000000, 0x04000000
	#elif TEST==3
			.int 0x08000000, 0x08000000, 0x08000000, 0x08000000
			.int 0x08000000, 0x08000000, 0x08000000, 0x08000000
			.int 0x08000000, 0x08000000, 0x08000000, 0x08000000
			.int 0x08000000, 0x08000000, 0x08000000, 0x08000000
	#elif TEST==4
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
			.int 0x10000000, 0x10000000, 0x10000000, 0x10000000
	#elif TEST==5
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
	#elif TEST==6
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
	#elif TEST==7
			.int 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000
			.int 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000
			.int 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000
			.int 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000
	#elif TEST==8
			.int 0xf8000000, 0xf8000000, 0xf8000000, 0xf8000000
			.int 0xf8000000, 0xf8000000, 0xf8000000, 0xf8000000
			.int 0xf8000000, 0xf8000000, 0xf8000000, 0xf8000000
			.int 0xf8000000, 0xf8000000, 0xf8000000, 0xf8000000
	#elif TEST==9
			.int 0xf7ffffff, 0xf7ffffff, 0xf7ffffff, 0xf7ffffff
			.int 0xf7ffffff, 0xf7ffffff, 0xf7ffffff, 0xf7ffffff
			.int 0xf7ffffff, 0xf7ffffff, 0xf7ffffff, 0xf7ffffff
			.int 0xf7ffffff, 0xf7ffffff, 0xf7ffffff, 0xf7ffffff
	#elif TEST==10
			.int 100000000, 100000000, 100000000, 100000000
			.int 100000000, 100000000, 100000000, 100000000
			.int 100000000, 100000000, 100000000, 100000000
			.int 100000000, 100000000, 100000000, 100000000
	#elif TEST==11
			.int 200000000, 200000000, 200000000, 200000000
			.int 200000000, 200000000, 200000000, 200000000
			.int 200000000, 200000000, 200000000, 200000000
			.int 200000000, 200000000, 200000000, 200000000
	#elif TEST==12
			.int 300000000, 300000000, 300000000, 300000000
			.int 300000000, 300000000, 300000000, 300000000
			.int 300000000, 300000000, 300000000, 300000000
			.int 300000000, 300000000, 300000000, 300000000
	#elif TEST==13
			.int 2000000000, 2000000000, 2000000000, 2000000000
			.int 2000000000, 2000000000, 2000000000, 2000000000
			.int 2000000000, 2000000000, 2000000000, 2000000000
			.int 2000000000, 2000000000, 2000000000, 2000000000
	#elif TEST==14
			.int 3000000000, 3000000000, 3000000000, 3000000000
			.int 3000000000, 3000000000, 3000000000, 3000000000
			.int 3000000000, 3000000000, 3000000000, 3000000000
			.int 3000000000, 3000000000, 3000000000, 3000000000
	#elif TEST==15
			.int -100000000, -100000000, -100000000, -100000000
			.int -100000000, -100000000, -100000000, -100000000
			.int -100000000, -100000000, -100000000, -100000000
			.int -100000000, -100000000, -100000000, -100000000
	#elif TEST==16
			.int -200000000, -200000000, -200000000, -200000000
			.int -200000000, -200000000, -200000000, -200000000
			.int -200000000, -200000000, -200000000, -200000000
			.int -200000000, -200000000, -200000000, -200000000
	#elif TEST==17
			.int -300000000, -300000000, -300000000, -300000000
			.int -300000000, -300000000, -300000000, -300000000
			.int -300000000, -300000000, -300000000, -300000000
			.int -300000000, -300000000, -300000000, -300000000
	#elif TEST==18
			.int -2000000000, -2000000000, -2000000000, -2000000000
			.int -2000000000, -2000000000, -2000000000, -2000000000
			.int -2000000000, -2000000000, -2000000000, -2000000000
			.int -2000000000, -2000000000, -2000000000, -2000000000
	#elif TEST==19
			.int -3000000000, -3000000000, -3000000000, -3000000000
			.int -3000000000, -3000000000, -3000000000, -3000000000
			.int -3000000000, -3000000000, -3000000000, -3000000000
			.int -3000000000, -3000000000, -3000000000, -3000000000
	#else
			.error "Definir un valor entre 1 y 19"
	#endif
			.endm
lista:	linea
longlista:  .int   (.-lista)/4
resultado:	.quad   0
formato:	.ascii "resultado \t = 		%18ld (sgn)\n"
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
	mov  $0, %ebp	# Acumulador
	mov  $0, %edi 	# Acumulador

bucle:
	mov  (%rbx, %rsi, 4), %eax	# Leemos el elemento en %eax
	cdq					# Hacemos la extensión
	add   %eax, %ebp	# Sumamos las partes menos significativas
	adc   %edx, %edi	# Sumamos las partes más significativas
	inc   %rsi			# Aumentamos nuestro índice para que el bucle tenga sentido
	cmp   %rsi, %rcx	# Comparamos si el índice es igual a la longitud de la lista para seguir o no en el bucle
	jne    bucle		# Volvemos al bucle

	mov   %edi, %edx
	mov   %ebp, %eax
	ret
