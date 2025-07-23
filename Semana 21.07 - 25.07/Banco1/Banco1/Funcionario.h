#pragma once
#include "Cpf.h"
#include "DiaDaSemana.h"
#include <string>
#include "Pessoa.h"

class Funcionario : public Pessoa<Cpf> {
private:
    float salario;
    // 0 = domingo, 1 = segunda ...
    DiaDaSemana diaPagamento;
public:
    Funcionario(Cpf cpf, std::string nome, float salario, DiaDaSemana diaPagamento);
    float recuperaSalario() const;
    std::string recuperaNome();
    virtual float bonificacao() const = 0;
};
