# EventsApi

[![Build Status](https://www.travis-ci.com/gissandrogama/events.svg?branch=main)](https://www.travis-ci.com/gissandrogama/events)

[![codecov](https://codecov.io/gh/gissandrogama/events/branch/main/graph/badge.svg?token=Q0BTSNAXN4)](https://codecov.io/gh/gissandrogama/events)

Desafio **bac-kend** que o objetivo é criar uma API cadastrar e listar eventos. Proposto pela [softaliza](https://softaliza.com.br/)

# Informacoes Tecnicas
* credo para garantir qualidade
* Sobelow para segurança
* Arquivos licença e log para processo de qualidade de projeto
* Coveralls e codecov manter cobertura e relatório de testes
* Travis para CI e CD

## Iniciando a api localmente

**1.** Clone o projeto:

 * ssh
```sh
$ git clone git@github.com:gissandrogama/events.git
```

 * https
```sh
$ git clone https://github.com/gissandrogama/events.git
```

**2.** Acesse a pasta do projeto:

```sh
$ cd events_api
```

**3.** Instale as dependências:

```sh
$ mix deps.get
```

**4.** criar e migrar o banco de dados, e inserir dados do db.json:

```sh
$ mix ecto.setup
```

**6.** gerar chave se segurança para configurar no arquivo .env:

```sh
$ mix phx.gen.secret
```

**7.** gerar chave se segurança do guardian configurar no arquivo .env:

```sh
$ mix guardian.gen.secret
```

**8.** configurar endereço do banco de dados no arquivo .env, isso para o ambiente de produção.

- conforme exemplos no arquivo `.env.example`

**9.** carregar as variáveis do arquivo .env:

```sh
$ source .env
```

**10.** inicie o endpoit phoenix com:

```sh
$ mix phx.sever
```

# Sobre API

Como foi requisitado nas especificações das funcionalidades do teste, a api possui os seguintes endpoints: **users**, **events**, **signin**:

Metodo | endpoint   | descrição | valores que podem ser passados para os parametros
-------|--------- | ----------------------- | --------------
post | /api/users | nesse endpoint é possivel criar um usuário | name, email e password
get | /api/users/:id | listar um usuário pelo id | id
post | /api/signin | atenticar um usuário | email e password
post | /api/events | esse endpoint cria um evento | title, date_initial, date_finish, description,start_time, end_time, place, andress, url_img
get | /api/events/:id | lista um evento pelo id | id do evento
get | /api/events | lista todos os eventos |


caso queira usar o insomnia, segue um arquivo já com as rotas para ultilizar
[arquivo insomnia](./insomnia.json). É só importar esse arquivo para o insomnia.

# Deploy
A aplicação está no gigalixir no endereço <https://events.gigalixirapp.com/api/events>. Um dos motivos de escolher o gigalixir é que não tem sleeps da aplicação no plano free.

# Gerar documentação da aplicação

```sh
$ mix docs
```
