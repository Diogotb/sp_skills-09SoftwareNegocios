#pragma once
#include <string>
#include "Cpf.h"
#include "Pessoa.h"
#include "Autenticavel.h"

class Titular : public Pessoa<Cpf>, public Autenticavel {
private:
    void verificaTamanhoDoNome();

public:
    Titular(Cpf cpf, std::string nome, std::string senha);
    Cpf recuperaCpf() const;
    std::string recuperarNome() const;
};
