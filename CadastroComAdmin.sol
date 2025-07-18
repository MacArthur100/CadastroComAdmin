//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CadastroComAdmin {
    struct Pessoa {
        string nome;
        uint256 idade;
    }

    mapping(address => Pessoa) private pessoas;
    mapping(address => bool) private registrado;

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier apenasAdmin() {
        require(msg.sender == admin, "Apenas o admin pode executar");
        _;
    }

    modifier apenasRegistrado {
        require(registrado[msg.sender], "Usuario nao registrado");
        _;
    }

    event UsuarioRegistrado(address usuario, string nome, uint idade);
    event UsuarioEditado(address usuario, string novoNome, uint256 novaIdade);
    event UsuarioExcluido(address usuario);

    function registrar(string memory _nome, uint256 _idade) public {
        require(!registrado[msg.sender], "Usuario ja registrado");
        require(_idade > 0, "Idade invalida");

        pessoas[msg.sender] = Pessoa(_nome, _idade);
        registrado[msg.sender] = true;

        emit UsuarioRegistrado(msg.sender, _nome, _idade);
    }

    function editarUsuario(address _usuario, string memory _novoNome, uint256 _novaIdade) public apenasAdmin {
        require(registrado[_usuario], "Usuario nao registrado");
        require(_novaIdade > 0, "Idadeinvalida");
        pessoas[_usuario] = Pessoa(_novoNome, _novaIdade);

        emit UsuarioEditado(_usuario, _novoNome, _novaIdade);
}

    function excluirUsuario(address _usuario) public apenasAdmin {
        require(registrado[_usuario], "Usuario nao registrado");

        delete pessoas[_usuario];
        registrado[_usuario] = false;

        emit UsuarioExcluido(_usuario);
    }

    function verUsuario(address _endereco) public view returns (string memory, uint256) {
        require(registrado[_endereco], "Usuario nao registrado");
        Pessoa memory p = pessoas[_endereco];
        return (p.nome, p.idade);
    }
} 