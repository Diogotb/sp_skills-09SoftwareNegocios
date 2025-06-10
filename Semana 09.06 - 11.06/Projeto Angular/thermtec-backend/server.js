// Importa os módulos necessários
const express = require('express'); // Framework para criar a API
const { MongoClient } = require('mongodb'); // Driver oficial para interagir com o MongoDB
const cors = require('cors'); // Middleware para permitir requisições de diferentes origens (do Angular)
const sgMail = require('@sendgrid/mail'); // Importa o SDK do SendGrid
require('dotenv').config(); // Carrega variáveis de ambiente de um arquivo .env

// Inicializa o aplicativo Express
const app = express();
const port = 3001; // Porta em que o servidor backend irá rodar

// --- Configuração do SendGrid com a API Key (lida do .env) ---
sgMail.setApiKey(process.env.SENDGRID_API_KEY); // Configura a API Key do SendGrid

// Configuração da conexão com o MongoDB
const uri = 'mongodb://localhost:27017/thermtec_db';
let db; // Variável para armazenar a conexão com o banco de dados

// Middlewares do Express
app.use(cors()); // Habilita o CORS para permitir que o frontend Angular se comunique com este backend
app.use(express.json()); // Habilita o Express a processar requisições com corpo JSON

// Função para conectar ao MongoDB
async function connectToMongo() {
    try {
        const client = new MongoClient(uri);
        await client.connect();
        db = client.db();
        console.log("Conectado ao MongoDB!");
    } catch (error) {
        console.error("Erro ao conectar ao MongoDB:", error);
        process.exit(1);
    }
}

// --- ROTAS DA API ---

// Rota GET para buscar todos os documentos da coleção 'obras'
app.get('/obras', async (req, res) => {
    try {
        const obrasCollection = db.collection('obras');
        const obras = await obrasCollection.find({}).toArray();
        res.json(obras);
        console.log("Obras enviadas para o frontend.");
    } catch (error) {
        console.error("Erro ao buscar obras:", error);
        res.status(500).json({ message: "Erro interno do servidor ao buscar obras." });
    }
});

// Rota GET para buscar todos os documentos da coleção 'projetos'
app.get('/projetos', async (req, res) => {
    try {
        const projetosCollection = db.collection('projetos');
        const projetos = await projetosCollection.find({}).toArray();
        res.json(projetos);
        console.log("Projetos enviados para o frontend.");
    } catch (error) {
        console.error("Erro ao buscar projetos:", error);
        res.status(500).json({ message: "Erro interno do servidor ao buscar projetos." });
    }
});

// Rota GET para buscar todos os documentos da coleção 'portfolio'
app.get('/portfolio', async (req, res) => {
    try {
        const portfolioCollection = db.collection('portfolio');
        const portfolio = await portfolioCollection.find({}).toArray();
        res.json(portfolio);
        console.log("Portfolio enviado para o frontend.");
    } catch (error) {
        console.error("Erro ao buscar portfolio:", error);
        res.status(500).json({ message: "Erro interno do servidor ao buscar portfolio." });
    }
});

// Rota POST para enviar E-MAIL DO FORMULÁRIO DE CONTATO (AGORA COM SENDGRID)
app.post('/enviar-email-contato', async (req, res) => {
    console.log('Requisição recebida na rota /enviar-email-contato');
    console.log('Corpo da requisição (req.body):', req.body);

    const { name, email, subject, message } = req.body;

    if (!name || !email || !subject || !message) {
        console.error('Erro: Campos obrigatórios ausentes no formulário.');
        return res.status(400).json({ message: 'Todos os campos do formulário são obrigatórios.' });
    }

    try {
        const msg = {
            to: process.env.TARGET_EMAIL,
            from: process.env.SENDER_EMAIL,
            replyTo: email,
            subject: `Mensagem de Contato do Site - Assunto: ${subject}`,
            html: `
                <h3>Nova Mensagem de Contato Recebida</h3>
                <p><strong>Nome:</strong> ${name}</p>
                <p><strong>Email do Remetente:</strong> ${email}</p>
                <p><strong>Assunto:</strong> ${subject}</p>
                <p><strong>Mensagem:</strong><br>${message.replace(/\n/g, '<br>')}</p>
                <hr>
                <p>Este e-mail foi enviado automaticamente através do formulário de contato do seu site.</p>
            `,
        };

        await sgMail.send(msg);
        console.log('E-mail de contato enviado com sucesso via SendGrid para:', process.env.TARGET_EMAIL);
        res.status(200).json({ message: 'Mensagem enviada com sucesso!' });

    } catch (error) {
        console.error('Erro ao enviar e-mail de contato via SendGrid:', error.response ? error.response.body : error);
        res.status(500).json({ message: 'Erro ao enviar mensagem. Por favor, tente novamente mais tarde.' });
    }
});

// Rota raiz simples para verificar se a API está funcionando
app.get('/', (req, res) => {
  res.send('API Thermtec rodando! Acesse /obras, /projetos, /portfolio ou envie um POST para /enviar-email-contato.');
});

// Função principal para iniciar o servidor
async function startServer() {
    await connectToMongo();
    app.listen(port, () => {
        console.log(`Servidor backend rodando em http://localhost:${port}`);
        console.log(`Endpoint de Obras: http://localhost:${port}/obras`);
        console.log(`Endpoint de Projetos: http://localhost:${port}/projetos`);
        console.log(`Endpoint de Portfolio: http://localhost:${port}/portfolio`);
        console.log(`Endpoint de Envio de Email: http://localhost:${port}/enviar-email-contato (MÉTODO: POST)`);
        console.log('Verifique as variáveis de ambiente SENDGRID_API_KEY, SENDER_EMAIL e TARGET_EMAIL no seu arquivo .env');
    });
}

startServer();
