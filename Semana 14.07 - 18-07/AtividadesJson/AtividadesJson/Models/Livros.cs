using System.Text.Json.Serialization;

namespace AtividadesJson.Models;

internal class Livros
{
    [JsonPropertyName("titulo")]
    public string? Titulo { get; set; }
    [JsonPropertyName("autor")]
    public string? Autor { get; set; }
    [JsonPropertyName("ano_publicacao")]
    public int? AnoPublicacao { get; set; }
    [JsonPropertyName("genero")]
    public string? Genero { get; set; }
    [JsonPropertyName("paginas")]
    public int? Paginas { get; set; }
    [JsonPropertyName("editora")]
    public string? Editora { get; set; }

    public void MostarDetalhesLivro()
    {
        Console.WriteLine($"Titulo: {Titulo}");
        Console.WriteLine($"Autor: {Autor}");
        Console.WriteLine($"Ano de Publicação: {AnoPublicacao}");
        Console.WriteLine($"Genero(s): {Genero}");
        Console.WriteLine($"Quantidade de Paginas: {Paginas}");
        Console.WriteLine($"Editora: {Editora}");
    }
}
