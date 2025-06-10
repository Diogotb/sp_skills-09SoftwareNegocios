import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpErrorResponse } from '@angular/common/http'; // <-- Importe HttpErrorResponse

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
  private backendUrl = 'http://localhost:3001';
  private emailEndpoint = '/enviar-email-contato';

  constructor(
    private fb: FormBuilder,
    private http: HttpClient
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

      this.http.post(`${this.backendUrl}${this.emailEndpoint}`, this.contatoForm.value)
        .subscribe({
          next: (response: any) => {
            console.log('Resposta do backend:', response);
            alert('Mensagem enviada com sucesso! Em breve entraremos em contato.');
            this.contatoForm.reset();
          },
          error: (error: HttpErrorResponse) => { // <-- Tipagem para HttpErrorResponse
            console.error('Erro detalhado ao enviar mensagem:', error); // <-- Agora registará o objeto de erro completo
            console.error('Status do erro:', error.status); // <-- Status HTTP do erro
            console.error('Mensagem de erro do backend:', error.error); // <-- Mensagem enviada pelo backend
            alert('Ocorreu um erro ao enviar sua mensagem. Por favor, tente novamente mais tarde.');
          }
        });

    } else {
      this.markFormGroupTouched(this.contatoForm);
      alert('Por favor, preencha todos os campos obrigatórios corretamente.');
    }
  }

  private markFormGroupTouched(formGroup: FormGroup) {
    Object.values(formGroup.controls).forEach(control => {
      control.markAsTouched();
      if ((control as any).controls) {
        this.markFormGroupTouched(control as FormGroup);
      }
    });
  }
}
