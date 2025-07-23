#include "ContaCorrente.h"

ContaCorrente::ContaCorrente(std::string numeroConta, Titular titular) : Conta(numeroConta, titular)
{

}
float ContaCorrente::taxaDeSaque() const
{
	std::cout << "Chamado método sacar da conta corrente" << std::endl;

	return 0.05;
}

void ContaCorrente::transferePara(Conta& destino, float valor)
{
	auto resultado = sacar(valor);

	if (resultado.index() ==1) {
		destino.depositar(valor);
	}
}
void ContaCorrente::operator+=(ContaCorrente& contaOrigem)
{
	contaOrigem.transferePara(*this, contaOrigem.recuperaSaldo() / 2);
}
