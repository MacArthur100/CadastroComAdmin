Detalhamento do contrato linha a linha:
---

### 🧠 **Exercício 09 - Contrato: `CadastroSimplesComSenha` (linha a linha e comandos explicados)**

```solidity
// SPDX-License-Identifier: MIT
```

* **SPDX License Identifier**: Indica a licença de uso do contrato. `"MIT"` é uma licença permissiva muito usada em software livre. Essa linha não afeta o funcionamento do contrato, serve para informar direitos autorais.

---

```solidity
pragma solidity ^0.8.0;
```

* **Pragma**: Define a versão mínima do compilador Solidity exigida para compilar este contrato. Aqui, o contrato requer compiladores `0.8.0` ou superiores (mas não maiores que `0.9.0`, por padrão).
* Isso é importante para evitar problemas de compatibilidade ou mudanças na linguagem.

---

```solidity
contract CadastroSimplesComSenha {
```

* **Definição do contrato**: Cria um novo contrato chamado `CadastroSimplesComSenha`. Tudo dentro das chaves `{}` pertence a esse contrato.

---

```solidity
    struct Pessoa {
        string nome;
        uint idade;
        bytes32 senhaHash;
    }
```

* **Struct**: Define uma estrutura personalizada chamada `Pessoa`.
* Essa estrutura tem três campos:

  * `nome`: uma string que armazena o nome da pessoa.
  * `idade`: um número inteiro positivo.
  * `senhaHash`: o hash da senha da pessoa (usamos hash para proteger a senha real).

---

```solidity
    mapping(address => Pessoa) public pessoas;
```

* **Mapping**: Um tipo de armazenamento onde cada endereço (`address`) mapeia para uma `Pessoa`.
* `public`: torna esse mapeamento acessível externamente — qualquer um pode ver os dados de uma `Pessoa` associada a um endereço.
* Exemplo: `pessoas[0xABC...123]` retorna a struct `Pessoa` daquele endereço.

---

```solidity
    function cadastrar(string memory _nome, uint _idade, string memory _senha) public {
```

* **Função `cadastrar`**: pública, qualquer pessoa pode chamá-la.
* Parâmetros:

  * `_nome`: nome do usuário.
  * `_idade`: idade.
  * `_senha`: senha em texto puro (que será convertida em hash).
* `memory`: indica que a string é armazenada temporariamente (durante a execução da função).

---

```solidity
        pessoas[msg.sender] = Pessoa(_nome, _idade, keccak256(abi.encodePacked(_senha)));
```

* Cria ou sobrescreve uma entrada no mapping `pessoas` usando `msg.sender` como chave (ou seja, quem chamou a função).
* Armazena uma struct `Pessoa` com:

  * Nome: `_nome`.
  * Idade: `_idade`.
  * SenhaHash: `keccak256(...)` gera um hash da senha usando codificação `abi.encodePacked(...)`.
* **keccak256**: algoritmo de hash usado no Ethereum (semelhante ao SHA-3), garante que a senha não seja armazenada em texto claro.

---

```solidity
    }
```

* Fim da função `cadastrar`.

---

```solidity
    function verificarSenha(string memory _senha) public view returns (bool) {
```

* Função pública de **leitura** (`view`) — não altera o estado do contrato.
* Retorna um `bool` (verdadeiro/falso) dizendo se a senha informada está correta.
* Parâmetro:

  * `_senha`: senha em texto puro para verificação.

---

```solidity
        return pessoas[msg.sender].senhaHash == keccak256(abi.encodePacked(_senha));
```

* Compara o hash da senha informada com o hash salvo para o `msg.sender`.
* Se for igual, retorna `true`. Senão, `false`.

---

```solidity
    }
```

* Fim da função `verificarSenha`.

---

```solidity
}
```

* Fim do contrato.

---

### ✅ **Resumo geral do funcionamento**

| Função           | Ação                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------- |
| `cadastrar`      | Permite que qualquer endereço registre seu nome, idade e senha criptografada                |
| `verificarSenha` | Permite que o próprio usuário verifique se a senha que forneceu bate com a senha cadastrada |

---

### 🧩 **Conceitos Importantes Usados**

* `msg.sender`: endereço da carteira que executa a função.
* `mapping`: estrutura de chave-valor.
* `struct`: estrutura de dados personalizada.
* `memory`: armazenamento temporário em função.
* `keccak256`: função de hash.
* `abi.encodePacked`: converte múltiplos dados em uma sequência binária (útil antes de hashear).


