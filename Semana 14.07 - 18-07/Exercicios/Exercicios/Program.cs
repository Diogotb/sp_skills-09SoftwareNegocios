////pets

//public class Pet
//{
//    public string Nome { get; set; }
//    public int Idade { get; set; }
//    public string Especie { get; set; }

//    public Pet(string nome, int idade, string especie)
//    {
//        Nome = nome;
//        Idade = idade;
//        Especie = especie;
//    }
//}


//public class Dono
//{
//    public string Nome { get; set; }
//    public string Contato { get; set; }

//    public Dono(string nome, string contato)
//    {
//        Nome = nome;
//        Contato = contato;
//    }
//}

//public class Medico
//{
//    public string Nome { get; set; }
//    public string Especialidade { get; set; }

//    public Medico(string nome, string especialidade)
//    {
//        Nome = nome;
//        Especialidade = especialidade;
//    }
//}

//public class Consulta
//{
//    public Pet Animal { get; set; }
//    public Dono DonoAnimal { get; set; }
//    public Medico Veterinario { get; set; }
//    public string DataConsulta { get; set; }

//    public Consulta(Pet animal, Dono dono, Medico veterinario, string dataConsulta)
//    {
//        Animal = animal;
//        DonoAnimal = dono;
//        Veterinario = veterinario;
//        DataConsulta = dataConsulta;
//    }
//}



//// Oficina

//public class Veiculo
//{
//    public Veiculo(string marca, string modelo, int ano, string placa)
//    {
//        Marca = marca;
//        Modelo = modelo;
//        Ano = ano;
//        Placa = placa;
//    }

//    public string Marca { get; set; }
//    public string Modelo { get; set; }
//    public int Ano { get; set; }
//    public string Placa { get; set; }
//}

//public class Cliente
//{
//    public Cliente(string nome, string contato)
//    {
//        Nome = nome;
//        Contato = contato;
//    }

//    public string Nome { get; set; }
//    public string Contato { get; set; }
//}

//public class Mecanico
//{
//    public Mecanico(string nome, string especialidade)
//    {
//        Nome = nome;
//        Especialidade = especialidade;
//    }

//    public string Nome { get; set; }
//    public string Especialidade { get; set; }
//}

//public class Oficina
//{
//    private List<Veiculo> veiculosNaOficina;

//    public Oficina()
//    {
//        veiculosNaOficina = new List<Veiculo>();
//    }

//    public void AgendarServico(Veiculo veiculo, Cliente cliente, Mecanico mecanico, string dataAgendamento)
//    {
//        veiculosNaOficina.Add(veiculo);

//        //Logica para agendar o serviço (tem espaços para modificações caso necessario)
//        Console.WriteLine($"Serviço Agendado para {veiculo.Placa} em {dataAgendamento} com o mecanico {mecanico.Nome}");
//    }

//    public void RealizarServico(Veiculo veiculo, Mecanico mecanico)
//    {
//        if (veiculosNaOficina.Contains(veiculo))
//        {
//            Console.WriteLine($"Serviço realizado em {veiculo.Placa} pelo mecanico {mecanico.Nome}.");
//            veiculosNaOficina.Remove(veiculo);
//        }
//        else
//        {
//            Console.WriteLine($"O veiculo {veiculo.Placa} não esta na oficina para realizar o serviço");
//        }
//    }
//}

// Criar um Program.cs e simular o funcionamento do programa

//class Program
//{
//    static void Main()
//    {
//        // Criar instâncias de Veiculo, Cliente, Mecanico e Oficina
//        Veiculo meuCarro = new Veiculo("Chevrolet", "Cruze", 2020, "ABC1234");
//        Cliente cliente = new Cliente("Carlos", "987654321");
//        Mecanico mecanico = new Mecanico("Mário", "Mecânica Geral");
//        Oficina oficina = new Oficina();

//        // Agendar e realizar um serviço na oficina
//        oficina.AgendarServico(meuCarro, cliente, mecanico, "2023-12-18");
//        oficina.RealizarServico(meuCarro, mecanico);
//    }
//}


// Calculadora
using System.Runtime.InteropServices;

public class Calculadora
{
    public static double Calcular(double numero1, double numero2, char operacao)
    {
        double resultado = 0;

        switch (operacao)
        {
            case '+':
                resultado = Somar(numero1, numero2);
                break;
            case '-':
                resultado = Subtrair(numero1, numero2);
                break;
            case '*':
                resultado = Multiplicar(numero1, numero2);
                break;
            case '/':
                resultado = Dividir(numero1, numero2);
                break;
            case '^':
                resultado = Potencia(numero1, numero2);
                break;
            case 'r':
                resultado = RaizQuadrada(numero1);
                break;
            default:
                Console.WriteLine("Operação Invalida");
                break;
        }

        return resultado;
    }

    private static double Somar(double a, double b)
    {
        return a + b;
    }
    private static double Subtrair(double a, double b)
    {
        return a - b;
    }
    private static double Multiplicar(double a, double b)
    {
        return a * b;
    }
    private static double Dividir(double a, double b)
    {
        return a / b;
    }
    private static double Potencia(double a, double b)
    {
        return Math.Pow(a, b);
    }
    private static double RaizQuadrada(double a)
    {
        return Math.Sqrt(a);
    }
}