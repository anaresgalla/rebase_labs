# Rebase Labs

- A app lista resultados de exames médicos, bem como as informações do paciente.

### Premissa principal 

- A app não é feita em Rails, segue o padrão Sinatra do projeto.

### Pré-requisitos

- Ter o Docker instalado.

### Passos

1. Clonar o repositório:
```bash
    git clone https://github.com/anaresgalla/rebase_labs.git
    cd Rebase-Labs
```

2. Iniciar os contâineres:
Isso iniciará os contêineres Docker definidos no arquivo docker-compose.yml. 
O comando --build reconstrói as imagens Docker antes de iniciar os contêineres.
```bash
    docker-compose up --build
```

3. Para executar os testes:
- Abra um shell interativo dentro do contêiner rebase_labs_rebase-challenge_1:
```bash
    docker exec -it rebase_labs_rebase-challenge_1 bash
```
- Rode os testes com o comando:
```bash
    rspec
```

4. Encerrar e Remover os contêineres:
```bash
    docker-compose down
```

### O banco de dados persiste para uso.