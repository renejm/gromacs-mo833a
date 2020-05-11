## Atividade 6
<p align="left"><b>Discente:</b> Rene Juliano Martins - <b>RA:</b> 263821</p>
<p align="left"><b>Entrega da atividade:</b> 11/05/2020.</p>

### 1. Objetivo da atividade

<p align="justify">Instrumentação do código da aplicação GROMACS para avaliar o tempo de execução do loop principal do programa, a *paramount iteration*.</p>

### 2. Métodos

#### 2.1 Condições Técnicas

<p align="justify">O experimento foi realizado em um <i>laptop</i> Dell Inspiron com CPU Intel(R) Core(TM) i7-8550U (1.80GHz) 7th Gen, com 16GB de memória RAM SODIMM Síncrona de 2400 MHz (0,4 ns) e sistema operacional Ubuntu 16.04.6 LTS.</p>
<p align="justify">Neste experimento foi utilizada a versão 2020.2-dev-20200320-7267a4f-unknown do GROMACS, compilada com CMake 3.17.0, GNU Make 4.1 e GCC 5.4.0 20160609.</p>

#### 2.2 Medição do tempo de execução

 <p align="justify">Foi criada uma classe chamada <b>Stopwatch</b> (<b>src/stopwatch</b>) para realizar a medição dos tempos de execução. A classe <b>Stopwatch</b> possui três métodos públicos:</p>
<ul>
 <li><b>setinittime:</b> Este método é responsável por coletar o <i>current time</i> para marcar o início da execução do experimento;</li>
<li><b>setstarttime:</b> É chamado no início da <i>paramount iteration</i>. Armazena o <i>current time</i> e é responsável por calcular o tempo de inicialização do programa;</li>
<li><b>setendtime:</b> É chamado no final da <i>paramount iteration</i>. Calcula o tempo decorrido desde a inicialização do programa e desde o início da <i>paramount iteration</i> atual.</li>

#### 2.3 Scripts

<p align="justify">Para realizar o experimento, basta executar os <i>scripts</i> na seguinte ordem:</p>
<ul>
<li><b>build-gromacs.sh:</b> Compila o GROMACS no modo release;</li>
<li><b>config-gromacs.sh:</b> Configura o ambiente para executar o experimento;</li>
<li><b>runexp.sh:</b> Executa o experimento quatro vezes:</li>
 <ul>
 <li> Com 1 <i>thread</i> OPENMP, gerando o arquivo de resultados <b>paramount-iteration-results-01thread.csv</b>;</li>
 <li> Com 4 <i>threads</i> OPENMP, gerando o arquivo de resultados <b>paramount-iteration-results-04thread.csv</b>;</li>
 <li> Com 8 <i>threads</i> OPENMP, gerando o arquivo de resultados <b>paramount-iteration-results-08thread.csv</b>;</li>
 <li> Com 16 <i>threads</i> OPENMP, gerando o arquivo de resultados <b>paramount-iteration-results-16thread.csv</b>.</li>
 </ul>

### 3. Apresentação e Análise dos Resultados

Os resultados estão disponíveis na planilha ![](https://docs.google.com/spreadsheets/d/1jrCL6iq4rmZR7nB2Vhvbmn7EV5FVmaxSmzr7tg81SdQ/edit?usp=sharing).
Os gráficos abaixo mostram o tempo de execução das <i>paramount iterations</i> nos quatro testes executados:
