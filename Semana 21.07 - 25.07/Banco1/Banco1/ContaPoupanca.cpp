#include "ContaPoupanca.h"
#include <iostream>

ContaPoupanca::ContaPoupanca(std::string numero, Titular titular) : Conta(numero, titular)
{
}
float ContaPoupanca::taxaDeSaque() const
{
    std::cout << "Chamado método sacar da conta poupanca" << std::endl;

    return 0.03;
}
