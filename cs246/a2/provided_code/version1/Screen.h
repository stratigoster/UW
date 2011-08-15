#ifndef __SCREEN_H
#define __SCREEN_H

#include "Equipment.h"

class Screen : public Equipment {
  public:
    Screen( Room & room );
    std::string print();
};

#endif
