#ifndef __CONTROLLERSTATE_H
#define __CONTROLLERSTATE_H
#include <string>
#include "Controller.h"

class ControllerState {
  public:
    virtual void print(std::string service_n, std::string input_n) = 0;
    virtual void checkState(std::string state_n) = 0;
    virtual ~ControllerState() {};
};

#endif
