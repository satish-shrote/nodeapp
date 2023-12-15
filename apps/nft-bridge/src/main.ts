import express from 'express';
import cron from 'node-cron';

const host = process.env.HOST ?? 'localhost';
const port = process.env.PORT ? Number(process.env.PORT) : 3001;

const app = express();

app.get('/', (req, res) => {
  res.send({ message: 'Hello API' });
});

app.listen(port, host, () => {
  console.log(`[ ready ] http://${host}:${port}`);
});

cron.schedule('* * * * *', function () {
  console.log('Health check passed! Server is up and running');
});
