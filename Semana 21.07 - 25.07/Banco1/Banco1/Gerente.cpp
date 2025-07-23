#include "Gerente.h"
Gerente::Gerente(Cpf cpf, std::string nome, float salario, DiaDaSemana diaPagamento, std::string senha) : Funcionario(cpf, nome, salario, diaPagamento), Autenticavel(senha)
{
}
float Gerente::bonificacao() const
{
	return recuperaSalario() * 0.5;
}