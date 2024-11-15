# Plano de Teste para Sistema de Agendamento de Consultas

## Objetivo do Teste
Este plano de teste visa assegurar a qualidade do sistema de agendamento de consultas para clínicas e profissionais de saúde, garantindo que funcionalidades críticas estejam operando conforme esperado e que potenciais falhas sejam identificadas e priorizadas com base em risco.

---

## Escopo do Teste
### Funcionalidades a serem testadas:
1. Agendamento de nova consulta.
2. Cancelamento de consulta existente.
3. Exibição de horários disponíveis.
4. Tentativa de agendamento em horário já ocupado.
5. Restrição de cancelamento para consultas criadas recentemente.

### Funcionalidades fora do escopo:
- Alteração de dados do usuário.
- Integração com outros sistemas de saúde externos.

---

## Estratégia de Teste
O sistema será testado utilizando diferentes tipos de testes para cobrir todas as camadas de funcionalidade:
- **Testes Unitários**: Validar funcionalidades isoladas, como a lógica de validação de datas e horários.
- **Testes de Integração**: Garantir que a integração entre duas partes diferentes do sistema está funcionando da maneira esperada.
- **Testes Funcionais**: Garantir que as interações entre o frontend e o backend estejam funcionando conforme o esperado, especialmente para o carregamento e verificação de horários.
- **Testes End-to-End**: Validar os fluxos completos do usuário, incluindo agendamento e cancelamento de consultas.

---

## Priorização dos Testes - Matriz de Risco

| ID    | Caso de Teste                                        | Probabilidade (1-5) | Impacto (1-5) | Nível de Risco (P x I) | Prioridade |
|-------|---------------------------------------------------   |-------------------- |---------------|----------------------- |------------|
| TC001 | Validar horários disponíveis (API)                   | 5                   | 5             | 25                     | Alta       |
| TC002 | Validar horários disponíveis                         | 5                   | 5             | 25                     | Alta       |
| TC003 | Validação API de agendamentos (horário disponível)   | 4                   | 5             | 20                     | Alta       |
| TC004 | Validação API de agendamentos (horário indisponível) | 4                   | 5             | 20                     | Alta       |
| TC005 | Agendar uma nova consulta (API)                      | 4                   | 5             | 20                     | Alta       |
| TC006 | Agendar uma nova consulta                            | 4                   | 5             | 20                     | Alta       |
| TC007 | Validação dos campos no fluxo de agendamento         | 3                   | 5             | 15                     | Média      |
| TC008 | Cancelar uma consulta existente (API)                | 2                   | 3             | 6                      | Baixa      |
| TC009 | Cancelar uma consulta existente                      | 2                   | 3             | 6                      | Baixa      |
| TC010 | Erro ao tentar agendar em horário ocupado            | 1                   | 5             | 5                      | Baixa      |
| TC011 | Restrição de cancelamento para consultas recentes    | 1                   | 3             | 3                      | Baixa      |

> **Notas**: A matriz de risco ajuda a priorizar os casos de teste com base na probabilidade de falha e no impacto dessa falha. A prioridade dos testes é definida conforme o nível de risco, com testes de alta prioridade executados primeiro para reduzir o risco de problemas críticos no sistema.

---

## Casos de Teste Principais

| ID    | Caso de Teste                                | Descrição                                                                 | Tipo de Teste    | Prioridade |
|-------|----------------------------------------------|---------------------------------------------------------------------------|----------------- |------------|
| TC001 | Validar horários disponíveis (API)           | Testar se os horários disponíveis estão sendo retornados                  | Unitário         | Alta       |
| TC002 | Validar horários disponíveis                 | Testar se os horários disponíveis estão sendo retornados                  | Funcional        | Alta       |
| TC003 | Validação API de agendamentos (disponível)   | Validar se a API de agendamentos está funcionando corretamente            | Integração       | Alta       |
| TC004 | Validação API de agendamentos (indisponível) | Validar se a API de agendamentos está funcionando corretamente            | Integração       | Alta       |
| TC005 | Agendar uma nova consulta (API)              | Testar se o usuário consegue agendar uma nova consulta                    | Unitário         | Alta       |
| TC006 | Agendar uma nova consulta                    | Testar se o usuário consegue agendar uma nova consulta                    | End-to-End (UAT) | Alta       |
| TC007 | Validação dos campos no fluxo de agendamento | Validar se o formatador de dados dos campos está funcionando corretamente | Integração       | Média      |

---

## Critérios de Aceitação

### Definição de Pronto (DoD)
- Todos os casos de teste prioritários (alta e média prioridade) foram executados com sucesso.
- Não há bugs críticos ou bloqueantes no sistema de agendamento de consultas.
- Todas as funcionalidades principais foram validadas para garantir a experiência do usuário.

### Critérios de Aceitação por Caso de Teste
1. **Validar horários disponíveis (API)**: A API deve retornar datas disponíveis para agendamento.
2. **Validar horários disponíveis**: O sistema deve exibir corretamente no front os horários disponíveis.
3. **Validação API de agendamentos (horário disponível)**: O sistema deve consultar corretamente os dados de um agendamento.
4. **Validação API de agendamentos (horário indisponível)**: O sistema deve consultar corretamente os dados de um agendamento.
5. **Agendar uma nova consulta (API)**: O sistema deve permitir o agendamento em qualquer horário disponível. 
6. **Agendar uma nova consulta**: O sistema deve permitir o agendamento em qualquer horário disponível.
7. **Validação dos campos no fluxo de agendamento**: O sistema deve analisar corretamente as entradas e impedir o avanço em caso de erro.
8. **Cancelar uma consulta existente (API)**: O sistema deve permitir o cancelamento de uma consulta agendada sem falhas.
9. **Cancelar uma consulta existente**: O sistema deve permitir o cancelamento de uma consulta agendada sem falhas.
10. **Erro ao tentar agendar em horário ocupado**: O sistema deve exibir uma mensagem de erro ao tentar agendar em um horário já ocupado.
11. **Restrição de cancelamento para consultas recentes**: O sistema deve impedir o cancelamento de consultas criadas nos últimos 5 minutos.

---

## Ambiente de Teste
- **Dispositivo**: Desktop
- **Ferramenta**: Postman
- **Sistema Operacional**: Windows 10+, Ubuntu 22.04+ ou MacOs 
- **Navegador**: Google Chrome ou Firefox
- **Ambiente**: Staging

---

## Observações Adicionais
Este plano de teste serve como uma diretriz para assegurar a funcionalidade crítica do sistema de agendamento de consultas. A priorização baseada em risco permite um foco maior em áreas que podem afetar a experiência do usuário de forma significativa.

---

# Casos de teste

## TC001 - Validar horários disponíveis 

### Pré condições
1. API de horários disponíveis devidamente configurada.
2. Utilizar a API de horários disponíveis.

> **Obs**: A documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Realizar uma chamada a API de horários disponíveis

### Resultado esperado
1. A API deve retornar uma lista com os horários disponíveis para agendamento.

---

## TC002 - Validar horários disponíveis 

### Pré condições
1. Todos os sistemas devem estar inteiramente disponíveis.
2. Utilizar a API de horários reservados.

> **Obs**: Existe uma API para a realização de agendamentos, a documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Escolher dois ou mais agendamentos retornados pela API
1. Acessar o site de agendamentos (https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica).
2. Selecionar a especialidade desejada.
3. Selecionar a clínica desejada.
4. Escolher a unidade desejada.
5. Validar os horários retornados.

### Resultado esperado
1. Nenhum dos horários escolhidos deve ser exibido na lista de horários disponíveis.

---

## TC003 - Validação API de agendamentos (horário disponível)

### Pré condições
1. API de agendamentos devidamente configurada.
2. Dados validos para um agendamento (nome, email, cpf e telefone, dados do agendamento).

> **Obs**: Existe uma API que retorna os dados de agendamentos disponíveis, a documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Realizar uma chamada a API de agendamentos com um horário disponível.
2. Realizar uma consulta no banco de dados na tabela de agendamentos com os dados do agendamento testado.

### Resultado esperado
1. O retorno da API deve ser 200 - Sucesso, hoŕario disponível
2. Uma nova linha deve ser criada na tabela com os dados do agendamento efetuado.

---

## TC004 - Validação API de agendamentos (horário indisponível)

### Pré condições
1. API de agendamentos devidamente configurada.
2. Dados validos para um agendamento (nome, email, cpf e telefone, dados do agendamento).

> **Obs**: Existe uma API que retorna os dados de agendamentos efetuados, a documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Realizar uma consulta no banco de dados na tabela de agendamentos com os dados do agendamento testado.
2. Realizar uma chamada a API de agendamentos com um horário indisponível.
3. Realizar uma nova consulta no banco de dados na tabela de agendamentos com os dados do agendamento testado.

### Resultado esperado
1. Deve existir uma linha na tabela com os dados do agendamento testado.
2. O retorno da API deve ser 200 - Sucesso, hoŕario indisponível
2. A linha existente na tabela não foi alterada.

---

## TC005 - Agendar uma nova consulta (API)

### Pré condições
1. API de horários agendamento devidamente configurada.
2. Utilizar um cliente com dados válidos (nome, email, cpf e telefone).
3. Utilizar a API de agendamentos disponíveis para encontrar um horário disponínel

> **Obs**: A documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Realizar uma chamada a API de agendamento

### Resultado esperado
1. A API deve retornar 200, Sucesso, Agendamento efetuado.

---

## TC006 - Agendar uma nova consulta

### Pré condições
1. Todos os sistemas devem estar inteiramente disponíveis.
2. Utilizar um cliente com dados válidos (nome, email, cpf e telefone).
3. Utilizar a API de agendamentos disponíveis para encontrar um horário disponínel

> **Obs**: A documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Acessar o site de agendamentos (https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica).
2. Selecionar a especialidade desejada.
3. Clicar no botão "Agendar um horário".
4. Escolher a unidade desejada.
5. Escolher o médico e o horário desejados.
6. Preencher os campos com os dados do cliente.
7. Clicar no botão "Agendar Consulta"
8. Realizar uma chamada a API de verificação de horário com os dados do agendamento.

### Resultado esperado
1. Um pop-up informando que o agendamento foi efetuado deve ser exibido.
2. Após o agendamento o cliente foi redirecionado para a tela principal.
3. O horário retornado pela API de agendamentos disponíveis foi exibido.
4. O retorno da API de verificação de horário deve informar que horário está reservado.

---

## TC007 - Validação dos campos no fluxo de agendamento

### Pré condições
1. Todos os sistemas devem estar inteiramente disponíveis.
2. Cliente na tela de confirmação de dados.

### Passos
1. Preencher os campos de cadastro com informações inválidas (ex: Faltando quantidade mínima de dígitos, em branco, etc)
2. Clicar no botão de "Confirmar Agendamento"

### Resultado esperado
1. Um pop-up informando que os dados estão inválidos deve ser exibido.
2. O cliente deve permanecer na mesma tela.
3. Os campos que estavam inválidos devem agora estar sublinhados em vermelho.

---

## TC008 - Cancelar uma consulta existente (API)

### Pré condições
1. API de cancelamento devidamente configurada.
2. Dados validos para um agendamento (nome, email, cpf e telefone, dados do agendamento).

> **Obs**: Existe uma API que retorna os dados de agendamentos efetuados, a documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Realizar uma consulta na tabela de agendamentos com os dados do agendamento
2. Realizar uma chamada a API de cancelamento com os dados do agendamento.
3. Realizar uma nova consulta a tabela de agendamentos com os dados do agendamento.

### Resultado esperado
1. Deve existir uma linha na tabela com os dados do agendamento testado.
2. O retorno da API deve ser 200 - Sucesso, agendamento cancelado.
2. A linha não deve mais ser retornada.

---
## TC009 - Cancelar uma consulta existente 

### Pré condições
1. Todos os sistemas devem estar inteiramente disponíveis.
2. Utilizar um cliente com dados válidos (nome, email, cpf e telefone) e com um horário agendado.
3. O teste só pode ser efetuado após 5 minutos de um agendamento, conforme regra de negócio.

> **Obs**: Existe uma API para a realização de agendamentos, a documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Acessar o site de agendamentos (https://www.aminhaclinica.com.br/).
2. Clicar na opção "área do cliente".
3. Preencher os dados do cliente.
4. Clicar no botão "Entrar".
5. Preencher o código enviado por email.
6. Clicar no botão "Entrar".
7. Clicar no botão de cancelar do card com as informações do agendamento.
8. Clicar no botão de confirmação.
9. Realizar uma chamada a API de verificação de horário com os dados do agendamento cancelado.


### Resultado esperado
1. O card de agendamento deve apresentar as informações corretas relacionadas ao agendamento.
2. Ao clicar no botão de confirmação, um pop-up deve ser exibido informando que o agendamento foi cancelado.
3. O card de agendamento não deve mais ser exibido.
4. Realizar uma chamada a API de verificação de horário e garantir que horário está disponível.
5. O retorno da API de verificação de horário deve informar que horário está livre.

---

## TC010 - Erro ao tentar agendar em horário ocupado

### Pré condições
1. Todos os sistemas devem estar inteiramente disponíveis.
2. Utilizar um cliente com dados válidos (nome, email, cpf e telefone).
3. Utilizar a API de agendamenos disponíveis para encontrar um horário disponínel.

> **Obs**: A documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Acessar o site de agendamentos (https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica).
2. Selecionar a especialidade desejada.
3. Clicar no botão "Agendar um horário".
4. Escolher a unidade desejada.
5. Escolher o médico e o horário desejados.
6. Preencher os campos com os dados do cliente.
7. Chamar a API de agendamento informando os dados deste agendamento.
8. Clicar no botão "Agendar Consulta".
9. Clilcar no botão de confirmação.

### Resultado esperado
1. Ao chamar a API de agendamento, um agendamento deve ser efetudado.
2. Ao clicar no botão de "Agendar Consulta" um pop-up deve aparecer informando que o agendamento não está mais disponível.
3. Ao clicar no botão de confirmação o cliente deve ser levado de volta a tela de horários.

---

## TC011 - Restrição de cancelamento para consultas recentes

### Pré condições
1. Todos os sistemas devem estar inteiramente disponíveis.
2. Utilizar um cliente com dados válidos (nome, email, cpf e telefone) e com um horário agendado.
3. O teste deve ser efetuado 5 minutos após um agendamento, conforme regra de negócio.

> **Obs**: Existe uma API para a realização de agendamentos, a documentação das APIs pode ser encontrada no arquivo APIs.md.

### Passos
1. Acessar o site de agendamentos (https://www.aminhaclinica.com.br/).
2. Clicar na opção "área do cliente".
3. Preencher os dados do cliente.
4. Clicar no botão "Entrar".
5. Preencher o código enviado por email.
6. Clicar no botão "Entrar".
7. Vizualizar o card com as informações do agendamento.

### Resultado esperado
1. O card de agendamento deve apresentar as informações corretas relacionadas ao agendamento.
2. O botão de cancelar agendamento não deve ser exibido.