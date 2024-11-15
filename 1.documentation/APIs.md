# APIs do projeto
Este documento tem o objetivo de listar e explicar como funcionasm as APIs deste projeto.

### API de Agendamento
Esta API usa os dados enviados e, se o horário estiver disponível, efetua um agendamento.

- **Endpoint**: `10.152.269:8080/agendar`
- **Tipo**: `POST`
- **Request**:
```json
{
  "nome": "João da Silva",
  "email": "joao.silva@email.com",
  "cpf": "123.456.789-00",
  "telefone": "(11) 98765-4321",
  "especialidade": "Cardiologia",
  "medico": "Dr. Carlos Santos",
  "data_hora": "2024-12-01T10:00:00",
  "acao": "cria-agendamento"
}
```
---

### API de Cancelamento
Esta API usa os dados enviados e, se existir agendamento, cancela o mesmo.

- **Endpoint**: `10.152.269:8080/cancelar`
- **Tipo**: `POST`
- **Request**:
```json
{
  "nome": "João da Silva",
  "email": "joao.silva@email.com",
  "cpf": "123.456.789-00",
  "telefone": "(11) 98765-4321",
  "especialidade": "Cardiologia",
  "medico": "Dr. Carlos Santos",
  "data_hora": "2024-12-01T10:00:00",
  "acao": "cancela-agendamento"
}
```
----

### API de Horários Reservados
Esta API retorna os agendamentos já existentes.

- **Endpoint**: `10.152.269:8080/horarios-reservados`
- **Tipo**: `GET`
- **Response**:
```json
{
    "status": "sucesso",
    "reservas":[
       {
        "nome": "João da Silva",
        "email": "joao.silva@email.com",
        "cpf": "123.456.789-00",
        "telefone": "(11) 98765-4321",
        "especialidade": "Cardiologia",
        "medico": "Dr. Carlos Santos",
        "data_hora": "2024-12-01T10:00:00"
       }, 
       {
        "nome": "João da Silva",
        "email": "joao.silva@email.com",
        "cpf": "123.456.789-00",
        "telefone": "(11) 98765-4321",
        "especialidade": "Cardiologia",
        "medico": "Dr. Carlos Santos",
        "data_hora": "2024-12-01T10:00:00"
       } 
    ]
}
```
---

### API de Horários Disponíveis
Esta API retorna os horários disponíveis para agendamentos.

- **Endpoint**: `10.152.269:8080/horarios-disponiveis`
- **Tipo**: `GET`
- ***Request**:
```json
{
    "status": "sucesso",
    "reservas":[
       {
        "especialidade": "Cardiologia",
        "medico": "Dr. Carlos Santos",
        "data_hora": "2024-12-01T10:00:00"
       }, 
       {
        "especialidade": "Cardiologia",
        "medico": "Dr. Carlos Santos",
        "data_hora": "2024-12-01T10:00:00"
       } 
    ]
}
```