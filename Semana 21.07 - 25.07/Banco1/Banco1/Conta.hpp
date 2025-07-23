#pragma once
#include <string>
#include "Titular.h"

class Conta {
private:
    std::string numeroConta;
    Titular titular;
protected: // Change to protected
    float saldo; // Now accessible in derived classes
    static int numeroDeContas;

public:
    Conta(std::string numeroConta, Titular titular);
    virtual ~Conta();

    void sacar(float valorASacar);
    void depositar(float valorADepositar);
    float recuperaSaldo() const;
    std::string recuperarNumeroConta() const;
    Titular recuperaTitular() const;
    static int recuperaNumeroDeContas();
    void operator+=(float valorADepositar);
    virtual float taxaDeSaque() const = 0;
};
