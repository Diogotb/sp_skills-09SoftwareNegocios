#pragma once
#include <string>
#include <utility>
#include <variant>
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

    enum ResultadoSaque
    {
        /*Sucesso,*/ ValorNegativo, SaldoInsuficiente
    };

    std::variant<ResultadoSaque,float> sacar(float valorASacar);
       //caso de errado mudar para pair
    void depositar(float valorADepositar);
    float recuperaSaldo() const;
    std::string recuperarNumeroConta() const;
    Titular recuperaTitular() const;
    static int recuperaNumeroDeContas();
    void operator+=(float valorADepositar);
    virtual float taxaDeSaque() const = 0;
    bool operator<(const Conta& outra);
    friend std::ostream& operator<<(std::ostream& cout, const Conta& conta);
};
