import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { ProjetosComponent } from './pages/projetos/projetos.component';
import { ObrasComponent } from './pages/obras/obras.component';
import { ContatoComponent } from './pages/contato/contato.component';
import { AfiliadosComponent } from './pages/afiliados/afiliados.component';


export const appRoutes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'projetos', component: ProjetosComponent },
  { path: 'obras', component: ObrasComponent },
  { path: 'contato', component: ContatoComponent },
  { path: 'afiliados', component: AfiliadosComponent }, // Descomente quando criar o componente
  { path: '**', redirectTo: '' } // Rota curinga para redirecionar para a home
];