using System.Text.Json.Serialization;

namespace AtividadesJson.Models;

internal class Filmes
{
    [JsonPropertyName("fulltitle")]
    public string? Titulo { get; set; }
    [JsonPropertyName("year")]
    public string? AnoLancamento { get; set; }
    [JsonPropertyName("crew")]
    public string? Equipe { get; set; }
    [JsonPropertyName("imDbRating")]
    public int? MinhaNota { get; set; }

    public void ExibirDetalhesFilme()
    {
        Console.WriteLine($"Titulo: {Titulo}");
        Console.WriteLine($"Ano de Lançamento: {AnoLancamento}");
        Console.WriteLine($"Equipe de Diretores: {Equipe}");
        Console.WriteLine($"Minha Nota: {MinhaNota}");
    }
}
