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

void RealizaSaque(Conta& conta)
{
    std::variant<Conta::ResultadoSaque, float> resultado = conta.sacar(200);
    if (auto saldo = std::get_if<float>(&resultado)) {
        cout << "Novo saldo da conta:" << std::get<float>(resultado) << endl;
    }
    else {
        std::get<Conta::ResultadoSaque>(resultado);
    }
}

ostream& operator<<(ostream& cout, const Conta& conta)
{
    Pessoa titular = conta.titular;
    cout << "O saldo da conta é (operador): " << conta.recuperaSaldo() << endl;
    cout << "O titular é:" << titular.recuperaNome() << endl;

    return cout;
}

template<typename MeuTipo>
MeuTipo Menor(MeuTipo a, MeuTipo b)
{
    return a < b ? a : b;
}


int main()
{
    Titular titular(Cpf("123.456.789-10"), "Miguel Picinin", "umasenha");

    ContaPoupanca umaConta("123456", titular);
    umaConta.depositar(500);


    Titular outro(Cpf("098.765.432-01"), "Picinin", "outrasenha");
    ContaCorrente umaOutraConta("654321", outro);
    (Conta&)umaOutraConta += 300;

    ContaCorrente outraContaCorrente("132452", titular);

    outraContaCorrente += umaOutraConta;

    cout << umaOutraConta;
    ExibeSaldo(outraContaCorrente);

    cout << "Numero de contas:" << Conta::recuperaNumeroDeContas() << endl;

    Gerente umGerente(Cpf("000.000.000-00"), "NomeDoGerente",1500,DiaDaSemana::Terca,"123456");

    cout << Menor<Conta&>(umaConta, outraContaCorrente);



    return 0;
}
