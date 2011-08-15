#ifndef __EQUIPMENT_H
#define __EQUIPMENT_H

#include <string>
#include <iostream>

class Room;

class Equipment {
    Room & room;
  public:
    Equipment( Room & room );
};
    
#endif
