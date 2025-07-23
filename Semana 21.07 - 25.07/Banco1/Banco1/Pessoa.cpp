#include "Pessoa.h"
#include <iostream>

Pessoa::Pessoa(Cpf cpf, std::string nome) :nome(nome), cpf(cpf)
{
    std::cout << "Construtor de Pessoa" << std::endl;
}

void Pessoa::verificaTamanhoDoNome()
{
    if (nome.size() < 3) {
        std::cout << "Nome muito curto" << std::endl;
        exit(1);
    }
}

Cpf Pessoa::recuperaCpf() const
{
    return cpf;
}

std::string Pessoa::recuperaNome() const
{
    return nome;
}
