import { Routes } from '@angular/router';
import { HomeComponent } from '../app/pages/home/home.component';
import { ProjetosComponent } from '../app/pages/projetos/projetos.component';
import { ObrasComponent } from '../app/pages/obras/obras.component';
import { ContatoComponent } from '../app/pages/contato/contato.component';
import { AfiliadosComponent } from '../app/pages/afiliados/afiliados.component'; // Ajustei o caminho para manter a consistência

export const appRoutes: Routes = [
  { path: '', component: HomeComponent }, // Página inicial
  { path: 'projetos', component: ProjetosComponent }, // Página de Projetos
  { path: 'obras', component: ObrasComponent }, // Página de Obras
  { path: 'contato', component: ContatoComponent }, // Página de Contato
  { path: 'afiliados', component: AfiliadosComponent }, // Página de Afiliados
  { path: '**', redirectTo: '' }, // Rota fallback
];
