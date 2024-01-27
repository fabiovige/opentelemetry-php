#!/bin/bash

# Configuração
url="http://localhost:8989/api/hello"
total_requests=100  # Número total de requisições

# Requisições GET
for i in $(seq 1 $total_requests); do
  curl -s "$url" -o /dev/null &
done

# Dados para a requisição POST
post_data='{"message": "Hello, World!"}'

# Requisições POST
for i in $(seq 1 $total_requests); do
  curl -s -X POST "$url" -H "Content-Type: application/json" -d "$post_data" -o /dev/null &
done

wait
echo "Requisições GET e POST concluídas."
