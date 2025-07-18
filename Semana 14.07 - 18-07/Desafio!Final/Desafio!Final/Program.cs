using (HttpClient client = new HttpClient())
{
    string resposta = await client.GetStringAsync("https://ipstack.com/?utm_source=Github&utm_medium=Referral&utm_campaign=Public-apis-repo-Best-sellers");
    Console.WriteLine(resposta);
}

using (HttpClient cliente = new HttpClient())
{
    string resposta = await cliente.GetStringAsync("https://marketstack.com/?utm_source=Github&utm_medium=Referral&utm_campaign=Public-apis-repo-Best-sellers");
    Console.WriteLine(resposta);
}

using (HttpClient cliente = new HttpClient())
{
    string resposta = await cliente.GetStringAsync("https://weatherstack.com/?utm_source=Github&utm_medium=Referral&utm_campaign=Public-apis-repo-Best-sellers");
    Console.WriteLine(resposta);
}

using (HttpClient cliente = new HttpClient())
{
    string resposta = await cliente.GetStringAsync("https://numverify.com/?utm_source=Github&utm_medium=Referral&utm_campaign=Public-apis-repo-Best-sellers");
    Console.WriteLine(resposta);
}

using (HttpClient cliente = new HttpClient())
{
    string resposta = await cliente.GetStringAsync("https://fixer.io/?utm_source=Github&utm_medium=Referral&utm_campaign=Public-apis-repo-Best-sellers");
    Console.WriteLine(resposta);
}

using (HttpClient cliente = new HttpClient())
{
    string resposta = await cliente.GetStringAsync("https://avaitionstack.com/?utm_source=Github&utm_medium=Referral&utm_campaign=Public-apis-repo-Best-sellers");
    Console.WriteLine(resposta);
}