import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { HttpClient } from '@angular/common/http';

interface Projeto {
  id: number;
  titulo: string;
  descricao: string;
  imagem: string;
  categoria: string;
}

@Component({
  selector: 'app-projetos',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './projetos.component.html',
  styleUrls: ['./projetos.component.scss']
})
export class ProjetosComponent implements OnInit {
  projetos: Projeto[] = [];
  selectedCategory: string = 'Todos';
  private apiUrl = 'http://localhost:3000/projetos';

  constructor(private http: HttpClient) { }

  ngOnInit(): void {
    this.fetchProjetos();
  }

  fetchProjetos(): void {
    this.http.get<Projeto[]>(this.apiUrl).subscribe({
      next: (data) => {
        this.projetos = data;
      },
      error: (error) => {
        console.error('Erro ao buscar projetos:', error);
      }
    });
  }

  get filteredProjetos(): Projeto[] {
    if (this.selectedCategory === 'Todos') {
      return this.projetos;
    }
    return this.projetos.filter(projeto => projeto.categoria === this.selectedCategory);
  }

  getCategories(): string[] {
    const categories = new Set(this.projetos.map(p => p.categoria));
    return ['Todos', ...Array.from(categories)];
  }

  filterByCategory(category: string): void {
    this.selectedCategory = category;
  }
}