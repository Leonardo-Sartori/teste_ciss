# teste_ciss: Versão 1.0.1

Projeto de teste para a vaga de desenvolvedor mobile - Flutter

## Especificações de desenvolvimento:
    - IDE: VSCode
    - Versão do Flutter: 3.7.9
    - Versão do Dart SDK: 2.19.6 (stable)
    - Versão do Kotlin: 1.7.10
    - Versão do Gradle: 7.2.0

## Escopo inicial:
    - O projeto consiste em um CRUD básico, utilizando como API https://jsonplaceholder.typicode.com/
    - Prototipação básica dos cards https://app.moqups.com/xEfbjppRzpu3Niuxx3DFN6PFvptykBWk/view/page/ad64222d5

## Necessidades iniciais:
    - Listagem de todos os registros;
    - Pesquisa pelo nome/descrição dos registros (posts);
    - Cadastro e Atualização dos registros (posts);
    - Exclusão dos registros (posts);

## Especificações técnicas:
    - Gerenciamento de estado com BLOC;
    - Injeção de dependências com GET IT;

## o que foi desenvolvido:
    - Usuários:
        - Listagem de usuários;
    - Álbuns: 
        - Listagem de álbuns do usuário;
    - Imagens:
        - Listagem de imagens do álbum;
    - Posts:
        - Listagens de posts do usuário;
        - Pesquisa de posts pelo nome e descrição;
        - Criação de novo posto do usuário;
        - Edição de posts do usuário;
        - Exclusão de posts do usuário;
    - Comentários:
        - Listagem de comentários do post;
    - Testes;
        - Widgtet;
        - Integração;

## Considerações sobre o projeto: 
    - A api, permite apenas manipular um crud de posts;
    - A criação de um post, não irá inserir de fato um novo post no banco de dados. Se a request retornar status de sucesso, será retornado um json com os dados enviados no save;
    - A edição e exclusão de um post, se dará da mesma forma que o save, pois não será atualizado ou excluído no banco de dados, mas retornará o post atualizado com os dados enviados na edição ... E no delete, irá retornar o status code. Com base nessas limitações, apenas foi mostrado na tela, o post inserido, atualizado ou deletado;

## Considerações sobre a estrutura e conceitos utilizados no projeto:
    - lib/core/injection:
        - Configurações do GET IT;
    - lib/data/datasources:
        - Fonte de dados: camada central entre a camada de apresentação(presentation) e a camada de dados(JsonPlaceholderApi)
    - lib/data/models:
        - Modelo de dados e propriedade das classes;
    - lib/data/repositories:
        - Camada intermediária entre a camada de negócios e de armazenamento;
        - Repository define um conjunto de métodos que a camada de negócios pode acessar;
        - Repository_impl é responsável por implementar os métodos definidos na Repository;
    - lib/data/services:
        - Configurações das Apis que o app consome;
    - lib/data/presentation/bloc:
        - Nela, contém os arquivos bloc, estados e eventos
    - lib/data/presentation/pages:
        - Camada de apresentação, que contém as classes responsáveis de layout, que possuem interação com o usuário;
    - lib/data/shared:
        - Classes e métodos compartilhados globalmente no app;
    
 