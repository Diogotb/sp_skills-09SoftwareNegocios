import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { FilterByStatusPipe } from '../../pipes/filter-by-status.pipe';
import { SlugifyPipe } from '../../pipes/slugify.pipe'; // Importe o SlugifyPipe

interface Obra {
  id: number;
  titulo: string;
  localizacao: string;
  status: string;
  imagem: string;
  descricao: string;
}

@Component({
  selector: 'app-obras',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    FilterByStatusPipe,
    SlugifyPipe // Adicione o SlugifyPipe aqui
  ],
  templateUrl: './obras.component.html',
  styleUrls: ['./obras.component.scss']
})
export class ObrasComponent implements OnInit {
  obras: Obra[] = [];
  private apiUrl = 'http://localhost:3000/obras';

  constructor(private http: HttpClient) { }

  ngOnInit(): void {
    this.fetchObras();
  }

  fetchObras(): void {
    this.http.get<Obra[]>(this.apiUrl).subscribe({
      next: (data) => {
        this.obras = data;
      },
      error: (error) => {
        console.error('Erro ao buscar obras:', error);
      }
    });
  }
}