#ifndef __OVERHEAD_H
#define __OVERHEAD_H

#include "Equipment.h"

class OverheadProjector : public Equipment {
  public:
    OverheadProjector( Room & room );
    std::string print();
};

#endif
