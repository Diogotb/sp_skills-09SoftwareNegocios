#pragma once
#include <string>
#include <iostream>
#include "Cpf.h"

template<typename Documento>
class Pessoa
{
protected:
    std::string nome;
    Documento documento;

public:
    Pessoa(Documento documento, std::string nome) :nome(nome),documento(documento)
    {
        std::cout << "Construtor de Pessoa" << std::endl;
    }
    std::string recuperaNome() const {
        return nome;
    }
    
private:
    void verificaTamanhoDoNome()
    {
        if (nome.size() < 3) {
            std::cout << "Nome muito curto" << std::endl;
            exit(1);
        }
    }
    
};
