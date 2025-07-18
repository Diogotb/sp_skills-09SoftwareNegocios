//////////public interface IForma
//////////{
//////////    double ClacularArea();
//////////    double CalcularPerimetro();
//////////}

//////////public class Circulo : IForma
//////////{
//////////    public double Raio {  get; set; }

//////////    public double CalcularArea()
//////////    {
//////////        return Math.PI * Math.Pow(Raio, 2);
//////////    }
//////////    public double CalcularPerimetro()
//////////    {
//////////        return 2 * Math.PI * Raio;
//////////    }
//////////}

//////////public class Retangulo : IForma
//////////{
//////////    public double Comprimento { get; set; }
//////////    public double Largura { get; set; }

//////////    public double CalcularArea()
//////////    {
//////////        return Comprimento * Largura;
//////////    }

//////////    public double CalcularPerimetro()
//////////    {
//////////        return 2 * (Comprimento * Largura);
//////////    }
//////////}

////////public interface IPilotavel
////////{
////////    void Pilotar();
////////}

////////public interface IVoavel
////////{
////////    void Voar();
////////}

////////public class Veiculo : IPilotavel, IVoavel
////////{
////////    public void Pilotar()
////////    {
////////        Console.WriteLine("Veículo está voando");
////////    }

////////    public void Voar()
////////    {
////////        Console.WriteLine("Veículo está voando");
////////    }
////////}

//////public interface IPagavel
//////    {
//////    decimal CalcularPagamento();

//////    }

//////public class Produto : IPagavel
//////{
//////    public string Nome { get; set; }
//////    public decimal PrecoUnitario { get; set; }
//////    public int Quantidade { get; set; }

//////    public decimal CalcularPagamento()
//////    {
//////        return PrecoUnitario * Quantidade;
//////    }
//////}

//////public class Servico : IPagavel
//////{
//////    public string Nome { get; set; }
//////    public decimal TaxaHoraria { get; set; }
//////    public int HorasTrabalhadas { get; set; }

//////    public decimal CalcularPagamento()
//////    {
//////        return TaxaHoraria * HorasTrabalhadas;
//////    }
//////}

////public interface INotificavel
////{
////    void EnviarNotificado();
////}

////public class Email : INotificavel
////{
////    public string EnderecoEmail { get; set; }

////    public void EnviarNotificacao()
////    {
////        Console.WriteLine($"Enviando e-mail para {EnderecoEmail}: Notificação importante!");
////    }
////}

////public class SMS : INotificavel
////{
////    public string NumeroTelefone { get; set; }

////    public void EnviarNotificacao()
////    {
////        Console.WriteLine($"Enviando SMS para {NumeroTelefone}: Notificação Importante!");
////    }
////}

//public interface IArmazenavel
//{
//    void Salvar();
//    void Recuperar();
//}

//public class Arquivo : IArmazenavel
//{
//    public string NomeArquivo { get; set; }

//    public void Salvar()
//    {
//        Console.WriteLine($"Salvando dados no arquivo {NomeArquivo}");
//    }

//    public void Recuperar()
//    {
//        Console.WriteLine($"Recuperando dados no arquivo {NomeArquivo}");
//    }
//}

//public class BancoDeDados : IArmazenavel
//{
//    public string NomeBanco { get; set; }

//    public void Salvar()
//    {
//        Console.WriteLine($"Salvando dados no banco de dados {NomeBanco}");
//    }
//    public void Recuperar()
//    {
//        Console.WriteLine($"Recuperando dados do banco de dados {No}");
//    }
//}