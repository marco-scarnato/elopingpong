# Elopingpong

This is the main project repository for Elopingpong.

## Project Structure

- `be/` - Backend application (submodule)
- `fe/` - Frontend application (submodule)

## Clone del Repository

Per clonare correttamente il repository con tutti i submodules:

### Opzione 1: Clone con submodules (consigliato)
```bash
git clone --recurse-submodules https://github.com/marco-scarnato/elopingpong.git
```

### Opzione 2: Clone e inizializzazione manuale
```bash
# Clone del repository principale
git clone https://github.com/marco-scarnato/elopingpong.git

# Entra nella directory del progetto
cd elopingpong

# Inizializza e aggiorna i submodules
git submodule update --init --recursive
```

## Aggiornamento Submodules

Per aggiornare i submodules alle ultime modifiche:

```bash
# Aggiorna il repository principale
git pull

# Aggiorna i submodules
git submodule update --remote --recursive
```

Oppure in un solo comando:

```bash
git pull --recurse-submodules
```

## Getting Started

Please refer to the README files in each subdirectory for specific setup instructions.
