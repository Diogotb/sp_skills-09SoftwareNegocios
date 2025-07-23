#pragma once
#include <string>
#include "Cpf.h"

class Pessoa
{
protected:
    std::string nome;
    Cpf cpf;

public:
    Pessoa(Cpf cpf, std::string nome);
    std::string recuperaNome() const;
    Cpf recuperaCpf() const;

private:
    void verificaTamanhoDoNome();
};
