#include <iostream>
#include <string>
#include "Titular.h"
#include "Conta.hpp"
#include "ContaPoupanca.h"
#include "ContaCorrente.h"
#include "Cpf.h"
#include "Autenticavel.h"
#include "Funcionario.h"
#include "Gerente.h"
#include "Caixa.h"

using namespace std;

void ExibeSaldo(const Conta& conta)
{
    cout << "O saldo da conta é: " << conta.recuperaSaldo() << endl;
}

void FazLogin(Autenticavel& alguem, string senha)
{
    if (alguem.autentica(senha)) {
        cout << "Login realizado com sucesso" << endl;
    }
    else {
        cout << "Senha invalida" << endl;
    }
}

int main()
{
    Titular titular(Cpf("123.456.789-10"), "Miguel Picinin", "umasenha");

    ContaPoupanca umaConta("123456", titular);
    umaConta.depositar(500);
    umaConta.sacar(200);

    ExibeSaldo(umaConta);

    Titular outro(Cpf("098.765.432-01"), "Picinin", "outrasenha");
    ContaCorrente umaOutraConta("654321", outro);
    umaOutraConta += 300;

    ContaCorrente outraContaCorrente("132452", titular);

    umaOutraConta.transferePara(outraContaCorrente, 250);

    ExibeSaldo(umaOutraConta);
    ExibeSaldo(outraContaCorrente);

    cout << "Numero de contas:" << Conta::recuperaNumeroDeContas() << endl;

    Gerente umGerente(Cpf("000.000.000-00"), "NomeDoGerente",1500,DiaDaSemana::Terca,"123456");

    return 0;
}
