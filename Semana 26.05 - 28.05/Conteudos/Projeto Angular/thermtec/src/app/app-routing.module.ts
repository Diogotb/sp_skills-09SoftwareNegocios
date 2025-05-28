import { Routes } from '@angular/router';
import { HomeComponent } from '../app/pages/home/home.component';
import { ProjetosComponent } from '../app/pages/projetos/projetos.component';
import { ObrasComponent } from '../app/pages/obras/obras.component';
import { ContatoComponent } from '../app/pages/contato/contato.component';

export const appRoutes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'projetos', component: ProjetosComponent },
  { path: 'obras', component: ObrasComponent },
  { path: 'contato', component: ContatoComponent },
  { path: '**', redirectTo: '' } // rota fallback
];
