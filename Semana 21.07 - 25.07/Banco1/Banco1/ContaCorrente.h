#pragma once
#include<iostream>
#include "Conta.hpp"
class ContaCorrente final : public Conta
{
public:
	ContaCorrente(std::string numeroConta, Titular titular);
	float taxaDeSaque() const override;
	void transferePara(Conta& conta, float valor);
	void operator+=(ContaCorrente& contaOrigem);
};

