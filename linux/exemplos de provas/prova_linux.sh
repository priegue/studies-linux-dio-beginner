#!/bin/bash

# Cores para saída
VERDE="\e[32m"
VERMELHO="\e[31m"
AZUL="\e[34m"
AMARELO="\e[33m"
NEUTRO="\e[0m"

# Diretório para armazenar prova
DIR_PROVA="prova_de_comandos"

# Cria o diretório da prova se não existir
mkdir -p "$DIR_PROVA"

acertos=0
erros=0

# Questões e comandos reais para executar dentro do dir
perguntas=(
"Digite o comando para criar um diretório chamado 'teste'."
"Digite o comando para criar um arquivo vazio chamado 'arquivo1.txt'."
"Digite o comando para listar os arquivos no diretório atual."
"Digite o comando para remover o arquivo 'arquivo1.txt'."
"Digite o comando para remover o diretório 'teste'."
)

comandos=(
"mkdir teste"
"touch arquivo1.txt"
"ls"
"rm arquivo1.txt"
"rmdir teste"
)

descricoes=(
"Cria um diretório."
"Cria um arquivo vazio."
"Lista arquivos e diretórios."
"Remove um arquivo."
"Remove um diretório vazio."
)

function limpar_tela {
    clear
}

function executar_comando_real {
    # Executa comando dentro do diretório prova_de_comandos e captura saída e erros
    # Recebe comando completo como argumento
    local cmd="$1"
    # Executa no contexto do diretório da prova
    (cd "$DIR_PROVA" && eval "$cmd" 2>/dev/null)
}

function mostrar_conteudo_final {
    echo ""
    echo -e "${AMARELO}Conteúdo atual de '$DIR_PROVA':${NEUTRO}"
    ls -l "$DIR_PROVA"
    echo ""
}

# Loop das questões
for i in "${!perguntas[@]}"; do
    repetir_questao=true
    while $repetir_questao; do
        limpar_tela
        echo -e "${AZUL}=============================="
        echo -e "     Prova de Comandos Linux"
        echo -e "==============================${NEUTRO}"
        echo ""
        echo -e "${AMARELO}Questão $((i+1)) de ${#perguntas[@]}${NEUTRO}"
        echo -e "Descrição: ${descricoes[$i]}"
        echo -e "Pergunta: ${perguntas[$i]}"
        echo ""
        echo -en "usuario@servidor1:~$ "
        read resposta

        if [[ "$resposta" == "${comandos[$i]}" ]]; then
            # Executa o comando no diretório prova_de_comandos
            executar_comando_real "$resposta"
            echo -e "${VERDE}✅ Resposta correta!"
            echo -e "Parabéns: Comando '${resposta}' executado.${NEUTRO}"
            echo ""
            ((acertos++))

            # Pergunta se deseja finalizar ou continuar (exceto última questão)
            if [[ $i -lt $(( ${#perguntas[@]} - 1 )) ]]; then
                echo -e "1) Finalizar a prova agora"
                echo -e "Pressione Enter para continuar para a próxima questão."
                read -p "Escolha uma opção: " opcao
                if [[ "$opcao" == "1" ]]; then
                    mostrar_conteudo_final
                    # Apaga a prova e sai
                    rm -rf "$DIR_PROVA"
                    echo -e "${AMARELO}Diretório '$DIR_PROVA' apagado. Saindo...${NEUTRO}"
                    exit 0
                fi
            else
                # Última questão, vai para opções finais
                repetir_questao=false
            fi
            repetir_questao=false

        elif [[ "$resposta" == "não sei" ]]; then
            ((erros++))
            echo -e "${VERMELHO}❌ Resposta correta é: ${comandos[$i]}${NEUTRO}"
            echo -e "${VERMELHO}📚 Estude mais um pouco e tente novamente.${NEUTRO}"
            echo ""
            echo -e "1) Tentar novamente"
            echo -e "2) Sair (apaga a prova)"
            read -p "Escolha uma opção: " opcao
            if [[ "$opcao" == "2" ]]; then
                mostrar_conteudo_final
                rm -rf "$DIR_PROVA"
                echo -e "${AMARELO}Diretório '$DIR_PROVA' apagado. Saindo...${NEUTRO}"
                exit 0
            fi
        else
            ((erros++))
            echo -e "${VERMELHO}❌ Resposta incorreta.${NEUTRO}"
            echo ""
            echo -e "1) Tentar novamente"
            echo -e "2) Sair (apaga a prova)"
            read -p "Escolha uma opção: " opcao
            if [[ "$opcao" == "2" ]]; then
                mostrar_conteudo_final
                rm -rf "$DIR_PROVA"
                echo -e "${AMARELO}Diretório '$DIR_PROVA' apagado. Saindo...${NEUTRO}"
                exit 0
            fi
        fi
    done
done

# Final da prova
while true; do
    limpar_tela
    echo -e "${AZUL}=============================="
    echo -e "        Prova finalizada"
    echo -e "==============================${NEUTRO}"
    echo -e "✅ Acertos = ${VERDE}$acertos${NEUTRO}"
    echo -e "❌ Erros = ${VERMELHO}$erros${NEUTRO}"
    mostrar_conteudo_final
    echo -e "1) Apagar o diretório da prova e sair"
    echo -e "2) Sair sem apagar o diretório"
    echo -en "Escolha uma opção: "
    read escolha
    case $escolha in
        1)
            rm -rf "$DIR_PROVA"
            echo -e "${AMARELO}Diretório '$DIR_PROVA' apagado. Saindo...${NEUTRO}"
            exit 0
            ;;
        2)
            echo -e "${AMARELO}Saindo sem apagar o diretório '$DIR_PROVA'.${NEUTRO}"
            exit 0
            ;;
        *)
            echo -e "${VERMELHO}Opção inválida. Tente novamente.${NEUTRO}"
            sleep 1
            ;;
    esac
done
