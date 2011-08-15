#ifndef __DATAPROJECTOR_H
#define __DATAPROJECTOR_H

#include "Equipment.h"

class DataProjector : public Equipment {
    friend std::ostream & operator<<( std::ostream &, const DataProjector & );
    friend std::ostream & operator<<( std::ostream &, const DataProjector * );
  public:
    DataProjector( Room & room );
};

#endif
