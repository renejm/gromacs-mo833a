#include <sys/time.h>

namespace gmx {
  class Stopwatch {
    int iterationnum = 0;
    double inittime;
    double starttime;
    double getcurrenttime();
  public:
    void setinittime();
    void setstarttime();
    void setendtime();
  };
}

gmx::Stopwatch SWatch;
