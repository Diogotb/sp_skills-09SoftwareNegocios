#include "Titular.h"
#include <iostream>

void Titular::verificaTamanhoDoNome()
{
    if (nome.size() < 5) {
        std::cout << "Nome muito curto " << std::endl;
        exit(1);
    }
}

Titular::Titular(Cpf cpf, std::string nome, std::string senha) : Pessoa(cpf, nome), Autenticavel(senha)
{
    verificaTamanhoDoNome();
}

Cpf Titular::recuperaCpf() const
{
    return Pessoa::recuperaCpf();
}

std::string Titular::recuperarNome() const
{
    return nome; // Return the member variable 'nome'
}
