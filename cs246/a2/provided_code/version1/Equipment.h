#ifndef __EQUIPMENT_H
#define __EQUIPMENT_H

#include <string>

class Room;

class Equipment {
    Room & room;
  public:
    Equipment( Room & room );
    virtual std::string print() = 0;
};
    
#endif
