using System.Text.Json.Serialization;

namespace AtividadesJson.Models;

internal class Personagem
{
    [JsonPropertyName("name")]
    public string? Nome { get; set; }
    [JsonPropertyName("gender")]
    public string? Genero { get; set; }
    [JsonPropertyName("culture")]
    public string? Cultura { get; set; }
    [JsonPropertyName("born")]
    public string? Nascimento { get; set; }
    [JsonPropertyName("titles")]
    public string? Titulos { get; set; }
    [JsonPropertyName("playedBy")]
    public string? Atuado { get; set; }

    public void MostrarDetalhesPersonagem()
    {
        Console.WriteLine($"Nome: {Nome}");
        Console.WriteLine($"Genero: {Genero}");
        Console.WriteLine($"Data de Nascimento: {Nascimento}");
        Console.WriteLine($"Cultura: {Cultura}");
        Console.WriteLine($"Titulos: {Titulos}");
        Console.WriteLine($"Atuado por: {Atuado}");
    }
}
