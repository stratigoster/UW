#ifndef __CONTROLLER_H
#define __CONTROLLER_H
#include <iostream>
#include <fstream>
#include <string>
#include "Service.h"

class ControllerState;

class Controller {
  public:
    Controller();
    static Controller* getInstance();
    void execute(std::string state_n, std::string service_n, std::string input_n);
    void setStream_v(std::ostream* stream_pn);
    void setCurrState_v(std::string state_n);

  private:
    static Controller* m_instance_pn;
    std::ostream* m_stream_pn;
    std::string m_currState_n;
    ControllerState* m_state_pn;
    Service* m_service_pn;
};

#endif
