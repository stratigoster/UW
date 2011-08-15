#include "Intersection.h"

Intersection::Intersection(std::string roadName1_n, std::string roadName2_n, double avgWaitTime_d)
  : m_averageWaitTime_d(avgWaitTime_d)
{
  m_roads_sn.insert(roadName1_n);
  m_roads_sn.insert(roadName2_n);
}

bool Intersection::addRoad_b(std::string roadName_n)
{
  m_roads_sn.insert(roadName_n);
  return true;
}

bool Intersection::removeRoad_b(std::string roadName_n)
{
  if (m_roads_sn.size() > 2)
  {
    m_roads_sn.erase(roadName_n);
    return true;
  }
  return false;
}

std::set<std::string> Intersection::getRoads_n()
{
  return m_roads_sn;
}

int Intersection::getNumRoads_i()
{
  return m_roads_sn.size();
}

double Intersection::getWaitTime_d()
{
  return m_averageWaitTime_d;
}
