#include "SimpleState.h"
#include "Controller.h"
#include <string>
#include <iostream>
using namespace std;

#define SIMPLE "simple"

void SimpleState::checkState(std::string state_n) {
  if (state_n != SIMPLE) {
    Controller::getInstance()->setCurrState_v(state_n);
  }
}

void SimpleState::print(string service_n, string input_n) {
  Controller::getInstance()->setStream_v(&cout); 
}
