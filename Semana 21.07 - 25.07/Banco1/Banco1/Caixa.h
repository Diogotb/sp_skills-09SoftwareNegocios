#pragma once
#include "Funcionario.h"

class Caixa final : public Funcionario
{
public:
    Caixa(Cpf cpf, std::string nome, float salario, DiaDaSemana diaPagamento);
    float bonificacao() const;
};