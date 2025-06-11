import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { SlickCarouselModule } from 'ngx-slick-carousel';
import { CommonModule } from '@angular/common';

interface CarouselImage {
  url: string;
  alt?: string;
}

interface PortfolioItem {
  _id?: string;
  id: string;
  titulo: string;
  descricao: string;
  imagem: string;
  categoria: 'projeto' | 'obra';
}

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
  standalone: true,
  imports: [CommonModule, SlickCarouselModule]
})
export class HomeComponent implements OnInit {
  carouselImages: CarouselImage[] = [];
  projetos: PortfolioItem[] = [];
  obras: PortfolioItem[] = [];
  isLoading = true;
  carouselError: string | null = null;

  private apiUrl = 'http://localhost:3001';

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.loadCarouselImages();
    this.loadPortfolioData();
  }

  loadCarouselImages(): void {
    this.http.get<any[]>(`${this.apiUrl}/carousel/urls`).subscribe({
      next: (data) => {
        if (data && Array.isArray(data) && data.length > 0) {
          this.carouselImages = typeof data[0] === 'string' 
            ? data.map(url => ({ url, alt: 'Imagem do carrossel' }))
            : data.map(item => {
                // verifica se item e item.url existem para evitar erro
                if (item && item.url) {
                  return { url: item.url, alt: item.alt || 'Imagem do carrossel' };
                } else {
                  console.warn('Item inválido no carrossel:', item);
                  return null;
                }
              }).filter(img => img !== null) as CarouselImage[];
        } else {
          console.error('Dados recebidos em formato inesperado:', data);
          this.carouselError = 'Formato de dados inesperado ao carregar imagens do carrossel.';
        }
      },
      error: (error) => {
        console.error('Erro ao carregar carrossel:', error);
        this.carouselError = 'Não foi possível carregar as imagens do carrossel';
      }
    });
  }

  loadPortfolioData(): void {
    this.http.get<PortfolioItem[]>(`${this.apiUrl}/portfolio`).subscribe({
      next: (data) => {
        this.projetos = data.filter(item => item.categoria === 'projeto');
        this.obras = data.filter(item => item.categoria === 'obra');
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Erro ao carregar portfolio:', error);
        this.isLoading = false;
      }
    });
  }

  slideConfig = {
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 5000,
    arrows: true,
    dots: true,
    infinite: true,
    responsive: [
      {
        breakpoint: 768,
        settings: {
          arrows: false,
          dots: true
        }
      }
    ]
  };
}
