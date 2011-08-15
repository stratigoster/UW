#ifndef __SIMPLESTATE_H
#define __SIMPLESTATE_H
#include <string>
#include "ControllerState.h"

class SimpleState : public ControllerState {
  public:
    virtual void print(std::string service_n, std::string input_n);
    virtual void checkState(std::string state_n);
};

#endif
