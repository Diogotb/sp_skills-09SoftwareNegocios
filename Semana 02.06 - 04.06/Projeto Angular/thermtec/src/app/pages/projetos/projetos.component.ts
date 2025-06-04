import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common'; // Necessário para *ngIf e *ngFor
import { HttpClient } from '@angular/common/http'; // Para fazer requisições HTTP ao backend

// Definição da interface para o tipo de dados de um projeto (reutiliza a mesma estrutura)
interface ItemPortfolio {
  _id?: string;
  id: string;
  titulo: string;
  descricao: string;
  imagem: string;
  local?: string;
  anoConclusao?: number;
}

@Component({
  selector: 'app-projetos',
  standalone: true, // Indica que este é um componente standalone
  imports: [CommonModule], // Importa módulos necessários para templates
  templateUrl: './projetos.component.html', // Caminho para o template HTML
  styleUrls: ['./projetos.component.scss'] // Caminho para os estilos CSS/SCSS
})
export class ProjetosComponent implements OnInit {
  projetos: ItemPortfolio[] = []; // Array para armazenar os projetos carregados
  isLoading: boolean = true; // Flag para controlar o estado de carregamento
  private apiUrl = 'http://localhost:3001/projetos'; // <-- URL do endpoint do backend para projetos

  constructor(private http: HttpClient) { } // Injeta o serviço HttpClient

  ngOnInit(): void {
    this.fetchProjetos(); // Chama a função para buscar os projetos quando o componente é inicializado
  }

  fetchProjetos(): void {
    console.log('Iniciando busca de projetos do backend...');
    this.http.get<ItemPortfolio[]>(this.apiUrl).subscribe({
      next: (data) => {
        this.projetos = data; // Atribui os dados recebidos ao array 'projetos'
        this.isLoading = false; // Define isLoading como false, pois os dados foram carregados
        console.log('Dados de projetos recebidos:', this.projetos);
      },
      error: (error) => {
        console.error('Erro ao buscar projetos:', error);
        this.isLoading = false; // Define isLoading como false mesmo em caso de erro
        // Implementar lógica para exibir mensagem de erro na UI, se necessário
      }
    });
  }
}