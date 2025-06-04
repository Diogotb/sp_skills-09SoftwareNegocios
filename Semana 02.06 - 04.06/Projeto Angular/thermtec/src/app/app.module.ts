import { bootstrapApplication } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';

import { appRoutes } from '../app/app.routes';  // import da variável com as rotas
import { AppComponent } from './app.component';

bootstrapApplication(AppComponent, {
  providers: [provideRouter(appRoutes)]
});
