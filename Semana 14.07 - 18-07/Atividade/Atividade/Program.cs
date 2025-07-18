//////1.

////abstract class FormaGeometrica
////{
////    public abstract double CalcularArea();
////    public abstract double CalcularPerimetro();

////}

////class Quadrado : FormaGeometrica
////{
////    public double Lado { get; set; }
////    public override double CalcularArea()
////    {
////        return Lado * Lado;
////    }

////    public override double CalcularPerimetro()
////    {
////        return 4 * Lado;
////    }
////}

////class Circulo : FormaGeometrica
////{
////    public double Raio { get; set; }

////    public override double CalcularArea()
////    {
////        return Math.PI * Raio;
////    }

////    public override double CalcularPerimetro(()
////    {
////        return 2 * Math.PI * Raio;
////    }
////}

////class triangulo : FormaGeometrica
////{
////    public double Base { get; set; }
////    public double Altura { get; set; }

////    public override double CalcularArea()
////    {
////        return 0.5 * Base * Altura;
////    }

////    public override double CalcularPerimetro()
////    {
////        return Base + Altura + Math.Sqrt(Base * Base + Altura * Altura);
////    }
////}

////class Funcionario
////{
////    public string Nome { get; set; }
////    public double Salario { get; set; }
////}

////class Gerente : Funcionario
////{
////    public string Setor { get; set; }
////}

////class Programador : Funcionario
////{
////    public string LinguagemProgramacao { get; set; }
////}

////class Analista : Funcionario
////{
////    public string AreaDeAtuacao { get; set; }
////}

////class ContaBancaria
////{
////    protected double Saldo { get ; set; }

////    public virtual void Depositar(double valor)
////    {
////        Saldo += valor;
////    }

////    public virtual void Sacar(double valor)
////    {
////        Saldo -= valor;
////    }

////    public virtual double CalcularSaldo()
////    {
////        return Saldo;
////    }
////}

////class ContaCorrente:ContaBancaria
////{
////    private double TaxaManutencao { get; set; }

////    public override void Sacar(double valor)
////    {
////        base.Sacar(valor + TaxaManutencao);
////    }
////}

////class ContaPoupança : ContaBancaria
////{
////    private double TaxaRendimento { get; set; }
////    public override double CalcularSaldo()
////    {
////        {
////            return base.CalcularSaldo() * (1 + TaxaRendimento);
////        }
////    }
////}

////class Animal
////{
////    public virtual string EmitirSom()
////    {
////        return "Som generico de animal";
////    }
////}

////class Mamifero : Animal
////{
////    public override string EmitirSom()
////    {
////        return "Som de Mamifero";
////    }
////}

////class Ave : Animal
////{
////    public override string EmitirSom()
////    {
////        return "Som generico de ave";
////    }
////}

////class peixe : Animal
////{
////    public override string EmitirSom()
////    {
////        return "Som de Peixe";
////    }
////}

//class ProdutoEletronico
//{
//    public string Modelo { get; set; }
//    public double Preco { get; set; }

//    public virtual string ExibirInformacoes()
//    {
//        return $"Modelo: {Modelo}, Preço: {Preco:C}";
//    }
//}

//class Smartphone : ProdutoEletronico
//{
//    public string SistemaOperacional { get; set; }

//    public override string ExibirInformacoes()
//    {
//        return $"{base.ExibirInformacoes()}, SO: {SistemaOperacional}";
//    }
//}

//class Tablet: ProdutoEletronico
//{
//    public string TipoTela { get; set; }

//    public override string ExibirInformacoes()
//    {
//        return $"{base.ExibirInformacoes()}, Tela {TipoTela}";
//    }
//}

//class Laptop : ProdutoEletronico
//{
//    public string Processador { get; set; }

//    public override string ExibirInformacoes()
//    {
//        return $"{base.ExibirInformacoes()}, Processador: {Processador}";
//    }
//}
