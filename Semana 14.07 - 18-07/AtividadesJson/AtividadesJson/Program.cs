//Endpoint para o Json de Filmes
using AtividadesJson.Models;
using System.Text.Json;

using (HttpClient client = new HttpClient())
{
    try
    {
        string resposta = await client.GetStringAsync("https://raw.githubusercontent.com/ArthurOcFernandes/Exerc-cios-C-/curso-4-aula-2/Jsons/TopMovies.json");
        var filmes = JsonSerializer.Deserialize<List<Filmes>>(resposta)!;
        Console.WriteLine(filmes.Count);
        filmes[2].ExibirDetalhesFilme();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Temos um problema: {ex.Message}");
    }
}
// endpoint para o Json de Paises
using (HttpClient client = new HttpClient())
{
    try
    {
        string resposta = await client.GetStringAsync("https://raw.githubusercontent.com/ArthurOcFernandes/Exerc-cios-C-/curso-4-aula-2/Jsons/Paises.json");
        var paises = JsonSerializer.Deserialize<List<Paises>>(resposta)!;
        Console.WriteLine(paises.Count);
        paises[1].ShowAllTheCountrys();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Temos um problema: {ex.Message}");
    }
}
//endpoint para o json de carros
using (HttpClient client = new HttpClient())
{
    try
    {
        string resposta = await client.GetStringAsync("https://raw.githubusercontent.com/ArthurOcFernandes/Exerc-cios-C-/curso-4-aula-2/Jsons/Carros.json");
        var carros = JsonSerializer.Deserialize<List<Carros>>(resposta)!;
        Console.WriteLine(carros.Count);
        carros[4].MostrarDetalhesCarros();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Temos um problema: {ex.Message}");
    }
}
//Endpoint para o Json de Livors
using (HttpClient client = new HttpClient())
{
    try
    {
        string resposta = await client.GetStringAsync("https://raw.githubusercontent.com/ArthurOcFernandes/Exerc-cios-C-/curso-4-aula-2/Jsons/Livros.json");
        var livros = JsonSerializer.Deserialize<List<Livros>>(resposta)!;
        Console.WriteLine(livros.Count);
        livros[4].MostarDetalhesLivro();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Temos um problema: {ex.Message}");
    }
}

//endpoint GoT
using (HttpClient client = new HttpClient())
{
    try
    {
        string resposta = await client.GetStringAsync("https://www.anapioficeandfire.com/api/characters/16");
        var margaery = JsonSerializer.Deserialize<List<Personagem>>(resposta)!;
        margaery[0].MostrarDetalhesPersonagem();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Temos um problema: {ex.Message}");
    }
}



// ps: Existem dois erros, 1 no primeiro e 1 no ultimo endpoint, mas é por causa dos jsons