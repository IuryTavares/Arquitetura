.data
	ponteiroVetor: 	.word 0 	
 	msg: 		.asciiz 	"Informe o tamanho do vetor:\n"
 	msg2: 		.asciiz 	"Informe os valores do vetor:\n"
 	msg3:		.asciiz 	"O vetor ordenado e:\n"
 	quebraLinha: 	.asciiz 	"\n\n"
.text 
	#aqui é feita a impressao da mensagem para o usuario
	li $v0, 4	#chamada de exibição
	la $a0, msg
	syscall
	
Loop:	#aqui é feita a leitura do tamanho do vetor 
	li $v0, 5		#chamada de leitura
	syscall
	
	add $s0, $v0, $zero	#salvando o valor de n no registrador s0
	slti $t0, $s0, 2	#se o n é menor do que 15, t0 recebe 1
	addi $t1, $zero, 1
	beq $t0, $t1, Loop	#se o valor de t0 é igual a 1 (n<15) ele faz o loop
	j Continue
	
Continue:	
	add $s1, $s0, $zero	#armazenando o valor de n em s1
	mul $s0, $s0, 4 	#descobrindo a quantidade de bytes
	
	#alocando o vetor
	li $v0, 9
	move $a0, $s0
	syscall
	
	#movendo o ponteiro do vetor para $t0 e colocando-o na variavel
	move $t0, $v0
	la $t1, ponteiroVetor
	sw $t0, 0($t1)
	
	#vetor está alocado na variavel ponteirovetor
	li $v0, 4
	la $a0, quebraLinha
	syscall
	
	la $s0, ponteiroVetor 		# carredando a primeira posição do vetor
	li $t0, 0			# zerando o contador do laço
	
	for: 
	beq $t0, $s1 , exit		# if $t0 == n, desvie para exit
		li $v0, 4		# printa menssagem
		la $a0, msg2
		syscall
		
		li $v0, 5 		# le inteiro
		syscall
		
		sll $t1, $t0, 2 	# calcula o proximo indice do vetor
		add $t1, $t1, $s0	# somando o offset calculado acima			
		sw $v0, 0($t1)		# guardando o dado lido na posição
		addi $t0, $t0, 1	# incrementando contador do for
	j for
exit:
InsertionSort:
	sll $s1,$s1,2
	addi $t0,$zero,0
	For1:
	slt $t7,$t0,$s1
	beq $t7,$zero,end_For1
		lw $t6,ponteiroVetor($t0)
		
		add $t1,$zero,$t0
		add $t2,$zero,$t1
		subi $t2,$t2,4
		For2:
		slt $t7,$zero,$t1
		beq $t7,$zero,end_For2
		
		lw $t3,ponteiroVetor($t2)
		slt $t7,$t3,$t6
		bne $t7,$zero,end_For2
		
			sw $t3,ponteiroVetor($t1)
		subi $t2,$t2,4
		subi $t1,$t1,4
		j For2
		end_For2:
	sw $t6,ponteiroVetor($t1)
	addi $t0,$t0,4
	j For1
	end_For1:
end_InsertionSort:
	addi $t0,$zero,0
	
	for_2:
	slt $t7,$t0,$s1
	beq $t7,$zero,fimDosTempos
	li $v0, 1
	lw $a0,ponteiroVetor($t0)
	syscall
	addi $t0,$t0,4
	j for_2
fimDosTempos:	
