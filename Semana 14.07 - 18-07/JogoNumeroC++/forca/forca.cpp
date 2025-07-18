#include <iostream>
#include <string>
#include <map>
#include <vector>
using namespace std;

const string PALAVRA_SECRETA = "DOOM";
map<char, bool> chutou
vector<char> chutes_errados;

bool letra_existe(char chute){
    for(char letra : PALAVRA_SECRETA){
        if(chute == letra){
            return true;
        }
    }
    return false;
}

bool nao_acertou(){
    for(char letra : PALAVRA_SECRETA){
        if(!chutou[letra]){
            return true;
        }
    }
    return false;
}
bool nao_enforcou(){
    return chutes_errados.size() < 5;
}



// chute A:
//          V       V
// M E L A N C I A 
// 0 1 2 3 4 5 6 7

// PALAVRA_SECRETA[0]= M;
// PALAVRA_SECRETA[1]= E;
// PALAVRA_SECRETA[2]=L
void imprime_cabecalho(){
    cout << "*********************" << endl;
    cout << "*** Jogo da Forca ***" << endl;
    cout << "*********************" << endl;
    cout << endl;
}

void imprime_erros(){
    cout<<"Chutes errados: ";
        for(char letra : chutes_errados){
            cout << letra << " ";
        }
        cout << endl;
}

void imprime_palavra(){
for (char letra : PALAVRA_SECRETA){
            if ( chutou[letra] ){
                cout << letra << " ";
            }
            else{
                cout << "_ ";
            }
        }
}

void chuta(){
    cout << "Digite o seu chute: " << endl;
        char chute;
        cin >> chute;
        chotou[chute] = true;

        if(letra_existe(chute)){
            cout << "Voce acertou! seu chute esta na palavra." << endl;
        }
        else{
            cout << "Voce errou! Seu chute nao esta na palavra"
            chutes_errados.push_back(chute);
        }
        cout << endl;
}

int main(){
    imprime_cabecalho();

    bool nao_acertou = true;
    bool nao_enforcou = true;

    while (nao_enforcou() && nao_acertou())
    {
        imprime_erros();

        imprime_palavra();
        
        chuta();

    }
    cout<< "Fim de Jogo" << endl;
    cout << "A palavra secreta era: " << PALAVRA_SECRETA << endl;

    if (nao_acertou())
    {
        cout<< "Voce perdeu ! tente novamente" << endl;
    }
    else{
        cout << "Parabens! voce acertou a palavra secreta!" << endl;
    }
    
    
}