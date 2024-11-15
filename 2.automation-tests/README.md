# Testes automatizados para o site www.aminhaclinica.com.br

## Descrição

Projeto com as automações para realizar os testes de regressão do site www.aminhaclinica.com.br

## Objetivo

O objetivo desses testes é garantir que nenhuma alteração no código do site gere impactos negativos nas funcionalidades já existentes. No momento os seguintes casos de teste fazem parte do fluxo:
- Agendamento de consulta
- Cancelamento de agendamento

## Pré-requisitos

- Python 3 ou superior (https://www.python.org/downloads/)

## Como instalar

1. **Clone o repositório:**
    `git clone https://github.com/AlanwMelo/feegow-challenge-qa-engineer.git`

2. **Crie um ambiente virtual e ative-o antes de instalar as dependências do projeto:**
    `python3 -m venv myenv`
    `source myenv/bin/activate`

3. **Instale as seguintes dependências necessárias:**[
    `pip install selenium`
    `pip install robotframework`
    `pip install robotframework-seleniumlibrary`
    `pip install robotframework-requests`

## Execução

- Para executar o projeto basta utilizar o comando no CMD:
    `robot ./2.automation-tests/alan/agendamento_cancelamento.robot`
    
- Argumentos podem ser passados para o robot da seguinte maneira:
     `robot --variable CHROME_OPTIONS:"add_argument('--headless') ./2.automation-tests/alan/agendamento_cancelamento.robot`

## Orientações Gerais

- **Contribuições**: Qualquer alteração feita só será aprovada se o pipeline de testes for concluído com sucesso após a mesma.
- **Dúvidas**: Caso tenha alguma dúvida entre em contato com algum dos membros da equipe: contato@equipe.com
