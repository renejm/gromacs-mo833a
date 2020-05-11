# Atividade 6
<p align="left"><b>Discente:</b> Rene Juliano Martins - <b>RA:</b> 263821</p>
<p align="left"><b>Entrega da atividade:</b> 11/05/2020.</p>

## 1. Objetivo da atividade

<p align="justify">Instrumentação do código da aplicação GROMACS para avaliar o tempo de execução do loop principal do programa, a <i>paramount iteration</i>.</p>

## 2. Métodos

### 2.1 Condições Técnicas

<p align="justify">O experimento foi realizado em um <i>laptop</i> Dell Inspiron com CPU Intel(R) Core(TM) i7-8550U (1.80GHz) 7th Gen, com 16GB de memória RAM SODIMM Síncrona de 2400 MHz (0,4 ns) e sistema operacional Ubuntu 16.04.6 LTS.</p>
<p align="justify">Neste experimento foi utilizada a versão 2020.2-dev-20200320-7267a4f-unknown do GROMACS, compilada com CMake 3.17.0, GNU Make 4.1 e GCC 5.4.0 20160609.</p>

### 2.2 Medição do tempo de execução

 <p align="justify">Foi criada uma classe chamada <b>Stopwatch</b> (<b>src/stopwatch</b>) para realizar a medição dos tempos de execução. A classe <b>Stopwatch</b> possui três métodos públicos:</p>
<ul>
 <li><b>setinittime:</b> Este método é responsável por coletar o <i>current time</i> para marcar o início da execução do experimento;</li>
 <li><b>setstarttime:</b> É chamado no início da <i>paramount iteration</i>. Armazena o <i>current time</i> e é responsável por calcular o tempo de inicialização do programa;</li>
 <li><b>setendtime:</b> É chamado no final da <i>paramount iteration</i>. Calcula o tempo decorrido desde a inicialização do programa e desde o início da <i>paramount iteration</i> atual.</li>
</ul>

### 2.3 Scripts

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
</ul>

## 3. Apresentação e Análise dos Resultados

Os resultados estão disponíveis na planilha [https://docs.google.com/spreadsheets/d/1jrCL6iq4rmZR7nB2Vhvbmn7EV5FVmaxSmzr7tg81SdQ](https://docs.google.com/spreadsheets/d/1jrCL6iq4rmZR7nB2Vhvbmn7EV5FVmaxSmzr7tg81SdQ/edit?usp=sharing).
Os gráficos abaixo mostram o tempo de execução das <i>paramount iterations</i> nos quatro testes executados:


### 1 thread OPENMP:
<p align="center">
  <img src="https://raw.githubusercontent.com/renejm/gromacs-mo833a/ativ-6-exp-1/experiments/ativ-6-exp-1/images/openmp01thread.png">
</p>
<p align="justify">Foi gasto o tempo de 0,097442 segundos da inicialização até o primeiro <i>loop</i>. O tempo gasto nas <i>paramount iterations</i> foram de 85,353445 segundos e o tempo total observado foi de 85,474 segundos.</p>


### 4 threads OPENMP:
<p align="center">
  <img src="https://raw.githubusercontent.com/renejm/gromacs-mo833a/ativ-6-exp-1/experiments/ativ-6-exp-1/images/openmp04threads.png">
</p>
<p align="justify">Foi gasto o tempo de 0,139931 segundos da inicialização até o primeiro <i>loop</i>. O tempo gasto nas <i>paramount iterations</i> foram de 37,963839 segundos e o tempo total observado foi de 38,1187 segundos.</p>


### 8 threads OPENMP:
<p align="center">
  <img src="https://raw.githubusercontent.com/renejm/gromacs-mo833a/ativ-6-exp-1/experiments/ativ-6-exp-1/images/openmp08threads.png">
</p>
<p align="justify">Foi gasto o tempo de 0,149487 segundos da inicialização até o primeiro <i>loop</i>. O tempo gasto nas <i>paramount iterations</i> foram de 32,561004 segundos e o tempo total observado foi de 32,7304 segundos.</p>


### 16 threads OPENMP:
<p align="center">
  <img src="https://raw.githubusercontent.com/renejm/gromacs-mo833a/ativ-6-exp-1/experiments/ativ-6-exp-1/images/openmp16threads.png">
</p>
<p align="justify">Foi gasto o tempo de 0,111382 segundos da inicialização até o primeiro <i>loop</i>. O tempo gasto nas <i>paramount iterations</i> foram de 32,424015 segundos e o tempo total observado foi de 32,5517 segundos.</p>
