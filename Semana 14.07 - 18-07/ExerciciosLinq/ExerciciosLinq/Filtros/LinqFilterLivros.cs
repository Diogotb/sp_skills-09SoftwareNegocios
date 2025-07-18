using ExerciciosLinq.Models;

namespace ExerciciosLinq.Filtros;

internal class LinqFilterLivros
{
    public static void FiltrarLivroAposAnosMM(List<Livros> livros, int anoLancamento)
    {
        var LivrosAposMM = livros.Where(livros => livros.Ano!.Equals(anoLancamento > 2000)).Select(livros => livros.Ano).Distinct().ToList();
        Console.WriteLine("Filtrando Livro Apenas para livors depois dos anos 2000");
        foreach (var livro in LivrosAposMM)
        {
            Console.WriteLine($"-{livro}"); 
        }
    }
}

//Resposta dadas
//List<Livro> livros = new List<Livro>
//{
//    new Livro { Titulo = "Aprendendo LINQ", Autor = "João Silva", AnoPublicacao = 2005 },
//    new Livro { Titulo = "Programação em C#", Autor = "Ana Oliveira", AnoPublicacao = 2010 },
//    new Livro { Titulo = "Algoritmos e Estruturas de Dados", Autor = "Carlos Santos", AnoPublicacao = 1998 },
//    new Livro { Titulo = "Introdução à Inteligência Artificial", Autor = "Mariana Costa", AnoPublicacao = 2021 },
//    new Livro { Titulo = "Design Patterns", Autor = "Paulo Rocha", AnoPublicacao = 2002 }
//};

//    var titulosLivros = livros
//        .Where(l => l.AnoPublicacao > 2000)
//        .OrderBy(l => l.Titulo)
//        .Select(l => l.Titulo);

//Console.WriteLine("Títulos de livros publicados após 2000, ordenados alfabeticamente:");
//foreach (var titulo in titulosLivros)
//{
//    Console.WriteLine(titulo);
//}
