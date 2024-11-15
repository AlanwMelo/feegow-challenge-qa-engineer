# Apresentação
Olá, sou o Alan e vou utilizar este documento para justificar minhas decisões tomadas neste projeto.

## Formato do test plan
Ao ler e analisar o test plan deixado como exemplo, considerei o mesmo de alta qualidade, por isso optei por manter o mesmo, realizando somente as alterações necessárias.

### Alterações
1. **Alteração na descrição dos tipos de teste**:
    - A descrição do teste funcional estava ausente, deixando implícito que o mesmo faz parte de um teste de integração. Mesmo essa informação sendo correta, preferi segmentar o mesmo e explicar que ele é usado para validações de integração mais relacionadas a UX.

2. **Criação de APIs fictícias**:
    - Levando em consideração todo o cenário apresentado, decidi criar exemplos simples de APIs que provavelmente fariam parte do sistema e por isso precisariam ser testadas. Além disso, a exposição dessas APIs à equipe de testes pode acelerar os testes, evitando a necessidade de passar por todo o fluxo de front como pré-requisito de um teste.

3. **Criação dos test cases**:
    - Utilizando minha experiência, tentei criar um test suite simples, mas que englobaria de maneira eficiente todas as funcionalidades apresentadas nesse desafio. Utilizei diversos tipos de teste para tentar criar uma situação mais próxima da real possível, começando por testes de API, passando por integração, funcionalidade e terminando em e2e.

4. **Alteração da Matriz de Riscos**:
    - Novamente baseando-me de minha experiência, procurei usar meu senso crítico para tentar ponderar da melhor maneira possível quais os pesos de cada teste. Depois de definir os pesos, fazer os cálculos e reorganizar a tabela, acredito que fiz uma boa decisão e os testes foram bem priorizados.

5. **Alteração nos Casos de Teste Principais**:
    - Utilizando as novas informações da nova matriz, foi relativamente simples realizar essas alterações e também fiquei contente com o resultado.

6. **Alteração nos critérios de aceitação**:
    - Como criei novos casos, precisei adicionar os mesmos a esta sessão.

7. **Alteração no Ambiente de Teste**: 
    - No momento, não há nenhum tipo de validação que precisa ser feita via celular, e também acredito que para isso deva ser feito um test plan exclusivo, por isso optei por remover o mesmo. Também adicionei o postman como ferramenta para a realização dos testes de API.