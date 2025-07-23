#include "Funcionario.h"
#include "Pessoa.h"
#include <iostream>

Funcionario::Funcionario(Cpf cpf, std::string nome, float salario, DiaDaSemana diaPagamento) :Pessoa(cpf, nome), salario(salario), diaPagamento(diaPagamento)
{
    std::cout << "Construtor de Funcionario" << std::endl;
}

float Funcionario::recuperaSalario() const
{
    return salario;
}

std::string Funcionario::recuperaNome()
{
    return std::string();
}