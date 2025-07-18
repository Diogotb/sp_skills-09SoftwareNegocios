using ExerciciosLinq.Models;

using ExerciciosLinq.Models;
using System.Collections.Generic;

List<NumerosInteiros> minhaListaDeNumeros = new()
{
    new NumerosInteiros { Numeros = 1 },
    new NumerosInteiros { Numeros = 2 },
    new NumerosInteiros { Numeros = 3 },
    new NumerosInteiros { Numeros = 4 },
    new NumerosInteiros { Numeros = 5 },
    new NumerosInteiros { Numeros = 4 }
};

List<Livros> livrosDisponiveis = new()
{
    new Livros { Titulo = "O Pequeno Príncipe", Autor = "Antoine de Saint-Exupéry", Ano = 1943 },
    new Livros { Titulo = "1984", Autor = "George Orwell", Ano = 1949 },
    new Livros { Titulo = "Dom Casmurro", Autor = "Machado de Assis", Ano = 1899 },
    new Livros { Titulo = "Harry Potter e a Pedra Filosofal", Autor = "J.K. Rowling", Ano = 2007 },
    new Livros { Titulo = "O Senhor dos Anéis", Autor = "J.R.R. Tolkien", Ano = 2001 }
};

List<Produtos> produtosEmEstoque = new()
{
    new Produtos { Nome = "Smartphone X", Preco = 1800.50m },
    new Produtos { Nome = "Fone Bluetooth", Preco = 250.99m },
    new Produtos { Nome = "Carregador Rápido", Preco = 89.90m },
    new Produtos { Nome = "Teclado Sem Fio", Preco = 150.00m },
    new Produtos { Nome = "Mouse Ergonômico", Preco = 75.25m }
};