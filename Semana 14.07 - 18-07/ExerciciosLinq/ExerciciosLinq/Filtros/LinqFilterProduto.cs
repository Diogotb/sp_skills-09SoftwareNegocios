using ExerciciosLinq.Models;

namespace ExerciciosLinq.Filtros;

internal class LinqFilterProduto
{
    public static void FiltrarPorPrecoMedio(List<Produtos> produtos, List<Produtos>produtosEmEstoque, decimal preco)
    {
        var precoMedioProduto = produtos.Average(p => p.Preco);
        Console.WriteLine($"Preco Medio dos Produtos é {precoMedioProduto}");
    }
}

//Resposta dada

//List<Produto> produtos = new List<Produto>
//        {
//            new Produto { Nome = "Laptop", Preco = 1200 },
//            new Produto { Nome = "Smartphone", Preco = 800 },
//            new Produto { Nome = "Tablet", Preco = 500 },
//            new Produto { Nome = "Câmera", Preco = 300 }
//        };

//    var precoMedio = produtos.Average(p => p.Preco);

//        Console.WriteLine("Preço médio dos produtos: " + precoMedio);