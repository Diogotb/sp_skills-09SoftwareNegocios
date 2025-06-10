import { Component } from '@angular/core';
import { CommonModule } from '@angular/common'; // Importante para diretivas Angular no template HTML

@Component({
  selector: 'app-afiliados',
  standalone: true, // Componente autônomo
  imports: [CommonModule], // Inclui CommonModule para uso de diretivas estruturais (mesmo que implícitas no seu HTML atual)
  templateUrl: './afiliados.component.html', // Caminho para o template HTML
  styleUrls: ['./afiliados.component.scss'] // Caminho para os estilos SCSS
})
export class AfiliadosComponent {
  // Esta classe é simples porque a página é estática.
  // O conteúdo está diretamente no HTML. Não há chamadas HTTP aqui.
}