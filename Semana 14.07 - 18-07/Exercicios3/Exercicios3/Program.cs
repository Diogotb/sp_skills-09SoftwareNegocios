//using (HttpClient client = new HttpClient())
//{
//    string resposta = await client.GetStringAsync("https://www.cheapshark.com/api/1.0/deals");
//    Console.WriteLine(resposta);
//}

////Resposta minha
//class Dividir()
//{
//    public int A { get; set; }
//    public int B { get; set; }

//    public void operacao()
//    {
//        A = 10;
//        B = 5;
//        try
//        {
//            Console.WriteLine(A/B);
//        }
//        catch(DivideByZeroException ex )
//        {
//            Console.WriteLine(ex.Message);
//        }
//    }
//    public void MostrarResposta()
//    {
//        Console.WriteLine($"Numerador A dividido por Denominador B é {operacao}");
//    }
//}

//Resposta certa
//try
//{
//    Console.Write("Digite o numerador: ");
//    int numerador = int.Parse(Console.ReadLine());

//    Console.Write("Digite o Denominador: ");
//    int denominador = int.Parse(Console.ReadLine());

//    int resultado = numerador / denominador;
//    Console.WriteLine($"Resultado: {resultado}");
//}
//catch (DivideByZeroException ex)
//{
//    Console.WriteLine($"Erro: na matematica não é permitida a divisão por 0");
//}

//Minha resposta 
//List<int> numeros = new () { 1, 2, 3, 4 };
//try
//{
//    Console.WriteLine($"Procurando pelo numero 5 na lista {numeros}");
//}
//catch (Exception ex)
//{
//    Console.WriteLine("O Numero não foi encontrado");
//}

//resposta Correta 
//try
//{
//    List<int> numeros = new List<int>() { 1, 2, 3, };
//    Console.WriteLine($"Elemento no indice 5: {numeros[5]}");
//}
//catch (ArgumentOutOfRangeException ex)
//{
//    Console.WriteLine($"Erro: {ex.Message}");
//}

//não sei como fazer :|
// Criar uma classe simples com um método e chame esse método em um objeto nulo. Tratar a exceção de método em objeto nulo.

//classe simples
//class Simples
//{
//    public int tentativa { get; set; }

//    //Metodo
//    public void Contagem()
//    {
//        tentativa = 1;
//        tentativa++;
//    }

//    public void TentativaNula()
//    {
//        try
//        {
//            Console.WriteLine($"Eu tentei {Contagem(null)}");
//        }
//        catch(ArgumentNullException ex)
//        {
//            Console.WriteLine(ex.Message);
//        }
//    }
//}

//Eu sou burro
//Resposta certa 
//public class MinhaClasse
//{
//    public int objetoNulo { get; set; }

//    public void MeuMetodo()
//    { 
//        objetoNulo = 0;
//        try
//        {
//            MinhaClasse objetoNulo = null;
//            objetoNulo.MeuMetodo();
//        }
//        catch (NullReferenceException ex)
//        {
//            Console.WriteLine(ex.Message);
//        }
//    }

//}

