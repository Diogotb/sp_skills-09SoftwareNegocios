using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InfIniciais
{
    public class Pessoa
    {
        
        public string? Nome {get; set;} // Cria o Propriedade Nome e o deixa publico, e como é uma variavel string so é aceito palavras

        public int Idade{get; set;} // cria a propriedade Idade e permite a modificação da idade do objeto pessoa, ele tbm é publico

        public void Apresentar(){
            Console.WriteLine($"Oi, me chamo {Nome} e tenho {Idade}"); //cria o metodo apresentar
        }
    }
}