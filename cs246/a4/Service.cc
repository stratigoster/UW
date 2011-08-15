#include "Service.h"
#include "SortService.h"
#include "StorageService.h"
#include <sstream>
#include <string>
using namespace std;

#define SORT "sort"
#define STORAGE "store"

Service* Service::createService(std::string type_n) {
  Service* result_pn = NULL;
  if (type_n == SORT) {
    result_pn = SortService::getInstance();
  }
  else if (type_n == STORAGE) {
    result_pn = StorageService::getInstance();
  }
  return result_pn;
}

void Service::processInput(std::string input_n, ostream* stream_pn) {
  result_n.clear();
  m_input_n = input_n;
  m_stream_pn = stream_pn;
  parseInput();
}

void Service::parseInput() {
  stringstream ss(m_input_n);
  int temp_i;
  while (ss >> temp_i) {
    result_n.push_back(temp_i);
  }
}
