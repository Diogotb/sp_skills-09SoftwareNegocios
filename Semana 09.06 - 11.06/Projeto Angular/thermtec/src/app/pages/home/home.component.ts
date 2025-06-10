import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http'; // Para requisições ao backend

interface ItemPortfolio {
  _id?: string;
  id: string;
  titulo: string;
  descricao: string;
  imagem: string;
  categoria: 'projeto' | 'obra'; // Para distinguir entre projetos e obras
}

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  projetos: ItemPortfolio[] = [];
  obras: ItemPortfolio[] = [];
  isLoading: boolean = true;
  private apiUrl = 'http://localhost:3001/portfolio'; // URL do backend

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.fetchPortfolio();
  }

  fetchPortfolio(): void {
    this.http.get<ItemPortfolio[]>(this.apiUrl).subscribe({
      next: (data) => {
        // Filtra os dados por categoria
        this.projetos = data.filter(item => item.categoria === 'projeto');
        this.obras = data.filter(item => item.categoria === 'obra');
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Erro ao carregar dados do portfolio:', error);
        this.isLoading = false;
      }
    });
  }
}
