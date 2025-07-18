class Album
{
    private List<Musica> musicas = new List<Musica>();

    public Album(string nome)
    {
        Nome = nome;
    }

    public string Nome { get; }
    public int DuracaoTotal => musicas.Sum(m => m.Duracao);

    public void AdicionarMusica(Musica musica)
    {
        musicas.Add(musica);
    }

    public void ExibirMusicasDoAlbum()
    {
        Console.WriteLine($"Lista de Musicas do álbum {Nome}: \n");
        foreach (var musica in musicas)
        {
            Console.WriteLine($"Musica:{musica.Nome}");
        }
        Console.WriteLine($"Para ouvir este album inteiro você precisa de {DuracaoTotal} segundos");
    }
}



//////Desafio 4
////class Conta
////{
////    public Titular Titular { get; set; }
////    public string Agencia { get; set; }
////    public int NumeroConta { get; set; }
////    public int Saldo { get; set; }
////    public int Limite { get; set; }



////    public void InformacoeContaDetalhe()
////    {
////        Console.WriteLine($"A Situação da conta de {Titular.NomeCompleto} é:");
////        Console.WriteLine($"Agencia: {Agencia} \n");
////        Console.WriteLine($"O numero da conta é {NumeroConta}\n");
////        Console.WriteLine($"O Saldo atual é {Saldo}\n");
//////        Console.WriteLine($"E o limite é {Limite}\n");
//////    }

//////    public void MostrarInfosTitular()
//////    {
//////        Console.WriteLine($"As informações do Titular São: \n");
//////        Console.WriteLine($"Nome Completo: {Titular.NomeCompleto}");
//////        Console.WriteLine($"Idade: {Titular.Idade}");
//////        Console.WriteLine($"CPF: {Titular.CPF}");
//////    }
//////}

//////desafio 4 

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

////    public string Descricao => $"{this.Nome} {this.Marca} - {this.Preco} - Quantidade: {this.Estoque}";

////}


////class EstoqueDeProdutos
////{
////    private List<Produto> Produtos { get; set; } = new List<Produto>();

////    public void AdicionarProduto(Produto produto)
////    {
////        Produtos.Add((produto));
////        Console.WriteLine($"Produto {produto.Nome} adicionado ao estoque");
////    }

////    public void ExibirProdutos()
////    {
////        if (Produtos.Count == 0)
////        {
////            Console.WriteLine("Estoque vazio. Nenhum produto disponível");
////        }
////        else
////        {
////            Console.WriteLine("Lista de produtos no estoque:");
////            foreach (var produto in Produtos)
////            {
////                Console.WriteLine(produto.Descricao);
////            }
////        }
////    }
////}