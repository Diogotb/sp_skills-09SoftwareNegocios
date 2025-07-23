#include <iostream>
#include <cstdlib>
#include <ctime>
#include <limits>
#include <string> // Necessário para std::string e std::getline

using namespace std;

int main (){
    cout << "*************************************" << endl;
    cout << "* Bem-vindos ao jogo da adivinhacao *" << endl;
    cout << "*************************************" << endl;

    cout << "Escolha o seu nivel de dificuldade" << endl;
    cout << "Facil(F), Medio(M) ou Dificil(D)" << endl;

    char dificuldade;
    cin >> dificuldade;

    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    int numero_de_tentativas;

    if(dificuldade == 'F' || dificuldade == 'f'){
        numero_de_tentativas = 15;
    }
    else if (dificuldade == 'M' || dificuldade == 'm'){
        numero_de_tentativas = 10;
    }
    else{
        numero_de_tentativas = 5;
    }

    srand(time(NULL));
    const int NUMERO_SECRETO = rand() % 100;

    bool errou = true;
    int tentativas = 0;

    double pontos = 1000.0;

    for (tentativas = 1; tentativas <= numero_de_tentativas; tentativas++){
        int chute;

        while (true) {
            cout << "Tentativa: " << tentativas << endl;
            cout << "Qual seu chute?: ";
            cin >> chute;

            if (cin.fail()) {
                cout << "Entrada invalida! Por favor, digite um numero inteiro." << endl;
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');
            } else {
                string restante_linha;
                getline(cin, restante_linha);
                if (!restante_linha.empty() && restante_linha.find_first_not_of(" \t\n\r\f\v") != string::npos) {
                    cout << "Entrada invalida! Por favor, digite apenas um numero." << endl;
                    continue;
                }
                break;
            }
        }

        double pontos_perdidos = abs(chute - NUMERO_SECRETO) / 2.0;
        pontos = pontos - pontos_perdidos;

        cout << "O valor do seu chute e: " << chute << endl;

        bool acertou = chute == NUMERO_SECRETO;
        bool maior = chute > NUMERO_SECRETO;
        bool menor = chute < NUMERO_SECRETO;
        
        if(acertou){
            cout << "Parabens, voce acertou!" << endl;
            errou = false;
            break;
        } 
        else if (menor){
            cout << "Seu chute foi menor que o numero secreto." << endl;
        } 
        else if (maior){
            cout << "Seu chute foi maior que o numero secreto." << endl;
        } 
    }

    cout << "Fim de Jogo" << endl;

    if (errou){
        cout << "Voce perdeu! Tente novamente." << endl;
    }
    else{
        cout << "Voce acertou o numero secreto em: " << tentativas << " tentativas." << endl;
        cout.precision(2);
        cout << fixed;
        cout << "Sua pontuacao foi de " << pontos << " pontos." << endl;
    }

    return 0;
}