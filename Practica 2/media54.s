# Práctica 5.4 - Media y resto de N enteros con signo de 32 bits calculada usando registros de 32 bits
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
			.int 1, 2, 1, 2
			.int 1, 2, 1, 2
			.int 1, 2, 1, 2
			.int 1, 2, 1, 2
	#elif TEST==2
			.int -1, -2, -1, -2
			.int -1, -2, -1, -2
			.int -1, -2, -1, -2
			.int -1, -2, -1, -2
	#elif TEST==3
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
			.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
	#elif TEST==4
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
			.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
	#elif TEST==5
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
			.int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
	#elif TEST==6
			.int 2000000000, 2000000000, 2000000000, 2000000000
			.int 2000000000, 2000000000, 2000000000, 2000000000
			.int 2000000000, 2000000000, 2000000000, 2000000000
			.int 2000000000, 2000000000, 2000000000, 2000000000
	#elif TEST==7
			.int 3000000000, 3000000000, 3000000000, 3000000000
			.int 3000000000, 3000000000, 3000000000, 3000000000
			.int 3000000000, 3000000000, 3000000000, 3000000000
			.int 3000000000, 3000000000, 3000000000, 3000000000
	#elif TEST==8
			.int -2000000000, -2000000000, -2000000000, -2000000000
			.int -2000000000, -2000000000, -2000000000, -2000000000
			.int -2000000000, -2000000000, -2000000000, -2000000000
			.int -2000000000, -2000000000, -2000000000, -2000000000
	#elif TEST==9
			.int -3000000000, -3000000000, -3000000000, -3000000000
			.int -3000000000, -3000000000, -3000000000, -3000000000
			.int -3000000000, -3000000000, -3000000000, -3000000000
			.int -3000000000, -3000000000, -3000000000, -3000000000
	#elif TEST>=10 && TEST<=14
			.int 1, 1, 1, 1
			.int 1, 1, 1, 1
			.int 1, 1, 1, 1
	#elif TEST>=15 && TEST<=19
			.int -1, -1, -1, -1
			.int -1, -1, -1, -1
			.int -1, -1, -1, -1
	#else
			.error "Definir un valor entre 1 y 19"
	#endif
			.endm

		  .macro linea0
	#if TEST>= 1 && TEST<=9
			linea
	#elif TEST==10
			.int 0, 2, 1, 1
			linea
	#elif TEST==11
			.int 1, 2, 1, 1
			linea
	#elif TEST==12
			.int 8, 2, 1, 1
			linea
	#elif TEST==13
			.int 15, 2, 1, 1
			linea
	#elif TEST==14
			.int 16, 2, 1, 1
			linea
	#elif TEST==15
			.int 0, -2, -1, -1
			linea
	#elif TEST==16
			.int -1, -2, -1, -1
			linea
	#elif TEST==17
			.int -8, -2, -1, -1
			linea
	#elif TEST==18
			.int -15, -2, -1, -1
			linea
	#elif TEST==19
			.int -16, -2, -1, -1
			linea
	#else
			.error "Definir un valor entre 1 y 19"
	#endif
			.endm

lista:		linea0
longlista:  .int   (.-lista)/4
media: 		.int 0
resto: 		.int 0
formato:	.ascii "media \t = %11d \t resto \t = %11d    \n"
			.asciz 		 "\t = 0x %08x \t 	 \t = 0x %08x \n"

# Para saber como se compila el programa
# opción: 4) usar tb main
# 4) gcc media.s -o media -no-pie				8664 B

.section .text
main:   .global  main

# Trabajar

	mov     $lista, %rbx
	mov  longlista, %ecx
	call suma		# == suma(&lista, longlista);
	mov  %eax, media
	mov  %edx, resto

# Imprimir_C
	mov   $formato, %rdi
	mov   media,%rsi
	mov   resto,%rdx
	mov   media,%ecx
	mov   resto,%r8d
	mov          $0,%eax	# varargin sin xmm
	call  printf		# == printf(formato, res, res);

# Acabar_C
	mov  $0, %edi
	call _exit		# ==  exit(resultado)
	ret

suma:
	mov  $0, %eax	# Nuestro índice
	mov  $0, %edx	# Índice de destino
	mov  $0, %rsi	# Índice 
	mov  $0, %ebp	# Acumulador
	mov  $0, %edi 	# Acumulador

bucle:
	mov  (%rbx, %rsi, 4), %eax	# Leemos el elemento en %eax
	cltd						# Ponemos los bits de %rdx a 0
	add   %eax, %ebp			# Sumamos las partes menos significativas
	adc   %edx, %edi			# Sumamos las partes más significativas
	mov   %edi, %edx 			# Copiamos %edx a %edi para realizar la división
	mov   %ebp, %eax			# Copiamos %eax a %ebp para realizar la división
	idiv  %ecx, %eax			# División con signo
	inc   %rsi					# Aumentamos nuestro índice para que el bucle tenga sentido
	cmp   %rsi, %rcx			# Comparamos si el índice es igual a la longitud de la lista para seguir o no en el bucle
	jne    bucle				# Volvemos al bucle

	ret

