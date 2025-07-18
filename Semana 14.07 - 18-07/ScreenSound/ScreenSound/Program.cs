Episodio ep1 = new(1, "Tecnicas de Facilitação", 45);
ep1.AdicionarConvidado("Maria");
ep1.AdicionarConvidado("Marcelo");

Episodio ep2 = new(2, "Tecnicas de aprendizado", 67);
ep2.AdicionarConvidado("fernando");
ep2.AdicionarConvidado("Markus");
ep2.AdicionarConvidado("Flavia");

Podcast podcast = new Podcast("Podcast especial", "Miguel");
podcast.AdicionarEpisodio(ep1);
podcast.AdicionarEpisodio(ep2);
podcast.ExibirDetalhes();



















//Banda queen = new Banda("Queen");

//Album albumDoQueen = new Album("");

//Musica musica1 = new Musica(queen, "Love of my Life")
//{
//    Duracao = 213,
//    Disponivel = true,
//};


//Musica musica2 = new Musica(queen, "Bohemian Rhapsody")
//{
//    Duracao = 354,
//    Disponivel = false,
//};

//albumDoQueen.AdicionarMusica(musica1);
//albumDoQueen.AdicionarMusica(musica2);
//queen.AdicionarAlbum(albumDoQueen);

//musica1.ExibirFichaTecnica();
//musica2.ExibirFichaTecnica();
//albumDoQueen.ExibirMusicasDoAlbum();
//queen.ExibirDiscografia();
////desafio 1

//ContaBancaria conta1 = new ContaBancaria();
//conta1.titular = "José";
//conta1.saldo = 2000;
//Console.WriteLine($"O Dono desta Conta é {conta1.titular}, e o saldo dela é de R${conta1.saldo}");
//Console.WriteLine($"O Dono desta Conta é {conta1.titular}, e o saldo dela é de R${conta1.saldo}");