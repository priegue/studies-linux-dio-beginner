#!/bin/bash

echo "-------------------------------------"
echo "Criação de usuários em lote.........."
echo "-------------------------------------"

useradd usuario1 -m -c "usuário convidado" -s /bin/bash && printf 'usuario1:Senha123' | chpasswd 
passwd usuario1 -e

useradd usuario2 -m -c "usuário convidado" -s /bin/bash && printf 'usuario2:Senha123' | chpasswd 
passwd usuario2 -e

useradd usuario3 -m -c "usuário convidado" -s /bin/bash && printf 'usuario3:Senha123' | chpasswd 
passwd usuario3 -e

useradd usuario4 -m -c "usuário convidado" -s /bin/bash && printf 'usuario4:Senha123' | chpasswd 
passwd usuario4 -e

useradd usuario5 -m -c "usuário convidado" -s /bin/bash && printf 'usuario5:Senha123' | chpasswd 
passwd usuario5 -e

echo "---------------------"
echo "Criação finalizada!!"
echo "---------------------"
