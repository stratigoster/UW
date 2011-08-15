#include "Controller.h"
#include "ControllerState.h"
#include "SimpleState.h"
#include "LoggerState.h"
#include <string>
#include <iostream>
#include <fstream>
using namespace std;

#define SIMPLE "simple"
#define LOGGER "log"

Controller* Controller::m_instance_pn = NULL;

Controller::Controller()
  : m_stream_pn(&cout),
    m_currState_n("SIMPLE"),
    m_state_pn(NULL),
    m_service_pn(NULL)
{
  m_state_pn = new SimpleState();
}

Controller* Controller::getInstance() {
  if (NULL != m_instance_pn) {
    return m_instance_pn;
  }
  m_instance_pn = new Controller();
  return m_instance_pn;
}

void Controller::execute(string state_n, string service_n, string input_n) {
  m_state_pn->checkState(state_n);
  m_service_pn = Service::createService(service_n);
  m_state_pn->print(service_n, input_n);
  m_service_pn->processInput(input_n, m_stream_pn);
  m_service_pn->routine();
}

void Controller::setStream_v(ostream* stream_pn) {
  m_stream_pn = stream_pn;
}

void Controller::setCurrState_v(string state_n) {
  m_currState_n = state_n;
  if (state_n == SIMPLE) {
    delete m_state_pn;
    m_state_pn = new SimpleState();
  }
  else if (state_n == LOGGER) {
    delete m_state_pn;
    m_state_pn = new LoggerState();
  }
}
