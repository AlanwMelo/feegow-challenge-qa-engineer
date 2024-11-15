# Sugestões
Através deste documento vou listar algumas melhorias que acredito que possam ser implementadas para garantir melhor qualidade na execução dos testes. Todas essas sugestões foram baseadas nos testes realizados neste desafio.

1. **Documentação**: A documentação do sistema, quando bem feita, é o melhor ponto de referência para a criação dos testes. Quanto mais acesso a documentação do sistema, melhor a qualidade dos testes criados.
2. **Ambiente**: Um ambiente de testes onde os análistas de testes tenham total acesso e possam realizar testes exploratórios sem medo de quebrar o sistema é um ponto importante para garantir a qualidade, a possibilidade de interagir direto com o banco, API e o acesso aos logs também se encaixam nesse ponto.
3. **Padronização dos dados**: Tendo como exemplo o retorno da API real (https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica/filter-schedule?PorEspecialidade=96), onde os dados não são padronizados, ressalto que, sempre que possível, os dados devem ser retornados de maneira padrão, o que facilita os testes e o trabalho dos desenvolvedores, uma única consulta a esta API retorna dados estruturados de maneiras diferentes.
- **Lista**:
    ```json
    "2024-12-10": [
                    "08:20:00",
                    "08:40:00",
                    "09:00:00",
                    "09:20:00",
                    "09:40:00",
                    "10:00:00",
                    "10:20:00",
                    "10:40:00",
                    "11:00:00",
                    "11:20:00",
                    "11:40:00",
                    "12:00:00"
                ],
    ```

- **Json**:
    ```json
    "2024-12-03": {
                    "1": "08:40:00",
                    "2": "09:00:00",
                    "3": "09:20:00",
                    "4": "09:40:00",
                    "5": "10:00:00",
                    "6": "10:20:00",
                    "7": "10:40:00",
                    "8": "11:00:00",
                    "9": "11:20:00",
                    "10": "11:40:00",
                    "11": "12:00:00"
                },
    ```
4. **Exposição de APIs**: Sempre que possível, uma API deve ser exposta aos análistas, evitando a realização de fluxos e2e em casos que eles são premissas para a realização de um teste. Por exemplo: Houve a entrega do BUG que remove o bloqueio do cancelamento de uma consulta agendada nos últimos 5 minutos. A API que realiza efetivamente o agendamento poderia ser chamada para que o testador não precise passar por todo o fluxo de agendamento e ir direto a validação necessária. O fluxo e2e seria validado pela automação.