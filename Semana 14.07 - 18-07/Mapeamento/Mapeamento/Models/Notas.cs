using System.Text.Json.Serialization;

namespace Mapeamento.Models;

internal class Notas
{
    [JsonPropertyName("key")]
    public int? NotasNumero { get; set; }

    

}
