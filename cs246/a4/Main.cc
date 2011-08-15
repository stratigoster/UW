#include "Controller.h"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
using namespace std;

int main(int argc, char* argv[]) {
  string fileName;
  for (int i=1; i<argc; ++i) {
    fileName = argv[i];
    if (fileName=="stop") {
      break;
    }
    ifstream in(argv[i]);
    string oneLine;
    string state_n,service_n,data_n;
    while (in.is_open() && !in.eof()) {
      getline(in,oneLine,'\n');
      if (0 == oneLine.length()) {
        break;
      }
      stringstream ss(oneLine);
      ss >> state_n >> service_n;
      data_n = oneLine.substr(state_n.length()+service_n.length()+2);
      Controller::getInstance()->execute(state_n, service_n, data_n);
    }
    in.close();
  }
  // reset files
#ifndef DEBUG
  system("cat /dev/null > log.txt");
  system("cat /dev/null > storage.txt");
#endif
}
