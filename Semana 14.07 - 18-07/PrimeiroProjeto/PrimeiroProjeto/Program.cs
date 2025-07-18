// Screen Sound
string mensagemDeBoasVinda = "Boas Vindas ao Screen Sound";
//List<string> listaDasBandas = new List<string> { "U2", "Beatles", "Calypso"};

Dictionary<string, List<int>> bandasRegistradas = new Dictionary<string, List<int>>();
bandasRegistradas.Add("Linkin Park", new List<int> { 10, 8, 6 });
bandasRegistradas.Add("Beatles", new List<int>());

void ExibirLogo()
{
    Console.WriteLine(@"
░██████╗░█████╗░██████╗░███████╗███████╗███╗░░██╗░██████╗░█████╗░██╗░░░██╗███╗░░██╗██████╗░
██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝████╗░██║██╔════╝██╔══██╗██║░░░██║████╗░██║██╔══██╗
╚█████╗░██║░░╚═╝██████╔╝█████╗░░█████╗░░██╔██╗██║╚█████╗░██║░░██║██║░░░██║██╔██╗██║██║░░██║
░╚═══██╗██║░░██╗██╔══██╗██╔══╝░░██╔══╝░░██║╚████║░╚═══██╗██║░░██║██║░░░██║██║╚████║██║░░██║
██████╔╝╚█████╔╝██║░░██║███████╗███████╗██║░╚███║██████╔╝╚█████╔╝╚██████╔╝██║░╚███║██████╔╝
╚═════╝░░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚══╝╚═════╝░░╚════╝░░╚═════╝░╚═╝░░╚══╝╚═════╝░
");
    Console.WriteLine(mensagemDeBoasVinda);
}

void ExibirOpcoesDoMenu()
{
    Console.WriteLine("\nDigite 1 para registrar uma banda");
    Console.WriteLine("Digite 2 para mostrar todas as bandas");
    Console.WriteLine("Digite 3 para avaliar uma banda");
    Console.WriteLine("Digite 4 para exibir a media de uma banda");
    Console.WriteLine("Digite -1 para sair");

    Console.Write("\nDigite a sua opção: ");
    string opcaoEscolhida = Console.ReadLine()!;
    int opcaoEscolhidaNumerica = int.Parse(opcaoEscolhida);
    switch (opcaoEscolhidaNumerica)
    {
        case 1: RegistrarBanda();
            break;
        case 2: MostrarBandasRegistradas();
            break;
        case 3: AvaliarUmaBanda();
            break;
        case 4: MediaDaBanda();
            break;
        case -1: Console.WriteLine("tchau tchau");
            break;
        default: Console.WriteLine("Opção Invalida");
            break;
    }
}

void RegistrarBanda()
{
    Console.Clear();
    ExibirTituloDaOpcao("Registro das bandas");
    Console.Write("Digite o nome da banda que deseja registrar: ");
    string nomeBanda = Console.ReadLine()!;
    bandasRegistradas.Add(nomeBanda, new List<int>());
    Console.WriteLine($"A Banda {nomeBanda} foi registrada com sucesso");
    Thread.Sleep(2000);
    Console.Clear();
    ExibirLogo();
    ExibirOpcoesDoMenu();
}

void MostrarBandasRegistradas()
{
    Console.Clear();
    ExibirTituloDaOpcao("Exibindo todas as Bandas Registradas");
    //for (int i = 0; i < listaDasBandas.Count; i++)
    //{
    //    Console.WriteLine($"Banda: {listaDasBandas[i]}");
    //}

    foreach (string banda in bandasRegistradas.Keys)
    {
        Console.WriteLine($"Banda:{banda}");
    }

    Console.WriteLine("\nDigite uma tecla para voltar pára o menuy principal");
    Console.ReadKey();
    Console.Clear();
    ExibirLogo();
    ExibirOpcoesDoMenu();
}

void ExibirTituloDaOpcao(string titulo)
{
    int quantidadeDeLetras = titulo.Length;
    string asteriscos = string.Empty.PadLeft(quantidadeDeLetras, '*');
    Console.WriteLine(asteriscos);
    Console.WriteLine(titulo);
    Console.WriteLine(asteriscos + "\n");
}

void AvaliarUmaBanda()
{
    //Digitar qual banda deseja avaliar
    //se a banda existir no docionario >> atribuyir nota
    // se não exibir mensagem e voltar no menu principal
    Console.Clear();
    ExibirTituloDaOpcao("Avaliar Banda");
    Console.Write("Digite o nome da banda que deseja avaliar: ");
    string nomeBanda = Console.ReadLine()!;
    if (bandasRegistradas.ContainsKey(nomeBanda))
    {
        Console.WriteLine($"Qual a nota que a banda {nomeBanda} merece");
        int nota = int.Parse(Console.ReadLine()!);
        bandasRegistradas[nomeBanda].Add(nota);
        Console.WriteLine($"\nA nota {nota} foi registrada com sucesso para a banda {nomeBanda}");
        Thread.Sleep(2000);
        Console.Clear();
        ExibirLogo();
        ExibirOpcoesDoMenu();
    } else
    {
        Console.WriteLine($"\nA banda {nomeBanda} não foi encontrada");
        Console.WriteLine("Digite uma tecla para voltar para o menu principal");
        Console.ReadKey(true);
        Console.Clear();
        ExibirLogo();
        ExibirOpcoesDoMenu();
    }
}

void MediaDaBanda()
{
    Console.Clear();
    ExibirTituloDaOpcao("Média da Banda");
    Console.Write("Digite o nome da banda que deseja saber a média: ");
    string nomeBanda = Console.ReadLine()!;
    if (bandasRegistradas.ContainsKey(nomeBanda))
    {
        List<int> notasDaBanda = bandasRegistradas[nomeBanda];
        Console.WriteLine($"A médiua da Banda {nomeBanda} é {notasDaBanda.Average()}");
        Console.WriteLine("Digite uma tecla para voltar ao menu principal");
        Console.ReadKey(); 
        Console.Clear();
        ExibirLogo();
        ExibirOpcoesDoMenu();
    }
    else
    {
        Console.WriteLine($"\nA banda {nomeBanda} não foi encontrada.");
    }
    Console.WriteLine("\nDigite uma tecla para voltar ao menu principal");
    Console.ReadKey(true);
    Console.Clear();
    ExibirLogo();
    ExibirOpcoesDoMenu();
}

ExibirLogo();
ExibirOpcoesDoMenu();
































































//o C# é uma lingaugem fortemente tipada

//Lista de atividades 1 modulo

//1-  string cursos = "Poo com C#";
//Console.WriteLine(cursos);
//2- string nome = "Miguel";
//string sobrenome = "Picinin";
//Console.WriteLine(nome + sobrenome);

//3- Console.WriteLine("Guilherme Lima e Daniel Portugal");

//Lista de Atividades 2 modulo
//1- Console.WriteLine("Digite sua Nota");
//string notaMedia = Console.ReadLine()!;
//int notaMediaNumerica = int.Parse(notaMedia);

//if (notaMediaNumerica >= 5)
//{
//    Console.WriteLine("\nNota suficiente para a aprovação");
//} else
//{
//    Console.WriteLine("\nNota insuficuiente para a aprovação" );
//}

//2- void ListaLinguagensProgramação()
//{
//    Console.WriteLine("Digite 1 C#");
//    Console.WriteLine("Digite 2 Python");
//    Console.WriteLine("Digite 3 Java");
//    Console.WriteLine("Digite 4 C++");


//    Console.Write("\nEscolha uma Linguagem: ");
//    string linguagemEscolhida = Console.ReadLine()!;

//    if (int.TryParse(linguagemEscolhida, out int linguagemEscolhidaNumerica))
//    {
//        string nomeLinguagem = "";
//        switch (linguagemEscolhidaNumerica)
//        {
//            case 1:
//                nomeLinguagem = "C#";
//                break;
//            case 2:
//                nomeLinguagem = "Python";
//                break;
//            case 3:
//                nomeLinguagem = "Java";
//                break;
//            case 4:
//                nomeLinguagem = "C++";
//                break;
//            default:
//                Console.WriteLine("Opção Invalida");
//                break;
//        }
//        Console.WriteLine($"A opção escolhida foi {nomeLinguagem}");
//    } else
//    {
//        Console.WriteLine("Entrada Invalida");
//    }

//}

//ListaLinguagensProgramação();

// Jogo dos Numeros

// Random aleatorio = new Random();
//int numeroSecreto = aleatorio.Next(1, 101);

//do {
//Console.Write("Digite um número entre 1 e 100: ");
//int chute = int.Parse(Console.ReadLine());

//if (chute == numeroSecreto)
//{
//    Console.WriteLine("Parabéns! Você acertou o número.");
//    break;
//}
//else if (chute < numeroSecreto)
//{
//    Console.WriteLine("O número é maior.");
//}
//else
//{
//    Console.WriteLine("O número é menor.");
//}

//} while (true) ;
//Console.WriteLine("O jogo acabou. Você acertou o número secreto!");

////Desafio 1-

//Console.WriteLine("Escolha dois Numeros: ");
//Console.WriteLine("O Valor do primeiro numero é: \n");
//int a = Convert.ToInt32(Console.ReadLine());
//Console.WriteLine("O Valor do segundo numero é: \n");
//int b = Convert.ToInt32(Console.ReadLine());
//OperacoesMat();

//void OperacoesMat()
//{
//    Console.WriteLine("Operações Matematicas\n");

//    Console.WriteLine("1 Somar");
//    Console.WriteLine("2 Subtrair");
//    Console.WriteLine("3 Dividir");
//    Console.WriteLine("4 Multiplicar");

//    Console.Write("\nEscolha uma Operação: ");

//    string operacaoEscolhida = Console.ReadLine();
//    int operacaoEscolhidaNumero = int.Parse(operacaoEscolhida);

//    switch(operacaoEscolhidaNumero)
//    {
//        case 1: Somar();
//            break;
//        case 2: Subtrair();
//            break;
//        case 3: Dividir();
//            break;
//        case 4: Multiplicar();
//            break;
//        default: Console.WriteLine("Operação não encontrada");
//            break;
//    }

//    void Somar()
//    {
//        Console.WriteLine(a + b);
//    }
//    void Subtrair()
//    {
//        Console.WriteLine(a - b);
//    }
//    void Dividir()
//    {
//        Console.WriteLine(a / b);
//    }
//    void Multiplicar()
//    {
//        Console.WriteLine(a * b);
//    }
//}

////Desafio -2

//List<int> listaNumeros = new List<int> { 12, 34, 56, 78, 90 };

//foreach (int numero in listaNumeros) ;
//Console.WriteLine(listaNumeros.Sum(i => i));