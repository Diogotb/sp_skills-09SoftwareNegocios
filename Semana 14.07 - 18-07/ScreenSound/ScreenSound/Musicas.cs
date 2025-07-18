using System.IO.Pipes;
using System.Threading.Channels;
using static System.Net.Mime.MediaTypeNames;

class Musica
{
    public Musica(Banda artista, string nome)
    {
        Artista = artista;
        Nome = nome;
    }

    public string Nome { get; }
    public Banda Artista { get; }
    public Genero Genero { get; set; }
    public int Duracao { get; set; }
    public bool Disponivel { get; set; }

    public string DescricaoResumida
    {
        get
        {
            return $"A musica {Nome} pertence a banda {Artista}";
        }
    }



    public void ExibirFichaTecnica()
    {
        Console.WriteLine($"Nome: {Nome}");
        Console.WriteLine($"Artista: {Artista.Nome}");
        Console.WriteLine($"Duração: {Duracao}");
        if (Disponivel)
        {
            Console.WriteLine("Disponivel no Plano");
        }
        else
        {
            Console.WriteLine("Adquira o plano Plus+");
        }
    }
}


//////// Desafio 1

////class ContaBancaria
////{
////    public int numeroIndicador {  get; set; }
////    public string titular { get; set; }
////    public int saldo { get; set; }
////    public int senha { get; set; }

////    public void ExibirInfosContas()
////    {
////        Console.WriteLine($"Numero Indicador: {numeroIndicador}");
////        Console.WriteLine($"Titular: {titular}");
////        Console.WriteLine($"Saldo: {saldo}");
////        Console.WriteLine($"Senha: {senha}");

////    }
////}

//////// Desafio 2

////class Carro
////{
////    private int ano;
////    public string Fabricante { get; set; }
////    public string Modelo { get; set; }
////    public int Ano
////    {
////        get => ano;
////        set
////        {
////            if (value < 1960 || value > 2023)
////            {
////                Console.WriteLine("Valor inválido, insira um ano entre 1960 e 2023");
////            }
////            else
////            {
////                ano = value;
////            }
////        }
////    }
////    public int QuantidadePortas { get; set; }
////    public string DescricaoDetalhada => $"Modelo do carro: {this.Fabricante} {this.Modelo} {this.Ano}";
////}

//////Desafio 3
////class Produto
////{
////    private double preco;
////    private int estoque;
////    public string Nome { get; set; }
////    public string Marca { get; set; }
////    public double Preco
////    {
////        get => preco;
////        set
////        {
////            if (value > 0)
////                preco = value;
////            else
////                preco = 10;
////        }
////    }

////    public int Estoque
////    {
////        get => estoque;
////        set
////        {
////            if (value > 0)
////                estoque = value;
////            else
////                estoque = 0;

////        }
////    }

////    public string DescricaoProduto => $"{this.Nome} {this.Marca} - {this.Preco}";

////}

//////Desafio 4
////class Titular
////{
////    public string Nome { get; set; }
////    public string Cpf { get; set; }
////    public string Endereco { get; set; }
////}

////class Conta
////{
////    public Titular Titular { get; set; }
////    public int Agencia { get; set; }
////    public int NumeroDaConta { get; set; }
////    public double Saldo { get; set; }
////    public double Limite { get; set; }

////    public string Informacoes => $"Conta nº {this.NumeroDaConta}, Agência {this.Agencia}, Titular: {this.Titular.Nome} - Saldo: {this.Saldo}";
////}
////Titular t = new();
////Conta c = new();

////t.Nome = "George Harrison";
////t.Cpf = "000.000.000-00";
////t.Endereco = "Rua dos Besouros - Liverpool";

////c.Titular = t;
////c.Agencia = 1;
////c.NumeroDaConta = 2234;
////c.Saldo = 10000000.0;
////c.Limite = 100000.0;

////Console.WriteLine("Informações do Titular: ");
////Console.WriteLine($"Nome: {c.Titular.Nome}");
////Console.WriteLine($"CPF: {c.Titular.Cpf}");
////Console.WriteLine($"Endereco: {c.Titular.Endereco}");


////class Aluno
////{
////    public string Nome { get; set; }
////    public int Idade { get; set; }
////    public List<double> Notas { get; set; } = new List<double>();
////}

////class Professor
////{
////    public string Nome { get; set; }
////    public List<string> DisciplinasLecionadas { get; set; } = new List<string>();
////}

////class Disciplina
////{
////    public string NomeDisciplina { get; set; }
////    public List<Aluno> AlunosMatriculados { get; set; } = new List<Aluno>();
////}

////class ProdutoRestaurante
////{
////    public string Nome { get; set; }
////    public decimal Preco { get; set; }
////}

////class Mesa
////{
////    public int Numero { get; set; }
////    public List<Pedido> Pedidos { get; set; } = new List<Pedido>();
////}

////class Pedido
////{
////    public ProdutoRestaurante Produto { get; set; }
////    public int Quantidade { get; set; }
////}

////class Cardapio
////{
//////    public List<ProdutoRestaurante> Itens { get; set; } = new List<ProdutoRestaurante>();
//////}

//////class Restaurante
//////{
//////    public List<Mesa> Mesas { get; set; } = new List<Mesa>();
//////    public Cardapio Cardapio { get; set; } = new Cardapio();
//////}



////class Titular
////{
////    public string Nome { get; set; }

////    public Titular(string nome, string cpf, string endereco)
////    {
////        Nome = nome;
////        Cpf = cpf;
////        Endereco = endereco;
////    }

////    public string Cpf { get; set; }
////    public string Endereco { get; set; }
////}


////class Conta
////{
////    public Conta(Titular titular, string agencia, int numeroDaConta, double saldo, double limite)
////    {
////        Titular = titular;
////        Agencia = agencia;
////        NumeroDaConta = numeroDaConta;
////        Saldo = saldo;
////        Limite = limite;
////    }

////    public Titular Titular { get; set; }
////    public string Agencia { get; set; }
////    public int NumeroDaConta { get; set; }
////    public double Saldo { get; }
////    public double Limite { get; set; }

////    public string Informacoes => $"Conta nº {this.NumeroDaConta}, Agência {this.Agencia}, Titular: {this.Titular.Nome} - Saldo: {this.Saldo}";
////}

////public class Cliente
////{
////    public static void main(string[] args)
////    {
////        Conta clienteConta = new Conta("Marcelo",12223333444,"Rau 1234","Siccob", 1234567, 2000, 150000); 
////    }
////}

////class CatalagoJogos
////{
////    public CatalagoJogos(string nome, int preco, string genero)
////    {
////        Nome = nome;
////        Preco = preco;
////        Genero = genero;
////    }

////    public string Nome { get; set; }
////    public int Preco { get; set; }
////    public string Genero { get; set; }
////}

////class ManipulacaoCatalogo
////{
////    private List<CatalagoJogos> Jogos = new List<CatalagoJogos>();
////    public void ExibirTodosOsJogos()
////    {
////        Jogos.Clear();
////        Console.WriteLine("Lista de Jogos: \n");
////        foreach (var jogo in Jogos)
////        {
////            Console.WriteLine($"Jogo: {jogo.Nome}\n");
////            Console.WriteLine($"Preço: R${jogo.Preco}\n");
////            Console.WriteLine($"Genero: {jogo.Genero}");
////        }
////        Console.WriteLine("Clique em Qualquer botão para sair");
////        Console.ReadKey();
////        Console.Clear();
////    }
////}