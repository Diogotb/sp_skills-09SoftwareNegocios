using ExerciciosLinq.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace ExerciciosLinq.Filtros
{
    internal class LinqFilterInt
    {
        public static void FiltrarElementosUnicos(List<NumerosInteiros> numeros)
        {
            var minhaListaDeNumeros = numeros.OrderByDescending(a => a.Numeros).Distinct().ToList;
            Console.WriteLine("Lista de Numeros Inteiros Diferentes Ordenados");
            foreach (var nuemro in numeros)
            {
                Console.WriteLine($"-{numeros}");
            }
        }

        public static void FiltrarElementosPares(List<NumerosInteiros> numeros, List<NumerosInteiros> minhaListaDeNumeros)
        {
            var numerosParesDistintos = minhaListaDeNumeros.Where(item => item.Numeros % 2 == 0).Distinct().ToList();
            Console.WriteLine("Lista de Numeros Pares");
            foreach (var numero in numerosParesDistintos)
            {
                Console.WriteLine($"- {numerosParesDistintos}");
            }
        }
    }
}

//Respostas dadas 
//List<int> numeros = new List<int> { 1, 2, 3, 2, 4, 5, 3, 6, 7, 8, 9, 1 };

//var numerosUnicos = numeros.Distinct();

//Console.WriteLine("Números únicos na lista:");
//foreach (var numero in numerosUnicos)
//{
//    Console.Write(numero + " ");
//}

//List<int> numeros = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

//var numerosPares = numeros.Where(x => x % 2 == 0);

//Console.WriteLine("Números Pares:");
//foreach (var numero in numerosPares)
//{
//    Console.Write(numero + " ");
//}