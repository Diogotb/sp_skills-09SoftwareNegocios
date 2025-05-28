import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { Subscription, interval } from 'rxjs';

interface Slide {
  id: number;
  titulo: string;
  subtitulo: string;
  imagem: string;
}

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit, OnDestroy {
  slides: Slide[] = [];
  currentSlideIndex = 0;
  private intervalSubscription: Subscription | undefined;
  private apiUrl = 'http://localhost:3000/slides'; // Remova o '/api'
  constructor(private http: HttpClient) { }

  ngOnInit(): void {
    this.fetchSlides();
  }

  fetchSlides(): void {
    this.http.get<Slide[]>(this.apiUrl).subscribe({
      next: (data) => {
        this.slides = data;
        if (this.slides.length > 0) {
          this.startCarousel();
        }
      },
      error: (error) => {
        console.error('Erro ao buscar slides:', error);
      }
    });
  }

  startCarousel(): void {
    this.stopCarousel();
    this.intervalSubscription = interval(5000).subscribe(() => {
      this.nextSlide();
    });
  }

  stopCarousel(): void {
    if (this.intervalSubscription) {
      this.intervalSubscription.unsubscribe();
      this.intervalSubscription = undefined;
    }
  }

  ngOnDestroy(): void {
    this.stopCarousel();
  }

  nextSlide(): void {
    this.stopCarousel();
    this.currentSlideIndex = (this.currentSlideIndex + 1) % this.slides.length;
    this.startCarousel();
  }

  prevSlide(): void {
    this.stopCarousel();
    this.currentSlideIndex = (this.currentSlideIndex - 1 + this.slides.length) % this.slides.length;
    this.startCarousel();
  }

  goToSlide(index: number): void {
    this.stopCarousel();
    this.currentSlideIndex = index;
    this.startCarousel();
  }
}