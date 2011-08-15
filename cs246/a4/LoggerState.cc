#include "LoggerState.h"
#include "Controller.h"
#include <string>
#include <iostream>
#include <fstream>
using namespace std;

#define LOGFILE "log.txt"
#define LOGGER "log"

void LoggerState::print(std::string service_n, std::string input_n) {
  ofstream* out_pn = new ofstream(LOGFILE, ios::app);
  Controller::getInstance()->setStream_v(out_pn);
  *out_pn << "SERVICE=" << service_n << " INPUT=" << input_n << " OUTPUT=";
}

void LoggerState::checkState(std::string state_n) {
  if (state_n != LOGGER) {
    Controller::getInstance()->setCurrState_v(state_n);
  }
}
