import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
  stages: [
    { duration: '1m', target: 1000 } // 1000 VUs (Virtual Users) por minuto
  ],
};

export default function () {
  http.get('http://localhost:8989/api/hello');
  sleep(1); // 1 segundo de pausa entre as requisições
}
