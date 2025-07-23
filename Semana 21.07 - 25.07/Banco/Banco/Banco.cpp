#include <iostream>
#include <string>
#include "Banco.h"

using namespace std;

struct Conta
{
    string numeroConta;
    string cpfTitular;
    string nomeTitular;
    float saldo;

    void sacar(Conta& conta, float valorASacar)
    {
        if (valorASacar < 0) {
            cout << "Não pode sacar valor negativo" << endl;
            return;
        }
        if (valorASacar > conta.saldo) {
            cout << "Saldo Insuficiente" << endl;
            return;
        }
        conta.saldo -= valorASacar;
    }

    void depositar(Conta& conta, float valorADepositar)
    {
        if (valorADepositar < 0) {
            cout << "Não pode depositar valor negativo" << endl;
            return;
        }
        conta.saldo += valorADepositar;
    }
};


int main()
{
    Conta umaConta;
    umaConta.numeroConta = "123456";
    umaConta.cpfTitular = "123.456.789-10";
    umaConta.nomeTitular = "Miguel";
    umaConta.saldo = 100;

    Conta umaOutraConta;
    umaOutraConta.saldo = 200;

    depositar(umaOutraConta, 500);

    cout << "Uma conta:" << umaConta.saldo << "umaOutraConta:" << umaOutraConta.saldo << endl;

    return 0;
}