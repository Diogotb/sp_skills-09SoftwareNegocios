import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient } from '@angular/common/http'; // <-- Importe HttpClient

@Component({
  selector: 'app-contato',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule
  ],
  templateUrl: './contato.component.html',
  styleUrls: ['./contato.component.scss']
})
export class ContatoComponent {
  contatoForm: FormGroup;
  // URLs do seu backend
  private backendUrl = 'http://localhost:3001'; // URL base do seu backend Node.js
  private emailEndpoint = '/enviar-email-contato'; // Endpoint que criamos no server.js

  constructor(
    private fb: FormBuilder,
    private http: HttpClient // <-- Injetar HttpClient no construtor
  ) {
    this.contatoForm = this.fb.group({
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      subject: ['', Validators.required],
      message: ['', Validators.required]
    });
  }

  onSubmit(): void {
    if (this.contatoForm.valid) {
      console.log('Dados do formulário válidos, enviando para o backend:', this.contatoForm.value);

      // Faz a requisição POST para o endpoint do backend
      this.http.post(`<span class="math-inline">\{this\.backendUrl\}</span>{this.emailEndpoint}`, this.contatoForm.value)
        .subscribe({
          next: (response: any) => {
            console.log('Resposta do backend:', response);
            alert('Mensagem enviada com sucesso! Em breve entraremos em contato.');
            this.contatoForm.reset(); // Limpa o formulário após o sucesso
          },
          error: (error) => {
            console.error('Erro ao enviar mensagem:', error);
            // Exibe uma mensagem de erro para o usuário
            alert('Ocorreu um erro ao enviar sua mensagem. Por favor, tente novamente mais tarde.');
          }
        });

    } else {
      // Marca todos os campos como "touched" para exibir as mensagens de erro
      this.markFormGroupTouched(this.contatoForm);
      alert('Por favor, preencha todos os campos obrigatórios corretamente.');
    }
  }

  // Função auxiliar para marcar os campos como touched (do seu código original)
  private markFormGroupTouched(formGroup: FormGroup) {
    Object.values(formGroup.controls).forEach(control => {
      control.markAsTouched();
      if ((control as any).controls) { // Se for um FormGroup aninhado
        this.markFormGroupTouched(control as FormGroup);
      }
    });
  }
}