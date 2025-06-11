import { Injectable, Inject, PLATFORM_ID } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { isPlatformBrowser } from '@angular/common';

export type Theme = 'light' | 'dark';

@Injectable({
  providedIn: 'root',
})
export class ThemeService {
  private themeKey = 'user-theme-preference';
  private themeSubject = new BehaviorSubject<Theme>('light');
  theme$ = this.themeSubject.asObservable();

  constructor(@Inject(PLATFORM_ID) private platformId: Object) {
    const savedTheme = this.getSavedTheme();
    this.setTheme(savedTheme);
  }

  toggleTheme(): void {
    const newTheme = this.themeSubject.value === 'light' ? 'dark' : 'light';
    this.setTheme(newTheme);
  }

  setTheme(theme: Theme): void {
    this.themeSubject.next(theme);
    this.applyThemeToBody(theme);
    this.saveTheme(theme);
  }

  getTheme(): Theme {
    return this.themeSubject.value;
  }

  private applyThemeToBody(theme: Theme): void {
    if (isPlatformBrowser(this.platformId)) {
      const body = document.body;
      if (theme === 'dark') {
        body.setAttribute('data-theme', 'dark');
      } else {
        body.removeAttribute('data-theme');
      }
    }
  }

  private saveTheme(theme: Theme): void {
    try {
      localStorage.setItem(this.themeKey, theme);
    } catch {
      // localStorage não disponível, ignora
    }
  }

  private getSavedTheme(): Theme {
    try {
      const theme = localStorage.getItem(this.themeKey);
      if (theme === 'dark' || theme === 'light') {
        return theme;
      }
    } catch {
      // localStorage não disponível
    }
    // Retorna padrão light se não houver preferência
    return 'light';
  }
}
