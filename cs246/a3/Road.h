#ifndef __ROAD_H
#define __ROAD_H
#include "Intersection.h"
#include <set>

class Road {
  public:
    Road(double speedLimit_d, double length_d);
    bool addIntersection_b(int number_i);
    bool removeIntersection_b(int number_i);
    void addLinkedIntersections_v(std::set<int>& intersections_rn, int number_i);
    bool attachedTo_b(int number_i);
    int getNumIntersections_i();
    int getNextIntersection_i(int number_i);
    double getLength_d();
    double getSpeedLimit_d();
  private:
    double m_length_d;
    double m_speedLimit_d;
    std::set<int> m_intersections_si;
};

#endif
