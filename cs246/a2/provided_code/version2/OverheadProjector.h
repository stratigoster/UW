#ifndef __OVERHEAD_H
#define __OVERHEAD_H

#include "Equipment.h"

class OverheadProjector : public Equipment {
    friend std::ostream & operator<<( std::ostream &, const OverheadProjector & );
    friend std::ostream & operator<<( std::ostream &, const OverheadProjector * );
  public:
    OverheadProjector( Room & room );
};

#endif
