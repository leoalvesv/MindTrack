# MindTrack

MindTrack é um aplicativo iOS desenvolvido em **SwiftUI** com **SwiftData**, voltado para registro, monitoramento e análise de crises de dor de cabeça. Ele permite que o usuário acompanhe sintomas, gatilhos e intensidade da dor ao longo do tempo, gerando insights e relatórios para melhor controle pessoal.

---

## Tecnologias Utilizadas

- **Swift 5 / SwiftUI**: Interface declarativa moderna, com animações e componentes responsivos.
- **SwiftData**: Gerenciamento local de dados (persistência de crises) com integração direta ao SwiftUI.
- **Charts (SwiftUI)**: Visualização de dados através de gráficos como linhas, barras e heatmaps.
- **AppStorage**: Armazenamento simples de preferências do usuário (como notificações).
- **UIActivityViewController**: Compartilhamento de relatórios em PDF.
- **NavigationStack e TabView**: Estrutura de navegação clara e intuitiva.
- **Boas práticas de código Swift**:  
  - Nomes de variáveis e métodos claros e descritivos.  
  - Uso de `MARK:` para organizar código.  
  - Componentização e reutilização de Views (ex: `CartaoCriseView`, `BotaoSelecaoItem`).  
  - Separação por funcionalidades e arquitetura MVVM.

---

## Arquitetura

O projeto segue o padrão **MVVM** (Model-View-ViewModel):

- **Models**:  
  - `Crise`: Representa cada registro de crise, com intensidade, sintomas, gatilhos e anotação.  

- **Views**:  
  - `NovaCriseView`: Formulário para registrar novas crises.  
  - `HistoricoCrisesView`: Lista e filtros das crises registradas.  
  - `EstatisticasView`: Gráficos e análises das crises.  
  - `ConfiguracoesView`: Ajustes do aplicativo e exportação de relatórios.  
  - `CartaoCriseView`: Componente reutilizável para exibir uma crise.

- **ViewModels**:  
  - `EstatisticasViewModel`: Processa dados das crises para geração de gráficos e estatísticas.

- **Persistência**:  
  - `SwiftData` gerencia a persistência local das crises com `@Query` e `@Environment(\.modelContext)`.

---

## Funcionalidades Principais

1. **Registrar Crise**  
   - Intensidade da dor (0–10)  
   - Sintomas sentidos  
   - Possíveis gatilhos  
   - Anotações adicionais  
   - Data da crise (não permite datas futuras)

2. **Histórico de Crises**  
   - Listagem filtrável por intensidade da dor e período  
   - Layout consistente com cartões (`CartaoCriseView`)  
   - Datas exibidas no formato brasileiro

3. **Estatísticas e Gráficos**  
   - Linha de intensidade da dor ao longo do tempo  
   - Heatmap de ocorrência de crises por dia  
   - Gráficos de sintomas e gatilhos mais frequentes

4. **Configurações e Exportação**  
   - Ativar ou desativar notificações  
   - Visualizar resumo completo das crises  
   - Exportar relatório em PDF para compartilhamento ou impressão

---

## Boas Práticas Aplicadas

- **Componentização**: Cada elemento reutilizável é separado em sua própria View.
- **Organização do código**: Uso de `MARK:` para seções como filtros, métodos auxiliares e UI.
- **Atualizações reativas**: `@State`, `@Published` e `@Query` garantem atualização automática da UI.
- **Segurança de dados**: Apenas datas passadas podem ser selecionadas ao registrar crises.
- **Interface amigável**: Uso de cores suaves, gradientes, sombras e animações para melhorar UX.
