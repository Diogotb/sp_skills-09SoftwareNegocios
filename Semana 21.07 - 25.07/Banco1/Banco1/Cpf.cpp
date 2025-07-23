#include "Cpf.h"

Cpf::Cpf() : numeros("") // Initialize to an empty string
{
}

Cpf::Cpf(std::string numeros) : numeros(numeros)
{
}

std::string Cpf::recuperaNumero() const
{
    return numeros;
}
