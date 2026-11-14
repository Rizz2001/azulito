const http = require('http');
const fs = require('fs');
const path = require('path');

let PORT = process.env.PORT ? parseInt(process.env.PORT, 10) : 8085;
const WEB_DIR = path.join(__dirname, '..', 'build', 'web');

const MIME_TYPES = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.json': 'application/json',
  '.css': 'text/css',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.wasm': 'application/wasm',
  '.otf': 'font/otf',
  '.ttf': 'font/ttf',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
};

const server = http.createServer((req, res) => {
  let reqPath = req.url.split('?')[0];
  if (reqPath === '/') reqPath = '/index.html';

  let filePath = path.join(WEB_DIR, reqPath);
  
  // Seguridad de rutas
  if (!filePath.startsWith(WEB_DIR)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      filePath = path.join(WEB_DIR, 'index.html');
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    fs.readFile(filePath, (readErr, content) => {
      if (readErr) {
        res.writeHead(500);
        res.end('Error loading file');
        return;
      }
      res.writeHead(200, {
        'Content-Type': contentType,
        'Access-Control-Allow-Origin': '*',
        'Cross-Origin-Opener-Policy': 'same-origin',
        'Cross-Origin-Embedder-Policy': 'require-corp',
      });
      res.end(content);
    });
  });
});

server.on('error', (err) => {
  if (err.code === 'EADDRINUSE' && PORT !== 8085) {
    console.log(`Puerto ${PORT} en uso, cambiando automáticamente a 8085...`);
    PORT = 8085;
    server.listen(PORT, '127.0.0.1', () => {
      console.log(`Azulito POS Web Servidor corriendo en http://127.0.0.1:${PORT}`);
    });
  } else {
    throw err;
  }
});

server.listen(PORT, '127.0.0.1', () => {
  console.log(`Azulito POS Web Servidor corriendo en http://127.0.0.1:${PORT}`);
});

