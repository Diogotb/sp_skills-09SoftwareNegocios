#pragma once
#include <string>

class Cpf {
private:
    std::string numeros;

public:
    Cpf(); // Default constructor
    explicit Cpf(std::string numeros);
    std::string recuperaNumero() const;
};
