#ifndef __INTERSECTION_H
#define __INTERSECTION_H
#include "Road.h"
#include <set>
#include <string>

class Intersection {
  public:
    Intersection(std::string roadName1_n, std::string roadName2_n, double averageWaitTime_d);
    bool addRoad_b(std::string roadName_n);
    bool removeRoad_b(std::string roadName_n);
    std::set<std::string> getRoads_n();
    int getNumRoads_i();
    double getWaitTime_d();

  private: 
    double m_averageWaitTime_d;
    std::set<std::string> m_roads_sn;
};

#endif
