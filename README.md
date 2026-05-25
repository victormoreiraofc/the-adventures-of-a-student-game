<div align="center">

# As Aventuras de um Estudante
### Jogo de Plataforma 2D — Godot Engine 4.6

[![Godot Engine](https://img.shields.io/badge/Godot-4.6-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![GDScript](https://img.shields.io/badge/GDScript-Linguagem-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![Licença](https://img.shields.io/badge/Licen%C3%A7a-Educacional-green?style=for-the-badge)](LICENSE)
[![itch.io](https://img.shields.io/badge/Jogar-itch.io-FA5C5C?style=for-the-badge&logo=itch.io&logoColor=white)](https://victoruni9.itch.io/as-aventuras-de-um-estudante)
[![Status](https://img.shields.io/badge/Status-Concluído-brightgreen?style=for-the-badge)]()

<br/>

![Banner do Jogo](https://raw.githubusercontent.com/victormoreiraofc/the-adventures-of-a-student-game/main/Imagens/Backgrounds/Background_first_level.png)

</div>

---

## Sumário

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Arquitetura e Sistemas Técnicos](#arquitetura-e-sistemas-técnicos)
- [Testes e Qualidade](#testes-e-qualidade)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Pré-requisitos e Instalação](#pré-requisitos-e-instalação)
- [Como Jogar](#como-jogar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Documentação](#documentação)
- [Gitflow](#gitflow)
- [Contribuidores](#contribuidores)
- [Licença](#licença)

---

## Sobre o Projeto

**As Aventuras de um Estudante** é um jogo de plataforma 2D completo desenvolvido como projeto de semestre na **UNINOVE**, construído inteiramente com **Godot Engine 4.6** e **GDScript**.

O jogo acompanha um estudante navegando por um ambiente urbano, coletando vidas, eliminando inimigos por meio de um sistema de arremesso de livros e enfrentando um boss final para chegar à universidade. O projeto foi desenvolvido em equipe, cobrindo o ciclo completo de desenvolvimento de jogos, do design e integração de assets até a implementação de física, sistemas de áudio e publicação na web.

Recursos visuais gerados com ferramentas de Inteligência Artificial foram utilizados para sprites de personagem, inimigos e cenários de fundo, integrados e otimizados para o pipeline 2D da engine.

**Jogar agora:** [itch.io](https://victoruni9.itch.io/as-aventuras-de-um-estudante) &nbsp;|&nbsp; **Código-fonte:** [GitHub](https://github.com/victormoreiraofc/the-adventures-of-a-student-game)

---

## Funcionalidades

| Funcionalidade | Descrição |
|---|---|
| Sistema de Movimento | Caminhada, corrida e pulo com física baseada em gravidade |
| Sistema de Combate | Arremesso de livros para eliminar inimigos e causar dano ao boss |
| Sistema de Vidas | Coleta de corações espalhados pelo nível |
| IA de Inimigos | Zumbis com patrulha e inversão de direção automática |
| Inimigos com Quique | Xícaras que quicam continuamente no chão |
| Boss Final | Boss com sistema de pontos de vida progressivo |
| Áudio por Proximidade | Sons dos inimigos ativados por zonas de colisão Area2D com atenuação por distância |
| Zona de Morte | Kill zone no fundo do mapa utilizando detecção por Area2D |
| Sistema de Pause | Pausa e retomada com a tecla ESC via manipulação da árvore de cenas |
| HUD | Contador de vidas em tempo real renderizado via CanvasLayer |
| Caixas de Livro | Caixas destrutíveis que recompensam o jogador com livros |
| Loop Completo de Jogo | Tela inicial, Gameplay, Game Over e Vitória |
| Exportação Web | Exportado para HTML5 e publicado no itch.io |

---

## Arquitetura e Sistemas Técnicos

Este projeto aplica princípios de engenharia de software ao longo de todo o desenvolvimento. Abaixo estão os principais sistemas técnicos implementados:

### Gerenciamento de Estado e Eventos
- **Singleton Global (AutoLoad)** — `ScriptGlobal` gerencia o estado compartilhado do jogo (vidas, pontuação) acessível em todas as cenas
- **Arquitetura orientada a sinais** — Comunicação desacoplada entre nós utilizando o sistema de sinais nativo do Godot, evitando acoplamento rígido

### Física e Colisão
- **CharacterBody2D** — Movimento do personagem e inimigos baseado em física utilizando `move_and_slide()`
- **Detecção por Area2D** — Utilizado para colecionáveis, zonas de dano, kill zones e gatilhos de áudio por proximidade
- **Chamadas de física diferidas** — `set_deferred("disabled", true)` previne conflitos de estado de física durante callbacks de colisão

### Sistema de Áudio
- **Áudio espacial por proximidade** — Zonas de colisão Area2D ativam sons ambientes dos inimigos; `AudioStreamPlayer2D` com `Max Distance` e atenuação gerencia a queda de volume natural
- **Controle de loop manual** — Sinal `finished` reconectado por instância para simular loop sem depender das configurações de importação

### Câmera e Interface
- **Camera2D** — Segue o jogador com limites configuráveis ao longo do nível
- **CanvasLayer** — HUD renderizada de forma independente do movimento da câmera, sempre fixa na tela
- **Pause via CanvasLayer** — Tela de pause utiliza `Modo de Processo: When Paused` para permanecer ativa enquanto a árvore de cenas está congelada

### Arquitetura de Cenas
- Estrutura modular de cenas e scripts: cada inimigo, colecionável e elemento de interface é uma cena instanciada independente
- O instanciamento de cenas permite múltiplas cópias de inimigos com comportamento e áudio independentes

---

## Testes e Qualidade

### Depuração e Correção de Bugs

| Problema | Causa Raiz | Correção Aplicada |
|---|---|---|
| Erro no CollisionShape ao coletar item | Mudança de estado de física durante flush | Utilização de `set_deferred("disabled", true)` |
| Pause com ESC não funcionava | `_input` bloqueado enquanto pausado | Substituído por `_unhandled_input` |
| Áudio do inimigo sem loop | Loop mode do WAV desativado na importação | Definido `Loop Mode: Forward` via aba Importar |
| Áudio persistindo após morte do inimigo | Nó de som independente do nó do inimigo | Desativado via flag e desconexão de sinal no `queue_free()` |
| Câmera não rolava para a esquerda | Limite da Camera2D muito alto | Ajustado `limit_left` no inspetor |
| HUD não aparecia no jogo | Posição da HUD definida em coordenadas do mundo | Envolvida em CanvasLayer com posição resetada para `(0, 0)` |
| Múltiplas instâncias de inimigos compartilhando stream de áudio | Conflito de recurso compartilhado | Utilizado `stream.duplicate()` por instância |

### Testes Funcionais
- Todos os loops de jogo testados de ponta a ponta: Início, Gameplay, Game Over e Vitória
- IA de inimigos testada nos três tipos (zumbi, xícara, boss) para verificar patrulha, dano e destruição corretos
- Pause testado durante gameplay ativo, contato com inimigos e reprodução de áudio
- Exportação web testada no Chrome e Edge via itch.io

---

## Tecnologias Utilizadas

| Tecnologia | Finalidade |
|---|---|
| **Godot Engine 4.6** | Engine e editor de jogo |
| **GDScript** | Linguagem de programação principal |
| **HTML5 / Exportação Web** | Publicação no navegador |
| **Git e GitHub** | Controle de versão e colaboração |
| **Ferramentas de IA Generativa** | Criação de sprites de personagem, inimigos e cenários |
| **itch.io** | Hospedagem e publicação do jogo |

---

## Pré-requisitos e Instalação

**1. Clone o repositório**
```bash
git clone https://github.com/victormoreiraofc/the-adventures-of-a-student-game.git
cd the-adventures-of-a-student-game
```

**2. Baixe o Godot Engine 4.6**

[https://godotengine.org/download](https://godotengine.org/download)

**3. Abra o projeto**
- Inicie o Godot Engine
- Clique em **Importar**
- Navegue até a pasta clonada
- Selecione `project.godot`
- Clique em **Importar e Editar**

**4. Execute o jogo**
- Pressione `F5` ou clique no botão **Executar**

---

## Como Jogar

| Ação | Tecla |
|---|---|
| Mover para Esquerda / Direita | Setas `←` `→` |
| Pular | Seta `↑` |
| Arremessar Livro | `F` |
| Atacar (Mochila) | `Space` |
| Pausar | `ESC` |

**Objetivo:** Colete vidas, elimine os inimigos e derrote o boss final para chegar à universidade e vencer o jogo.

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
├── scene_level.tscn         # Nível principal do jogo
├── scene_character.tscn     # Personagem jogável
├── scene_zombie.tscn        # Inimigo zumbi
├── scene_mug.tscn           # Inimigo xícara
├── scene_boss.tscn          # Boss final
├── scene_book.tscn          # Projétil arremessável
├── scene_hud.tscn           # Interface HUD
├── scene_pause.tscn         # Tela de pause
├── scene_start.tscn         # Tela inicial
├── scene_game_over.tscn     # Tela de Game Over
├── scene_victory.tscn       # Tela de Vitória
├── script_global.gd         # Singleton global (AutoLoad)
└── project.godot            # Configuração do projeto
```

---

## Documentação

| Recurso | Link |
|---|---|
| Documentação Godot Engine 4.x | [docs.godotengine.org](https://docs.godotengine.org/en/stable/) |
| Referência GDScript | [GDScript Básico](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) |
| CharacterBody2D | [Introdução à Física](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html) |
| Sinais | [Documentação de Sinais](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html) |
| Exportação Web | [Exportando para Web](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html) |

---

## Gitflow

Este projeto segue convenções de commits semânticos e uma estratégia estruturada de branches:

### Nomenclatura de Branches
```
main          → branch de produção estável
develop       → branch de integração de funcionalidades
feature/nome  → novas funcionalidades (ex: feature/audio-inimigo)
fix/nome      → correções de bugs (ex: fix/colisao-diferida)
hotfix/nome   → correções urgentes em produção
```

### Convenção de Commits (Conventional Commits)
```
feat:     nova funcionalidade adicionada
fix:      correção de bug
refactor: reestruturação de código sem mudança de comportamento
docs:     atualizações de documentação
chore:    mudanças de configuração ou ferramentas
assets:   adição de assets visuais ou de áudio
```

### Fluxo de Pull Request
1. Criar branch a partir de `develop`
2. Implementar e testar localmente
3. Abrir Pull Request apontando para `develop`
4. Solicitar revisão de ao menos um membro da equipe
5. Fazer merge após aprovação
6. Fazer merge de `develop` em `main` nos marcos estáveis

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
        <img src="https://github.com/Ingenzin.png" width="80px;" alt="Lucas Santos"/><br/>
        <sub><b>Lucas Santos</b></sub>
      </a><br/>
      <sub>Back-end · Front-end</sub>
    </td>
    <td align="center">
      <a href="https://github.com/PamellaCorrea">
        <img src="https://github.com/PamellaCorrea.png" width="80px;" alt="Pamella Correa"/><br/>
        <sub><b>Pamella Correa</b></sub>
      </a><br/>
      <sub>Documentação · Background do Nível (IA)</sub>
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
      <sub>Busca e Organização de Áudios</sub>
    </td>
  </tr>
</table>

---

## Licença

Este projeto está licenciado para **uso educacional e não comercial**.

É permitido:
- Estudar e referenciar o código para fins de aprendizado
- Fazer fork e adaptar com atribuição de créditos aos autores originais

Não é permitido:
- Utilizar este projeto ou seus assets para fins comerciais
- Redistribuir como trabalho próprio sem creditar os autores originais

</div>
