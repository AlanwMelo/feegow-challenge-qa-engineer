# Pipeline CI/CD para o projeto aminhaclinica

## Objetivo

Este pipeline tem como objetivo garantir a entrega rápida e com qualidade depois de qualquer alteração realizada no código do site (https://minhaclinica.com/)


## Cobertura
Este pipeline contempla os seguintes fluxos:
- Teste 1
- Teste 2
- Teste 3
- Teste 4
- Build
- Deploy

## Detalhamento dos fluxos
  
  - **Teste 1**: O Teste 1 (test_1.yml) tem como objetivo realizar os testes de regressão dos fluxos de agendamento e cancelamento de consultas.
  - **Teste 2**: O Teste 2 (test_2.yml) tem como objetivo fazer alguma coisa bem legal utilizando secrets.
  - **Teste 3**: O Teste 3 (test_3.yml) tem como objetivo fazer alguma coisa bem legal utilizando variáveis de ambiente.
  - **Teste 4**:  
  **Dependências**: O Teste 4 só pode ser executado se os testes 1 e 3 forem executados com sucesso.
  O Teste 4 (test_4.yml) tem como objetivo fazer alguma coisa bem legal utilizando os artefatos gerados no Teste 1.
  - **Build**:  
  **Dependências**: A build só pode ser executada se todos os testes forem executados com sucesso.
  A Build (build.yml) tem como objetivo realizar a build do projeto e deixa-lo pronto para o deploy.
  - **Deploy**:  
  **Dependências**: O deploy só pode ser executado se a build for concluída com sucesso.
  O Deploy (deploy.yml) tem como objetivo realizar utilizar o artefato criado na build para realizar o deploy no host de produção.