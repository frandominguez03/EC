# Practica 4, Actividad 4.1: explicacion de la bomba
# CONTRASEÑA: picaporte
# PIN: 282
# MODIFICADA: retrovisor
# PIN: 666
# Describe el proceso logico seguido
# primero: para descubrir las claves, y
# despues: para cambiarlas

# Pensado para ejecutar mediante "source explain.gdb"
# o desde linea de comandos con gdb -q -x explain.gdb
# Renombrar temporalmente el fichero "bomba-gdb.gdb"
# para que no se cargue automat. al hacer "file bomba"

# funciona sobre la bomba original, para recompilarla
# usar la orden gcc en la primera linea de bomba.c
# gcc -Og bomba.c -o bomba -no-pie -fno-guess-branch-probability

########################################################

### cargar el programa
	file bomba
### util para la sesion interactiva, no para source/gdb -q -x
# layout asm
# layout regs

### arrancar programa, notar automatizacion para teclear hola y 123
	br main
	run < <(echo -e hola\\n123\\n)

### hicimos ni hasta call boom, antes pide contraseña y tecleamos hola
### si entramos en boom explota y hay que empezar de nuevo
### la decision se toma antes, justo antes de call boom
### hay un je que se salta la bomba, y el test anterior
### activaria ZF si el retorno de strncmp produjera 0,
### es decir, si 0==strncmp(rdi,rsi,edx)
# 0x40122f <main+137>     movslq %eax,%rdx
# 0x401232 <main+140>     lea    0x2e27(%rip),%rcx        # 0x404060 <password>
# 0x401239 <main+147>     movzbl (%rcx,%rdx,1),%ecx
# 0x40123d <main+151>     cmp    %cl,0x30(%rsp,%rdx,1)
# 0x401241 <main+155>     je     0x401248 <main+162> 
# 0x401243 <main+157>     callq  0x401172 <boom>
### avancemos hasta cmp para consultar los valores
	br *main+151
	cont

### escribir "hola" cuando pida contraseña, resuelto ya en run
### ahora mismo estamos viendo de donde sale la contraseña
### 0x401232 <main+140>     lea    0x2e27(%rip),%rcx        # 0x404060 <password>
### imprimir la contraseña y recordar que esta en 0x404060 longitud 13B
	p(char*)0x404060

### Como no es posible modificar ningún registro sobre la marcha para evitar
### que la bomba explote, es necesario cambiar la instruccion 
### 0x401241 <main+155>     je     0x401248 <main+162> por jmp
### Para ello tenemos que ejecutar lo siguiente
### permitir escribir en el ejecutable
	set write on

### reabrir ejecutable con permisos r/w
	file bomba

### Visualizar el salto que queremos cambiar
	x/i 0x401241

### Cambiar el valor de esa dirección a 0xeb
	set {char} 0x401241=0xeb

### salir para desbloquear el ejecutable
	quit

### Más adelante tendremos que hacer los mismos pasos para saltar la bomba
### al introducir el pincode. Ahora que hemos evitado el primer boom()
### tendríamos que valorar qué hacer con la siguiente bomba que es por tiempo.
### Podríamos ahora sí falsear $eax por si hemos tardado en teclear, pero como disponemos
### de 60 segundos para ambas bombas de tiempo (tanto esta como la de pincode), no lo considero necesario

# 0x401295 <main+239>     mov    0xc(%rsp),%eax 
# 0x401299 <main+243>     lea    -0x9(%rax,%rax,1),%eax
# 0x40129d <main+247>     cmp    0x2db5(%rip),%eax        # 0x404058 <passcode>
# 0x4012a3 <main+253>     je     0x4012aa <main+260>
# 0x4012a5 <main+255>     callq  0x401172 <boom>
### Avanzamos entonces hasta que nos pida el pin. Ponemos cualquier valor, por ejemplo '000'.
### Imprimimos el pin introducido con:
	p*(int*) 0x404058

### Ahora sí podemos corregir %eax sobre la marcha para que el cmp salga correcto
	set $eax=000

### Seguimos avanzando con ni hasta que lleguemos a defused. Volvemos a ignorar la bomba por tiempo
### Ya hemos conseguido
### desactivar la bomba
# 0x4012c3 <main+285>     cmp    $0x3c,%rax
# 0x4012c7 <main+289>     jle    0x4012ce <main+296>
# 0x4012c9 <main+291>     callq  0x401172 <boom>
# 0x4012ce <main+296>     callq  0x40118c <defused> 

########################################################
### Una vez ya tenemos en qué posiciones se encuentran la contraseña y el pin, podemos cambiarlos
### con los siguientes comandos desde gdb

### permitir escribir en el ejecutable
	set write on

### reabrir ejecutable con permisos r/w
	file bomba

### realizar los cambios
	set {char[13]}0x404060="retrovisor\n"
	set {int}0x404058=666

### comprobar las instrucciones cambiadas
	p (char[0xd])password
	p (int)passcode

### salir para desbloquear el ejecutable
	quit