#include "Caixa.h"


Caixa::Caixa(Cpf cpf, std::string nome, float salario, DiaDaSemana diaPagamento) : Funcionario(cpf,nome,salario, diaPagamento)
{
}

float Caixa::bonificacao() const
{
	return recuperaSalario() * 0.1f;
}