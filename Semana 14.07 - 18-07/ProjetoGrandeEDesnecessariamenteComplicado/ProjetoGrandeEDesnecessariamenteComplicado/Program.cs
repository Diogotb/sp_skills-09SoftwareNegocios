//Irei pegar apenas o começo pois não tenho ideia por onde começar
using ProjetoGrandeEDesnecessariamenteComplicado.Models;
using System.Text.Json;
using System.Threading.Channels;

Pessoa pessoa = new Pessoa();
Console.WriteLine("Digite o nome: ");
pessoa.Nome = Console.ReadLine();
Console.WriteLine("Digite a Idade: ");
pessoa.Idade = int.Parse(Console.ReadLine());
Console.WriteLine("Digite o email: ");
pessoa.Email = Console.ReadLine();

string jsonString = JsonSerializer.Serialize(pessoa);

string fileName = "pessoa.json";

File.WriteAllText(fileName, jsonString);

Console.WriteLine($"Os dados foram salvos em {fileName}");

//parte 3
//List<Pessoas> pessoas = new List<Pessoas>();

//while(true)
//{
//    Pessoa pessoa = new Pessoa();
//    Console.WriteLine("Digite o nome (Ou 'sair' para encerrar): ");
//    string nome = Console.ReadLine();

//    if (nome.ToLower == "sair")
//        break;

//    pessoa.Nome = nome;
//    Console.WriteLine("Digite a Idade: ");
//    pessoa.Idade = int.Parse(Console.ReadLine());
//    Console.WriteLine("Digite o email: ");
//    pessoa.Email = Console.ReadLine();

//    pessoas.Add(pessoa);
//}

//string jsonString = JsonSerializer.Serialize(pessoas);

//string fileName = "pessoas.json";

//File.WriteAllText(fileName, jsonString);


//Console.WriteLine($"Os dados foram salvos em {fileName}");

//parte 5 

string fileName = "pessoas.json";

if (File.Exists(fileName))
{
    string jsonString = File.ReadAllText(fileName);

    List<Pessoa> pessoas = JsonSerializer.Deserialize<List<Pessoa>>(jsonString);
    Console.WriteLine("Digite a idade para buscar pessoas: ");
    int idadeParaBuscar = int.Parse(Console.ReadLine());

    List<Pessoa> pessoasComIdade = pessoas.Where(p => p.Idade == idadeParaBuscar).ToList();

    if(pessoasComIdade.Any())
    {
        Console.WriteLine($"Pessoas com {idadeParaBuscar} anos :");

        foreach (Pessoa pessoa  in pessoasComIdade)
        {
            Console.WriteLine($"Nome: {pessoa.Nome}, Idade: {pessoa.Idade}, Email: {pessoa.Email}");
        }
    }
    else
    {
        Console.WriteLine($"O arquivo {fileName} não existe.");

    }
}