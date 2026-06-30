# Light Kernel

Light Kernel é um projeto de kernel/bootloader x86_64 em desenvolvimento com foco em aprendizado.

## Visão Geral

Este projeto constrói uma imagem ISO inicializável para um kernel/bootloader personalizado chamado Light Kernel.
O objetivo principal é aprender os conceitos de:

- bootloader e processo de inicialização
- desenvolvimento em assembly e C de baixo nível
- uso de um ambiente de compilação cruzada
- geração de imagem ISO inicializável com GRUB

## Estrutura do Repositório

- `Dockerfile` - imagem base com compiladores cruzados e ferramentas necessárias instaladas
- `docker-compose.yaml` - sobe o container de desenvolvimento e monta o projeto em `/root/env`
- `Makefile` - regras de compilação, linkedição e geração da ISO
- `linker.ld` - script de linkedição para produzir o binário do kernel
- `src/` - código-fonte
  - `boot/` - arquivos de assembly do bootloader
  - `headers/` - cabeçalhos para fontes em C
  - `libs/` - bibliotecas de suporte
  - `main.c` - ponto de entrada/implementação principal em C
- `build/` - diretório de objetos compilados
- `out/` - diretório da ISO final gerada
- `target/` - arquivos de boot intermediários

## Ambiente de Desenvolvimento

Inicie o container Docker com:

```bash
docker compose up --build
```

Entre no shell do container em execução com:

```bash
docker compose exec dev bash
```

## Instruções de Build

Dentro do container, execute:

```bash
make build
```

Isso irá:

1. compilar os fontes em assembly e C para `build/`
2. linkar o binário do kernel em `target/boot/kernel.bin`
3. gerar a ISO inicializável em `out/kernel.iso`

## Executar

Use QEMU para rodar a ISO gerada:

```bash
make run
```

## Limpar

Remova os artefatos de build com:

```bash
make clean
```

## Sobre o Projeto

Light Kernel é um projeto de estudo e experimentação. O foco é entender como um kernel simples é construído e inicializado.

Qualquer contribuição é bem-vinda. Se você quiser ajudar com código, documentação, correções ou melhorias, sinta-se à vontade para colaborar.
