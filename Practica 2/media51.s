# gcc media.s -o media -no-pie

.section .data
lista:		.int 0x10000000,0x10000000,0x10000000,0x10000000
		.int 0x10000000,0x10000000,0x10000000,0x10000000
		.int 0x10000000,0x10000000,0x10000000,0x10000000
		.int 0x10000000,0x10000000,0x10000000,0x10000000
longlista:	.int   (.-lista)/4
resultado:	.quad   0
  formato: 	.asciz	"suma = %lu = 0x%lx hex\n"

# Para saber como se compila el programa
# opción: 4) usar tb main
# 4) gcc media.s -o media -no-pie				8664 B

.section .text
main:   .global  main

# Trabajar
	mov     $lista, %rbx
	mov  longlista, %ecx
	call suma		# == suma(&lista, longlista);
	mov  %edx, resultado+4

# Imprimir_C
	mov   $formato, %rdi
	mov   resultado,%rsi
	mov   resultado,%rdx
	mov          $0,%eax	# varargin sin xmm
	call  printf		# == printf(formato, res, res);

# Acabar_C
	mov  resultado, %edi
	call _exit		# ==  exit(resultado)
	ret

suma:	
	mov  $0, %edx
	mov  $0, %eax
	mov  $0, %rsi
bucle:
	add  (%rbx,%rsi,4), %eax
	jnc   .acarreo
	inc   %edx
	ret
.acarreo:
	inc   %rsi
	cmp   %rsi,%rcx
	jne    bucle
