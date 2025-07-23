#include "Conta.hpp"
#include <iostream>

int Conta::numeroDeContas = 0;

Conta::Conta(std::string numeroConta, Titular titular) :
    numeroConta(numeroConta),
    titular(titular),
    saldo(0)
{
    numeroDeContas++;
}

Conta::~Conta()
{
    std::cout << "Destrutor da Conta chamado" << std::endl;
    numeroDeContas--;
}



void Conta::sacar(float valorASacar)
{
    if (valorASacar < 0) {
        std::cout << "Não pode sacar valor negativo" << std::endl;
        return;
    }

    float tarifaDeSaque = valorASacar * taxaDeSaque(); // Cast to float
    float valorDoSaque = valorASacar + tarifaDeSaque;

    if (valorDoSaque > saldo) {
        std::cout << "Saldo Insuficiente" << std::endl;
        return;
    }
    saldo -= valorDoSaque;
}

void Conta::depositar(float valorADepositar)
{
    if (valorADepositar < 0) {
        std::cout << "Não pode depositar valor negativo" << std::endl;
        return;
    }
    saldo += valorADepositar;
}

float Conta::recuperaSaldo() const
{
    return saldo; // This method is already defined
}


std::string Conta::recuperarNumeroConta() const
{
    return numeroConta;
}

Titular Conta::recuperaTitular() const
{
    return titular;
}

int Conta::recuperaNumeroDeContas()
{
    return numeroDeContas;
}

void Conta::operator+=(float valorADepositar)
{
    depositar(valorADepositar);
}
