using ProjetoGrandeEDesnecessariamenteComplicado.Models;
using System.Text.Json;

string fileName = File.ReadAllText(fileName);

if (File.Exists(fileName))
{
    string jsonString = File.ReadAllText(fileName);
    Pessoa pessoa = JsonSerializer.Deserialize<Pessoa>(jsonString);

    Console.WriteLine($"Nome: {pessoa.Nome}");
    Console.WriteLine($"Idade: {pessoa.Idade}");
    Console.WriteLine($"Email: {pessoa.Email}");
}
else
{
    Console.WriteLine($"O arquivo {fileName} não existe");
}

//parte 4 

//string fileName = File.ReadAllText(fileName);

//if (File.Exists(fileName))
//{
//    string jsonString = File.ReadAllText(fileName);
    
//    List<Pessoa> pessoas = JsonSerializer.Deserialize<List<Pessoa>>(jsonString);

//    Console.WriteLine("Informações das pessoas");

//    foreach (Pessoa pessoa in pessoas)
//    {
//        Console.WriteLine($"Nome: {pessoa.Nome}, Idade: {pessoa.Idade}, Email: {pessoa.Email}");
//    }
//}
//else
//{
//    Console.WriteLine($"O arquivo {fileName} não existe");
//}