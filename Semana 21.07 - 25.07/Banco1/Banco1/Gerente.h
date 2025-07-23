#pragma once
#include "DiaDaSemana.h"
#include "Funcionario.h"
#include "Autenticavel.h"
#include <string>

class Gerente final : public Funcionario, public Autenticavel
{
private:
    std::string senha; 
public:
    Gerente(Cpf cpf, std::string nome, float salario, DiaDaSemana diaPagamento, std::string senha);
    float bonificacao() const;
    bool autentica(std::string senha) const; 
};