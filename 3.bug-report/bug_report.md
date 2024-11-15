# Bug Report

## Título do Bug
Consultas não podem ser canceladas antes de 5 minutos após sua criação

---

## Descrição
**Resumo**: 

    Prezados,
    Um pop-up de erro está sendo exibido quando um cliente tenta cancelar uma consulta recentemente criada através do card de informações da consulta na página principal da área do paciente.
    O cancelamento só é realizado com sucesso 5 minutos após o agendamento.

**Impacto**: 

    Mesmo com esse comportamento fazendo parte do escopo inicial do projeto, as clínicas relataram que isto está gerando impacto negativo, pois os clientes podem querer cancelar uma consulta imediatamento por diversos motivos, e ao se depararem com essa situação, não entendem o motivo do ocorrido, o que leva muitos deles a tentar realizar o cancelamento por telefone, gerando trabalho desnecessário aos funcionários da clínica, e também o descontentamento do cliente. 

---

## Passos para Reproduzir
1. Acesse a página principal da "área do paciente".
2. Utilize a API de agendamentos para marcar uma consulta para este cliente.
3. Recarregue a página e tente cancelar a consulta que acabou de ser marcada.
 
---

## Comportamento Esperado
O cliente deve poder cancelar a consulta imediatamento após a sua criação.

---

## Comportamento Atual
O botão de cancelamento exibe um pop-up de erro informando que a ação não pode ser realizada se o cliente tentar cancelar a consulta durante os 5 primeiros minutos após seu agendamento.

---

## Ambiente de Teste
- **Dispositivo**: Desktop
- **Ferramenta**: Postman
- **Sistema Operacional**: Windows 10+, Ubuntu 22.04+ ou MacOs 
- **Navegador**: Google Chrome ou Firefox
- **Ambiente**: Staging

---

## Evidências
[Evidência](https://github.com/AlanwMelo/feegow-challenge-qa-engineer/tree/main/3.bug-report/evidencias/evidencia.webm)

---

## Critérios de Aceitação
- Critério 1: Permitir que uma consulta seja cancelada imediatamente após a criação.
- Critério 2: Garantir que a funcionalidade de cancelamento funcione em todos os dispositivos e navegadores suportados.
- Critério 2: Garantir que todos os lados envolvidos (cliente, clínica e médico) possam realizar o cancelamento nessa situação.

---

## Observações Adicionais
1. A documentação das APIs pode ser encontrada no arquivo /1.documentation/APIs.md.