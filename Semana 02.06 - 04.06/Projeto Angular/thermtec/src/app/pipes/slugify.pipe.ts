import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'slugify',
  standalone: true
})
export class SlugifyPipe implements PipeTransform {
  transform(value: string): string {
    if (!value) {
      return '';
    }
    return value
      .toLowerCase()
      .normalize('NFD') // Normaliza para decompor caracteres acentuados
      .replace(/[\u0300-\u036f]/g, '') // Remove os diacríticos (acentos)
      .replace(/[^a-z0-9 -]/g, '') // Remove caracteres não alfanuméricos exceto espaços e hífens
      .replace(/\s+/g, '-') // Substitui espaços por hífens
      .replace(/-+/g, '-') // Substitui múltiplos hífens por um único
      .trim(); // Remove espaços em branco do início e fim
  }
}