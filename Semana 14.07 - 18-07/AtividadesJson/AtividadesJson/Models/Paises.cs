using System.Text.Json.Serialization;

namespace AtividadesJson.Models;

internal class Paises
{
    [JsonPropertyName("nome")]
    public string? CountryName { get; set; }
    [JsonPropertyName("capital")]
    public string? Capital { get; set; }
    [JsonPropertyName("populacao")]
    public int? Population { get; set; }
    [JsonPropertyName("continente")]
    public string? Continent { get; set; }
    [JsonPropertyName("idioma")]
    public string? Language { get; set; }

    public void ShowAllTheCountrys()
    {
        Console.WriteLine($"Country Name: {CountryName}");
        Console.WriteLine($"Capital of the Country: {Capital}");
        Console.WriteLine($"Population: {Population}");
        Console.WriteLine($"Continent: {Continent}");
        Console.WriteLine($"Language: {Language}");
    }
}
