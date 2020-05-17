#include "stopwatch.h"
#include <iostream>

using namespace gmx;

double Stopwatch::getcurrenttime() {
    struct timeval tp;
    struct timezone tzp;
    gettimeofday(&tp,&tzp);
    return ((double) tp.tv_sec + (double) tp.tv_usec * 1.e-6);
}

void Stopwatch::setinittime() {
  inittime = getcurrenttime();
}

void Stopwatch::setstarttime() {
  starttime = getcurrenttime();
  if (iterationnum == 0) {
    std::cout << "Initialization time;" << starttime - inittime << std::endl;
    std::cout << "" << std::endl;
    std::cout << "Iteration;Time since initialization (s);Iteration time (s)" << std::endl;
  }
  iterationnum++;
}

void Stopwatch::setendtime() {
  double endtime = getcurrenttime();
  std::cout << iterationnum << ";" << endtime - inittime << ";" << endtime - starttime << std::endl;
}

bool Stopwatch::istimetoabort(int maxiterations) {
    return (iterationnum >= maxiterations);
}