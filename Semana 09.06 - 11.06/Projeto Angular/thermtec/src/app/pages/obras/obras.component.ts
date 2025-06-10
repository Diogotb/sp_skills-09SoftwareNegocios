import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common'; // Necessário para *ngIf e *ngFor
import { HttpClient } from '@angular/common/http'; // Para fazer requisições HTTP ao backend

// Definição da interface para o tipo de dados de uma obra
interface ItemPortfolio {
  _id?: string; // ID gerado automaticamente pelo MongoDB (opcional no TS, mas presente no DB)
  id: string; // Nosso ID personalizado para a obra
  titulo: string; // Título da obra
  descricao: string; // Descrição detalhada da obra
  imagem: string; // URL da imagem da obra
  local?: string; // Localização da obra (opcional)
  anoConclusao?: number; // Ano de conclusão da obra (opcional)
}

@Component({
  selector: 'app-obras',
  standalone: true, // Indica que este é um componente standalone (não precisa de NgModule)
  imports: [CommonModule], // Importa módulos necessários para templates
  templateUrl: './obras.component.html', // Caminho para o template HTML
  styleUrls: ['./obras.component.scss'] // Caminho para os estilos CSS/SCSS
})
export class ObrasComponent implements OnInit {
  obras: ItemPortfolio[] = []; // Array para armazenar as obras carregadas
  isLoading: boolean = true; // Flag para controlar o estado de carregamento
  private apiUrl = 'http://localhost:3001/obras'; // URL do endpoint do backend para obras

  constructor(private http: HttpClient) { } // Injeta o serviço HttpClient

  ngOnInit(): void {
    this.fetchObras(); // Chama a função para buscar as obras quando o componente é inicializado
  }

  fetchObras(): void {
    console.log('Iniciando busca de obras do backend...');
    this.http.get<ItemPortfolio[]>(this.apiUrl).subscribe({
      next: (data) => {
        this.obras = data; // Atribui os dados recebidos ao array 'obras'
        this.isLoading = false; // Define isLoading como false, pois os dados foram carregados
        console.log('Dados de obras recebidos:', this.obras);
      },
      error: (error) => {
        console.error('Erro ao buscar obras:', error);
        this.isLoading = false; // Define isLoading como false mesmo em caso de erro
        // Implementar lógica para exibir mensagem de erro na UI, se necessário
      }
    });
  }
}