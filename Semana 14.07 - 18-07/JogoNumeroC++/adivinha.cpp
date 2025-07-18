#include<iostream>
#include <cstdlib>
#include<ctime>
using namespace std;

int main (){
    cout<<"*************************************" << endl;
    cout<<"* Bem_vindos ao jogo da adivinhacao *" << endl;
    cout<<"*************************************" << endl;

    cout << "Escolha o seu nivel de dificuldade" <, endl;
    
    cout<<"Escolha o seu nivel de dificuldade" << endl;
    cout << "Facil(F), Medio(M) ou Dificil(D)" << endl;

    char dificuldade;
    cin>> dificuldade;

    int numero_de_tentativas;

    if(dificuldade == 'F'){
        numero_de_tentativas = 15;
    }
    else if (dificuldade = 'M'){
        numero_de_tentativas = 10;
    }
    else{
        numero_de_tentativas = 5;
    }

    srand(time(NULL));
    const NUMERO_SECRETO = rand() % 100;

    bool errou = true;
    int tentativas = 0;

    double pontos = 1000.0

    for (tentativas = 1;tentativas <= numero_de_tentativas; tentativas++){
    int chute ;
    cout << "Tentativa: " << tentativas << endl;
    cout << "Qual seu chute?: " << endl;
    cin >> chute;

    double pontos_perdidos = abs(chute - NUMERO_SECRETO)/2.0;
    pontos = pontos - pontos perdidos;

    cout << "O valor do seu chute é: " << chute << endl;

    bool acertou = chute == NUMERO_SECRETO;
    bool maior = chute > NUMERO_SECRETO;
    bool menor = chute < NUMERO_SECRETO;
    
    if(acertou){
        cout << "Parabens vc acertou"
        errou = false;
        break;
    } 
    else if (menor){
        cout << "Seu chute foi menor que o numero secreto"
    } 
    else if (maior){
        cout << "Seu chute foi maior que o numero secreto"
    } 
    else {
        cout << "Valor invalido"
    }
    }
    cout <<"Fim de Jogo" << endl;
    if (errou){
        cout << "Voce perdeu tente novamente"  << endl;
    }
    else{
    cout <<"Voce acertou o numero secreto em: "<< tentativas  << " tentativas"<< endl;  
    cout.precision(2);
    cout << fixed;  
    cout << "Sua pontuação foi de "<< pontos << " pontos." << endl;
    }
}