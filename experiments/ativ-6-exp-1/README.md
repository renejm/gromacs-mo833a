## Atividade 6

**Discente:** Rene Juliano Martins - **RA:** 263821<BR>
**Entrega da atividade:** 11/05/2020.

### 1. Objetivo da atividade

Instrumentação do código da aplicação GROMACS para avaliar o tempo de execução do loop principal do programa, a *paramount iteration*.

### 2. Métodos

#### 2.1 Condições Técnicas

O experimento foi realizado em um *laptop* Dell Inspiron com CPU Intel(R) Core(TM) i7-8550U (1.80GHz) 7th Gen, com 16GB de memória RAM SODIMM Síncrona de 2400 MHz (0,4 ns) e sistema operacional Ubuntu 16.04.6 LTS.
Neste experimento foi utilizada a versão 2020.2-dev-20200320-7267a4f-unknown do GROMACS, compilada com CMake 3.17.0, GNU Make 4.1 e GCC 5.4.0 20160609.

#### 2.2 Medição do tempo de execução

 Foi criada uma classe chamada ```Stopwatch``` (```src/stopwatch```) para realizar a medição dos tempos de execução. A classe ```Stopwatch``` possui três métodos públicos:<BR>
 **```setinittime```:** Este método é responsável por coletar o *current time* para marcar o início da execução do experimento;<BR>
 **```setstarttime```:** É chamado no início da *paramount iteration*. Armazena o *current time* e é responsável por calcular o tempo de inicialização do programa;<BR>
 **```setendtime```:** É chamado no final da *paramount iteration*. Calcula o tempo decorrido desde a inicialização do programa e desde o início da *paramount iteration* atual.

#### 2.3 Scripts

Para realizar o experimento, basta executar os *scripts* na seguinte ordem:
**```build-gromacs.sh```:** Compila o GROMACS no modo release;
**```config-gromacs.sh```:** Configura o ambiente para executar o experimento;
**```runexp.sh```:** Executa o experimento quatro vezes:<BR>
 **a.** Com 1 *thread* OPENMP, gerando o arquivo de resultados ```paramount-iteration-results-01thread.csv```;<BR>
 **b.** Com 4 *threads* OPENMP, gerando o arquivo de resultados ```paramount-iteration-results-04thread.csv```;<BR>
 **c.** Com 8 *threads* OPENMP, gerando o arquivo de resultados ```paramount-iteration-results-08thread.csv```;<BR>
 **d.** Com 16 *threads* OPENMP, gerando o arquivo de resultados ```paramount-iteration-results-16thread.csv```.

### 3. Apresentação e Análise dos Resultados

Os resultados estão disponíveis na planilha ![](https://docs.google.com/spreadsheets/d/1jrCL6iq4rmZR7nB2Vhvbmn7EV5FVmaxSmzr7tg81SdQ/edit?usp=sharing).
Os gráficos abaixo mostram o tempo de execução das *paramount iterations* nos quatro testes executados:
