// Importa os módulos necessários
const express = require('express'); // Framework para criar a API
const { MongoClient } = require('mongodb'); // Driver oficial para interagir com o MongoDB
const cors = require('cors'); // Middleware para permitir requisições de diferentes origens (do Angular)
const nodemailer = require('nodemailer'); // Biblioteca para enviar e-mails
require('dotenv').config(); // Carrega variáveis de ambiente de um arquivo .env

// Inicializa o aplicativo Express
const app = express();
const port = 3001; // Porta em que o servidor backend irá rodar

// Configuração da conexão com o MongoDB
// 'mongodb://localhost:27017' é o endereço padrão do servidor MongoDB
// 'thermtec_db' é o nome do banco de dados que será usado (ou criado se não existir)
const uri = 'mongodb://localhost:27017/thermtec_db';
let db; // Variável para armazenar a conexão com o banco de dados

// Middlewares do Express
app.use(cors()); // Habilita o CORS para permitir que o frontend Angular (em outra porta) se comunique com este backend
app.use(express.json()); // Habilita o Express a processar requisições com corpo JSON

// --- Configuração do Nodemailer ---
// Cria um objeto transportador reutilizável usando SMTP
// As credenciais são lidas do arquivo .env para segurança
const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', // Servidor SMTP do Gmail. ALtere se usar outro provedor (ex: smtp.outlook.com, smtp.mail.yahoo.com)
    port: 587, // Porta padrão para TLS/STARTTLS
    secure: false, // 'false' para porta 587 (TLS), 'true' para porta 465 (SSL)
    auth: {
        user: process.env.EMAIL_USER, // Seu e-mail remetente (lido do .env)
        pass: process.env.EMAIL_PASS  // Sua senha de aplicativo/conta (lida do .env)
    },
    tls: {
        // Esta opção pode ser necessária em ambientes de desenvolvimento para aceitar certificados
        // auto-assinados. Em produção, é melhor removê-la se o serviço de e-mail tiver um certificado válido.
        rejectUnauthorized: false
    }
});

// Função para conectar ao MongoDB
async function connectToMongo() {
    try {
        const client = new MongoClient(uri);
        await client.connect(); // Tenta estabelecer a conexão com o MongoDB
        db = client.db(); // Obtém a referência ao banco de dados 'thermtec_db'
        console.log("Conectado ao MongoDB!");
    } catch (error) {
        console.error("Erro ao conectar ao MongoDB:", error);
        process.exit(1); // Encerra o processo do Node.js se a conexão com o DB falhar
    }
}

// --- ROTAS DA API ---

// Rota GET para buscar todos os documentos da coleção 'obras'
app.get('/obras', async (req, res) => {
    try {
        const obrasCollection = db.collection('obras'); // Acessa a coleção 'obras' no DB
        const obras = await obrasCollection.find({}).toArray(); // Busca todos os documentos
        res.json(obras); // Envia a lista de obras como resposta JSON
        console.log("Obras enviadas para o frontend.");
    } catch (error) {
        console.error("Erro ao buscar obras:", error);
        res.status(500).json({ message: "Erro interno do servidor ao buscar obras." });
    }
});

// Rota GET para buscar todos os documentos da coleção 'projetos'
app.get('/projetos', async (req, res) => {
    try {
        const projetosCollection = db.collection('projetos'); // Acessa a coleção 'projetos' no DB
        const projetos = await projetosCollection.find({}).toArray(); // Busca todos os documentos
        res.json(projetos); // Envia a lista de projetos como resposta JSON
        console.log("Projetos enviados para o frontend.");
    } catch (error) {
        console.error("Erro ao buscar projetos:", error);
        res.status(500).json({ message: "Erro interno do servidor ao buscar projetos." });
    }
});

// Rota POST para enviar e-mail do formulário de contato
app.post('/enviar-email-contato', async (req, res) => {
    // Extrai os dados do corpo da requisição POST
    const { name, email, subject, message } = req.body;

    // Validação básica para garantir que todos os campos obrigatórios foram preenchidos
    if (!name || !email || !subject || !message) {
        return res.status(400).json({ message: 'Todos os campos do formulário são obrigatórios.' });
    }

    try {
        // Configuração do e-mail a ser enviado pelo Nodemailer
        const mailOptions = {
            from: process.env.EMAIL_USER, // O e-mail remetente (lido do .env)
            to: process.env.TARGET_EMAIL, // O e-mail para onde as mensagens do formulário serão enviadas (lido do .env)
            replyTo: email, // Define o e-mail do remetente do formulário como 'responder para'
            subject: `Mensagem de Contato do Site - Assunto: ${subject}`, // Assunto do e-mail
            html: `
                <h3>Nova Mensagem de Contato Recebida</h3>
                <p><strong>Nome:</strong> ${name}</p>
                <p><strong>Email do Remetente:</strong> ${email}</p>
                <p><strong>Assunto:</strong> ${subject}</p>
                <p><strong>Mensagem:</strong><br>${message.replace(/\n/g, '<br>')}</p>
                <hr>
                <p>Este e-mail foi enviado automaticamente através do formulário de contato do seu site.</p>
            `
        };

        // Envia o e-mail usando o transportador configurado
        await transporter.sendMail(mailOptions);
        console.log('E-mail de contato enviado com sucesso para:', process.env.TARGET_EMAIL);
        res.status(200).json({ message: 'Mensagem enviada com sucesso!' });

    } catch (error) {
        console.error('Erro ao enviar e-mail de contato:', error);
        // Retorna uma mensagem de erro genérica para o frontend por segurança
        res.status(500).json({ message: 'Erro ao enviar mensagem. Por favor, tente novamente mais tarde.' });
    }
});

// Rota raiz simples para verificar se a API está funcionando
app.get('/', (req, res) => {
  res.send('API Thermtec rodando! Acesse /obras, /projetos ou envie um POST para /enviar-email-contato.');
});

// Função principal para iniciar o servidor: primeiro conecta ao MongoDB, depois inicia o Express
async function startServer() {
    await connectToMongo(); // Espera a conexão com o MongoDB ser estabelecida
    app.listen(port, () => {
        console.log(`Servidor backend rodando em http://localhost:${port}`);
        console.log(`Endpoint de Obras: http://localhost:${port}/obras`);
        console.log(`Endpoint de Projetos: http://localhost:${port}/projetos`);
        console.log(`Endpoint de Envio de Email: http://localhost:${port}/enviar-email-contato (MÉTODO: POST)`);
        console.log('Certifique-se de que as variáveis de ambiente EMAIL_USER, EMAIL_PASS e TARGET_EMAIL estão configuradas no seu arquivo .env');
    });
}

startServer(); // Chama a função para iniciar o servidor