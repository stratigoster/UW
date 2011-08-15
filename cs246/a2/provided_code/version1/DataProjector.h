#ifndef __DATAPROJECTOR_H
#define __DATAPROJECTOR_H

#include "Equipment.h"

class DataProjector : public Equipment {
  public:
    DataProjector( Room & room );
    std::string print();
};

#endif
