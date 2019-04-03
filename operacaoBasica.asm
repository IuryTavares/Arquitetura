.data

#a = b - (c - d) + e
#a = s0, b = s1, c = s2, d = s3, e = s4
#resolvendo a expressao 
#registradores do tipo T s�o temporarios
#registradores do tipo S s�o temporarios salvo
sub $t1, $s2, $s3 # $t1 = ( $s2 - $s3 ) � o mesmo que $t1 = ( c - d )
sub $t2, $s1, $t1 # $t2 = $s1 - $t1 � o mesmo que $t2 = b - ( c - d )
add $s0, $t2, $s4 # $s0 = $t2 + $s4 � o mesmo que $s0 = b - ( c - d ) + e

#melhorando o c�digo com ec�nomia de registrador
sub $t1, $s2, $s3     # $t1 = ( $s2 - $s3 ) � o mesmo que $t1 = ( c - d )
sub $t1, $s1, $t1    # $t1 = $s1 - $t1 � o mesmo que $t1 = b - ( c - d )
add $s0, $t1, $s4     # $s0 = $t1 + $s4 � o mesmo que $s0 = b - ( c - d ) + e

#Considere os seguintes registradores para cada vari�vel:
# a = $s0, b = $s1, c = $s2, d = $s3, e = $s4, f = $s5.

sub $s0, $s1, $s2