<div align="center">

# As Aventuras de um Estudante
### Jogo de Plataforma 2D — Godot Engine 4.6

[![Godot Engine](https://img.shields.io/badge/Godot-4.6-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![GDScript](https://img.shields.io/badge/GDScript-Linguagem-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![Licenca](https://img.shields.io/badge/Licenca-Educacional-green?style=for-the-badge)](LICENSE)
[![itch.io](https://img.shields.io/badge/Jogar-itch.io-FA5C5C?style=for-the-badge&logo=itch.io&logoColor=white)](https://victoruni9.itch.io/as-aventuras-de-um-estudante)
[![Status](https://img.shields.io/badge/Status-Concluido-brightgreen?style=for-the-badge)]()

<br/>

![Banner do Jogo](https://raw.githubusercontent.com/victormoreiraofc/the-adventures-of-a-student-game/main/Imagens/Backgrounds/Background_first_level.png)

</div>

---

## Sumario

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Arquitetura e Sistemas Tecnicos](#arquitetura-e-sistemas-tecnicos)
- [Testes e Qualidade](#testes-e-qualidade)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Pre-requisitos e Instalacao](#pre-requisitos-e-instalacao)
- [Como Jogar](#como-jogar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Documentacao](#documentacao)
- [Gitflow](#gitflow)
- [Contribuidores](#contribuidores)
- [Licenca](#licenca)

---

## Sobre o Projeto

**As Aventuras de um Estudante** e um jogo de plataforma 2D completo desenvolvido como projeto de semestre na **UNINOVE**, construido inteiramente com **Godot Engine 4.6** e **GDScript**.

O jogo acompanha um estudante navegando por um ambiente urbano, coletando vidas, eliminando inimigos por meio de um sistema de arremesso de livros e enfrentando um boss final para chegar a universidade. O projeto foi desenvolvido em equipe, cobrindo o ciclo completo de desenvolvimento de jogos, do design e integracao de assets ate a implementacao de fisica, sistemas de audio e publicacao na web.

Recursos visuais gerados com ferramentas de Inteligencia Artificial foram utilizados para sprites de personagem, inimigos e cenarios de fundo, integrados e otimizados para o pipeline 2D da engine.

**Jogar agora:** [itch.io](https://victoruni9.itch.io/as-aventuras-de-um-estudante) &nbsp;|&nbsp; **Codigo-fonte:** [GitHub](https://github.com/victormoreiraofc/the-adventures-of-a-student-game)

---

## Funcionalidades

| Funcionalidade | Descricao |
|---|---|
| Sistema de Movimento | Caminhada, corrida e pulo com fisica baseada em gravidade |
| Sistema de Combate | Arremesso de livros para eliminar inimigos e causar dano ao boss |
| Sistema de Vidas | Coleta de corações espalhados pelo nivel |
| IA de Inimigos | Zumbis com patrulha e inversao de direcao automatica |
| Inimigos com Quique | Xicaras que quicam continuamente no chao |
| Boss Final | Boss com sistema de pontos de vida progressivo |
| Audio por Proximidade | Sons dos inimigos ativados por zonas de colisao Area2D com atenuacao por distancia |
| Zona de Morte | Kill zone no fundo do mapa utilizando deteccao por Area2D |
| Sistema de Pause | Pausa e retomada com a tecla ESC via manipulacao da arvore de cenas |
| HUD | Contador de vidas em tempo real renderizado via CanvasLayer |
| Caixas de Livro | Caixas destrutiveis que recompensam o jogador com livros |
| Loop Completo de Jogo | Tela inicial, Gameplay, Game Over e Vitoria |
| Exportacao Web | Exportado para HTML5 e publicado no itch.io |

---

## Arquitetura e Sistemas Tecnicos

Este projeto aplica principios de engenharia de software ao longo de todo o desenvolvimento. Abaixo estao os principais sistemas tecnicos implementados:

### Gerenciamento de Estado e Eventos
- **Singleton Global (AutoLoad)** — `ScriptGlobal` gerencia o estado compartilhado do jogo (vidas, pontuacao) acessivel em todas as cenas
- **Arquitetura orientada a sinais** — Comunicacao desacoplada entre nos utilizando o sistema de sinais nativo do Godot, evitando acoplamento rigido

### Fisica e Colisao
- **CharacterBody2D** — Movimento do personagem e inimigos baseado em fisica utilizando `move_and_slide()`
- **Deteccao por Area2D** — Utilizado para colecionaveis, zonas de dano, kill zones e gatilhos de audio por proximidade
- **Chamadas de fisica diferidas** — `set_deferred("disabled", true)` previne conflitos de estado de fisica durante callbacks de colisao

### Sistema de Audio
- **Audio espacial por proximidade** — Zonas de colisao Area2D ativam sons ambientes dos inimigos; `AudioStreamPlayer2D` com `Max Distance` e atenuacao gerencia a queda de volume natural
- **Controle de loop manual** — Sinal `finished` reconectado por instancia para simular loop sem depender das configuracoes de importacao

### Camera e Interface
- **Camera2D** — Segue o jogador com limites configuraveis ao longo do nivel
- **CanvasLayer** — HUD renderizada de forma independente do movimento da camera, sempre fixa na tela
- **Pause via CanvasLayer** — Tela de pause utiliza `Modo de Processo: When Paused` para permanecer ativa enquanto a arvore de cenas esta congelada

### Arquitetura de Cenas
- Estrutura modular de cenas e scripts: cada inimigo, colecionavel e elemento de interface e uma cena instanciada independente
- O instanciamento de cenas permite multiplas copias de inimigos com comportamento e audio independentes

---

## Testes e Qualidade

### Depuracao e Correcao de Bugs

| Problema | Causa Raiz | Correcao Aplicada |
|---|---|---|
| Erro no CollisionShape ao coletar item | Mudanca de estado de fisica durante flush | Utilizacao de `set_deferred("disabled", true)` |
| Pause com ESC nao funcionava | `_input` bloqueado enquanto pausado | Substituido por `_unhandled_input` |
| Audio do inimigo sem loop | Loop mode do WAV desativado na importacao | Definido `Loop Mode: Forward` via aba Importar |
| Audio persistindo apos morte do inimigo | No de som independente do no do inimigo | Desativado via flag e desconexao de sinal no `queue_free()` |
| Camera nao rolava para a esquerda | Limite da Camera2D muito alto | Ajustado `limit_left` no inspetor |
| HUD nao aparecia no jogo | Posicao da HUD definida em coordenadas do mundo | Envolvida em CanvasLayer com posicao resetada para `(0, 0)` |
| Multiplas instancias de inimigos compartilhando stream de audio | Conflito de recurso compartilhado | Utilizado `stream.duplicate()` por instancia |

### Testes Funcionais
- Todos os loops de jogo testados de ponta a ponta: Inicio, Gameplay, Game Over e Vitoria
- IA de inimigos testada nos tres tipos (zumbi, xicara, boss) para verificar patrulha, dano e destruicao corretos
- Pause testado durante gameplay ativo, contato com inimigos e reproducao de audio
- Exportacao web testada no Chrome e Edge via itch.io

---

## Tecnologias Utilizadas

| Tecnologia | Finalidade |
|---|---|
| **Godot Engine 4.6** | Engine e editor de jogo |
| **GDScript** | Linguagem de programacao principal |
| **HTML5 / Exportacao Web** | Publicacao no navegador |
| **Git e GitHub** | Controle de versao e colaboracao |
| **Ferramentas de IA Generativa** | Criacao de sprites de personagem, inimigos e cenarios |
| **itch.io** | Hospedagem e publicacao do jogo |

---

## Pre-requisitos e Instalacao

**1. Clone o repositorio**
```bash
git clone https://github.com/victormoreiraofc/the-adventures-of-a-student-game.git
cd the-adventures-of-a-student-game
```

**2. Baixe o Godot Engine 4.6**

[https://godotengine.org/download](https://godotengine.org/download)

**3. Abra o projeto**
- Inicie o Godot Engine
- Clique em **Importar**
- Navegue ate a pasta clonada
- Selecione `project.godot`
- Clique em **Importar e Editar**

**4. Execute o jogo**
- Pressione `F5` ou clique no botao **Executar**

---

## Como Jogar

| Acao | Tecla |
|---|---|
| Mover para Esquerda / Direita | Setas `←` `→` |
| Pular | Seta `↑` |
| Arremessar Livro | `F` |
| Atacar (Mochila) | `Space` |
| Pausar | `ESC` |

**Objetivo:** Colete vidas, elimine os inimigos e derrote o boss final para chegar a universidade e vencer o jogo.

---

## Estrutura do Projeto

```
the-adventures-of-a-student-game/
├── Audios/
│   ├── Efeitos (SFX)/
│   └── Trilha Sonora (BGM)/
├── Imagens/
│   ├── Backgrounds/
│   ├── Inimigos/
│   └── Itens/
├── scene_level.tscn         # Nivel principal do jogo
├── scene_character.tscn     # Personagem jogavel
├── scene_zombie.tscn        # Inimigo zumbi
├── scene_mug.tscn           # Inimigo xicara
├── scene_boss.tscn          # Boss final
├── scene_book.tscn          # Projetil arremessavel
├── scene_hud.tscn           # Interface HUD
├── scene_pause.tscn         # Tela de pause
├── scene_start.tscn         # Tela inicial
├── scene_game_over.tscn     # Tela de Game Over
├── scene_victory.tscn       # Tela de Vitoria
├── script_global.gd         # Singleton global (AutoLoad)
└── project.godot            # Configuracao do projeto
```

---

## Documentacao

| Recurso | Link |
|---|---|
| Documentacao Godot Engine 4.x | [docs.godotengine.org](https://docs.godotengine.org/en/stable/) |
| Referencia GDScript | [GDScript Basico](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) |
| CharacterBody2D | [Introducao a Fisica](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html) |
| Sinais | [Documentacao de Sinais](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html) |
| Exportacao Web | [Exportando para Web](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html) |

---

## Gitflow

Este projeto segue convencoes de commits semanticos e uma estrategia estruturada de branches:

### Nomenclatura de Branches
```
main          → branch de producao estavel
develop       → branch de integracao de funcionalidades
feature/nome  → novas funcionalidades (ex: feature/audio-inimigo)
fix/nome      → correcoes de bugs (ex: fix/colisao-diferida)
hotfix/nome   → correcoes urgentes em producao
```

### Convencao de Commits (Conventional Commits)
```
feat:     nova funcionalidade adicionada
fix:      correcao de bug
refactor: reestruturacao de codigo sem mudanca de comportamento
docs:     atualizacoes de documentacao
chore:    mudancas de configuracao ou ferramentas
assets:   adicao de assets visuais ou de audio
```

### Fluxo de Pull Request
1. Criar branch a partir de `develop`
2. Implementar e testar localmente
3. Abrir Pull Request apontando para `develop`
4. Solicitar revisao de ao menos um membro da equipe
5. Fazer merge apos aprovacao
6. Fazer merge de `develop` em `main` nos marcos estaveis

---

## Contribuidores

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/victormoreiraofc">
        <img src="https://github.com/victormoreiraofc.png" width="80px;" alt="Victor Moreira"/><br/>
        <sub><b>Victor Moreira</b></sub>
      </a><br/>
      <sub>Tech Lead · Back-end · Front-end</sub>
    </td>
    <td align="center">
      <a href="https://github.com/Ingenzin">
        <img src="https://github.com/Ingenzin.png" width="80px;" alt="Ingenzin"/><br/>
        <sub><b>Lucas Santos</b></sub>
      </a><br/>
      <sub>Back-end · Front-end</sub>
    </td>
    <td align="center">
      <a href="https://github.com/PamellaCorrea">
        <img src="https://github.com/PamellaCorrea.png" width="80px;" alt="Pamella Correa"/><br/>
        <sub><b>Pamella Correa</b></sub>
      </a><br/>
      <sub>Documentação · Background do Nivel (IA)</sub>
    </td>
    <td align="center">
      <a href="https://github.com/Mateus-Ebenezer">
        <img src="https://github.com/Mateus-Ebenezer.png" width="80px;" alt="Mateus Ebenezer"/><br/>
        <sub><b>Mateus Ebenezer</b></sub>
      </a><br/>
      <sub>Assets de Inimigos (IA)</sub>
    </td>
    <td align="center">
      <a href="https://github.com/RuanAlvesz">
        <img src="https://github.com/RuanAlvesz.png" width="80px;" alt="Ruan Alves"/><br/>
        <sub><b>Ruan Alves</b></sub>
      </a><br/>
      <sub>Busca e Organizacao de Audios</sub>
    </td>
  </tr>
</table>

---

## Licenca

Este projeto esta licenciado para **uso educacional e nao comercial**.

E permitido:
- Estudar e referenciar o codigo para fins de aprendizado
- Fazer fork e adaptar com atribuicao de creditos aos autores originais

Nao e permitido:
- Utilizar este projeto ou seus assets para fins comerciais
- Redistribuir como trabalho proprio sem creditar os autores originais

</div>
