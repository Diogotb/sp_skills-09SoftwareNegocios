import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { HeaderComponent } from './components/header/header.component';
import { FooterComponent } from './components/footer/footer.component';
import { ThemeService } from '../app/services/theme-service.service'; // Ajuste o caminho conforme necessário

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    HeaderComponent,
    FooterComponent
  ],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'thermtec-app';

  constructor(private themeService: ThemeService) {}

  ngOnInit(): void {
    // Aplica o tema salvo no localStorage ao iniciar
    const savedTheme = this.themeService.getTheme();
    this.themeService.setTheme(savedTheme);

    // Não é necessário escutar mudanças no tema aqui
    // O método setTheme já aplica o tema corretamente
  }

  toggleTheme(): void {
    this.themeService.toggleTheme();
  }
}
