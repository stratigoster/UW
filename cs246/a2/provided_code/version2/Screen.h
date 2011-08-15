#ifndef __SCREEN_H
#define __SCREEN_H

#include "Equipment.h"

class Screen : public Equipment {
    friend std::ostream & operator<<( std::ostream &, const Screen & );
    friend std::ostream & operator<<( std::ostream &, const Screen * );
  public:
    Screen( Room & room );
};

#endif
