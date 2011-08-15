#ifndef __LOGGERSTATE_H
#define __LOGGERSTATE_H
#include "ControllerState.h"
#include <string>

class LoggerState : public ControllerState {
  public:
    virtual void print(std::string service_n, std::string input_n);
    virtual void checkState(std::string state_n);
};

#endif
