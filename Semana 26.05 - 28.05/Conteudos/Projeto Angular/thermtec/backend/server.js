const express = require('express');
const cors = require('cors'); // Importa o pacote CORS
const path = require('path'); // Para lidar com caminhos de arquivo
const fs = require('fs'); // Para ler o arquivo JSON

const app = express();
const port = 3000; // Porta do seu backend

// Configura o CORS para permitir requisições do seu frontend Angular
// Se seu Angular roda na porta 4201, ele só permitirá requisições de lá.
app.use(cors({
  origin: 'http://localhost:4201' // Altere para a porta do seu Angular, se for diferente
}));

// Middleware para analisar corpos de requisição JSON
app.use(express.json());

// Carregar os dados do db.json
const dbPath = path.join(__dirname, 'db.json');
let data = {};
try {
  const jsonData = fs.readFileSync(dbPath, 'utf8');
  data = JSON.parse(jsonData);
} catch (err) {
  console.error('Erro ao carregar db.json:', err);
  // Se o db.json não existe ou está corrompido, inicializa com objetos vazios
  data = { obras: [], projetos: [], slides: [] };
}

// Rota para obras
app.get('/api/obras', (req, res) => {
  res.json(data.obras);
});

// Rota para projetos
app.get('/api/projetos', (req, res) => {
  res.json(data.projetos);
});

// Rota para slides
app.get('/api/slides', (req, res) => {
  res.json(data.slides);
});

// Rota para um slide específico por ID (exemplo para o carrossel)
app.get('/api/slides/:id', (req, res) => {
  const slideId = parseInt(req.params.id);
  const slide = data.slides.find(s => s.id === slideId);
  if (slide) {
    res.json(slide);
  } else {
    res.status(404).json({ message: 'Slide not found' });
  }
});

// Exemplo de rota POST para adicionar uma nova obra
app.post('/api/obras', (req, res) => {
  const newObra = req.body;
  if (!newObra.titulo || !newObra.descricao) {
    return res.status(400).json({ message: 'Título e descrição são obrigatórios.' });
  }
  newObra.id = data.obras.length > 0 ? Math.max(...data.obras.map(o => o.id)) + 1 : 1;
  data.obras.push(newObra);
  // Opcional: Persistir as mudanças no db.json
  // fs.writeFileSync(dbPath, JSON.stringify(data, null, 2), 'utf8');
  res.status(201).json(newObra);
});


// Inicia o servidor
app.listen(port, () => {
  console.log(`Backend server listening at http://localhost:${port}`);
  console.log('Endpoints:');
  console.log(`  http://localhost:${port}/api/obras`);
  console.log(`  http://localhost:${port}/api/projetos`);
  console.log(`  http://localhost:${port}/api/slides`);
});