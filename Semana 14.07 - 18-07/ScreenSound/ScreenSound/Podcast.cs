class Podcast
{
    private List<Episodio> episodios = new List<Episodio>();
    public Podcast( string nome, string host)
    {
        Nome = nome;
        Host = host;
        
    }
    public string Nome { get; }
    public string Host { get; }
    

    public int TotalEpisodios => episodios.Count;
    public void AdicionarEpisodio(Episodio episodio)
    {
        episodios.Add(episodio);
    }

    public void ExibirDetalhes()
    {
        Console.WriteLine($"Bem Vindo ao {Nome}, Apresentado por {Host}\n");
        Console.WriteLine($"Aqui está a nossa lista de episodios: \n");
        foreach (Episodio episodio in episodios.OrderBy(e => e.Ordem))
        {
            Console.WriteLine(episodio.Resumo);
        }
        Console.WriteLine($"\n\nEste podcats posuui no total {TotalEpisodios} episodios");
    }

}