#ifndef __SERVICE_H
#define __SERVICE_H
#include <string>
#include <fstream>
#include <iostream>
#include <queue>
#include <vector>

class Service {
  public: 
    static Service* createService(std::string type_n);
    void processInput(std::string input_n, std::ostream* stream_pn);
    virtual void routine() = 0;
    
  protected:
    Service() {};
    virtual ~Service() {};
    static Service* m_instance_pn;
    std::string m_input_n;
    std::ostream* m_stream_pn;
    std::vector<int> result_n;

  private:
    void parseInput();
};

#endif
