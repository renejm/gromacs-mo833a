## Atividade 6
<p align="left">**Discente:** Rene Juliano Martins - **RA:** 263821</p>
<p align="left">**Entrega da atividade:** 11/05/2020.</p>

### 1. Objetivo da atividade

<p align="justify">Instrumentação do código da aplicação GROMACS para avaliar o tempo de execução do loop principal do programa, a *paramount iteration*.</p>

### 2. Métodos

#### 2.1 Condições Técnicas

<p align="justify">O experimento foi realizado em um *laptop* Dell Inspiron com CPU Intel(R) Core(TM) i7-8550U (1.80GHz) 7th Gen, com 16GB de memória RAM SODIMM Síncrona de 2400 MHz (0,4 ns) e sistema operacional Ubuntu 16.04.6 LTS.</p>
<p align="justify">Neste experimento foi utilizada a versão 2020.2-dev-20200320-7267a4f-unknown do GROMACS, compilada com CMake 3.17.0, GNU Make 4.1 e GCC 5.4.0 20160609.</p>

#### 2.2 Medição do tempo de execução

 <p align="justify">Foi criada uma classe chamada **Stopwatch** (**src/stopwatch**) para realizar a medição dos tempos de execução. A classe **Stopwatch** possui três métodos públicos:</p>
<ul>
<li>**setinittime:** Este método é responsável por coletar o *current time* para marcar o início da execução do experimento;</li>
<li>**setstarttime:** É chamado no início da *paramount iteration*. Armazena o *current time* e é responsável por calcular o tempo de inicialização do programa;</li>
<li>**setendtime:** É chamado no final da *paramount iteration*. Calcula o tempo decorrido desde a inicialização do programa e desde o início da *paramount iteration* atual.</li>

#### 2.3 Scripts

<p align="justify">Para realizar o experimento, basta executar os *scripts* na seguinte ordem:</p>
<ul>
<li>**build-gromacs.sh:** Compila o GROMACS no modo release;</li>
<li>**config-gromacs.sh:** Configura o ambiente para executar o experimento;</li>
<li>**runexp.sh:** Executa o experimento quatro vezes:</li>
 <ul>
 <li> Com 1 *thread* OPENMP, gerando o arquivo de resultados **paramount-iteration-results-01thread.csv**;</li>
 <li> Com 4 *threads* OPENMP, gerando o arquivo de resultados **paramount-iteration-results-04thread.csv**;</li>
 <li> Com 8 *threads* OPENMP, gerando o arquivo de resultados **paramount-iteration-results-08thread.csv**;</li>
 <li> Com 16 *threads* OPENMP, gerando o arquivo de resultados **paramount-iteration-results-16thread.csv**.</li>
 </ul>

### 3. Apresentação e Análise dos Resultados

Os resultados estão disponíveis na planilha ![](https://docs.google.com/spreadsheets/d/1jrCL6iq4rmZR7nB2Vhvbmn7EV5FVmaxSmzr7tg81SdQ/edit?usp=sharing).
Os gráficos abaixo mostram o tempo de execução das *paramount iterations* nos quatro testes executados:
