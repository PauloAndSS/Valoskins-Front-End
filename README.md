# ValoSkins Frontend API

Este projeto é o **frontend em Flutter/Dart** que consome a API do repositório [valoskinsAPI](https://github.com/Samukaka01/valoskinsAPI).

## 🚀 Objetivo
O app conecta-se ao backend Django REST Framework para listar armas e skins do jogo Valorant, permitindo buscas, filtros e visualização de dados.

## 📂 Estrutura
- `models/` → contém os modelos Dart (`Arma`, `Skin`) que representam os dados vindos da API.
- `api/valo_skins_api.dart` → responsável pelas chamadas HTTP para o backend.
- `screens/` → telas do Flutter que exibem os dados.

## 🔧 Configuração
1. Clone o repositório:
   ```bash
   git clone https://github.com/Samukaka01/valoskinsAPI

npm install
(Se falhar usar ) : npx npm install
