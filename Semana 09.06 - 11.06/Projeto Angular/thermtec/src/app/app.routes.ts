import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { ObrasComponent } from './pages/obras/obras.component';
import { ProjetosComponent } from './pages/projetos/projetos.component';
import { AfiliadosComponent } from './pages/afiliados/afiliados.component';
import { ContatoComponent } from './pages/contato/contato.component'; // <-- Certifique-se que está importado

export const appRoutes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'obras', component: ObrasComponent },
  { path: 'projetos', component: ProjetosComponent },
  { path: 'afiliados', component: AfiliadosComponent },
  { path: 'contato', component: ContatoComponent }, // <-- Certifique-se que a rota existe
  { path: '**', redirectTo: '' }
];