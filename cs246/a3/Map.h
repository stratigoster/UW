#ifndef __MAP_H
#define __MAP_H
#include <map>
#include <string>
#include "Road.h"
#include "Intersection.h"

class Map {
  public:
    bool addRoad_b(std::string name_n, double speedLimit_d, double length_d);
    bool addIntersection_b(std::string name1_n, std::string name2_n, int number_i, double averageWaitTime_d);
    bool addRoadToIntersection_b(std::string name_n, int number_i);
    bool removeRoad_b(std::string name_n);
    bool removeIntersection_b(int number_i);
    std::set<std::string> attachedTo_n(int intersectionNumber_i);
    std::map<std::string, Road*>& getRoads_rn();
    std::map<int, Intersection*>& getIntersections_rn();

  private:
    std::map<std::string, Road*> m_roads_n;
    std::map<int, Intersection*> m_intersections_n;
};

#endif
