#include "Map.h"
#include <iostream>
using namespace std;

bool Map::addRoad_b(std::string name_n, double speedLimit_d, double length_d)
{
  std::map<std::string, Road*>::iterator it_n = m_roads_n.find(name_n);
  if (it_n == m_roads_n.end()) 
  {
    // road isn't in map already
    Road* road_pn = new Road(speedLimit_d, length_d);
    m_roads_n[name_n] = road_pn; 
    return true;
  }
  return false;
}

bool Map::addIntersection_b(std::string name1_n, std::string name2_n, int number_i, double averageWaitTime_d)
{
  std::map<int, Intersection*>::iterator it_n = m_intersections_n.find(number_i);
  if (it_n == m_intersections_n.end())
  {
    // intersection isn't in map already
    std::map<std::string, Road*>::const_iterator road1_n = m_roads_n.find(name1_n); 
    std::map<std::string, Road*>::const_iterator road2_n = m_roads_n.find(name2_n); 
    if (road1_n != m_roads_n.end() && road2_n != m_roads_n.end() &&
        m_roads_n[name1_n]->getNumIntersections_i() < 2 && m_roads_n[name1_n]->getNumIntersections_i() < 2)
    {
      Intersection* intersection_pn = new Intersection(name1_n, name2_n, averageWaitTime_d);
      m_intersections_n[number_i] = intersection_pn; 
      m_roads_n[name1_n]->addIntersection_b(number_i); 
      m_roads_n[name2_n]->addIntersection_b(number_i); 
      return true;
    }
    else
    {
      return false;
    }
  }
  return false;
}

bool Map::addRoadToIntersection_b(std::string name_n, int number_i)
{
  if (m_roads_n[name_n]->addIntersection_b(number_i))
  {
    m_intersections_n[number_i]->addRoad_b(name_n);
    return true;
  }
  return false;
}

bool Map::removeRoad_b(std::string name_n)
{
  for (std::map<int, Intersection*>::iterator it_n = m_intersections_n.begin();
       it_n != m_intersections_n.end();
       ++it_n)
  {
    // check whether we can safely remove this road
    if (it_n->second->getNumRoads_i() == 2) {
      return false;
    }
  }
  for (std::map<int, Intersection*>::iterator it_n = m_intersections_n.begin();
       it_n != m_intersections_n.end();
       ++it_n)
  {
    it_n->second->removeRoad_b(name_n);
  }
  m_roads_n.erase(name_n);
  return true;
}

bool Map::removeIntersection_b(int number_i)
{
  m_intersections_n.erase(number_i);
  for (std::map<std::string, Road*>::iterator it_n = m_roads_n.begin();
       it_n != m_roads_n.end();
       ++it_n)
  {
    it_n->second->removeIntersection_b(number_i);
  }
  return true;
}

std::set<std::string> Map::attachedTo_n(int intersectionNumber_i)
{
  std::set<std::string> roads_n;
  std::map<int, Intersection*>::iterator it_n = m_intersections_n.find(intersectionNumber_i);
  if (it_n != m_intersections_n.end()) {
    roads_n = m_intersections_n[intersectionNumber_i]->getRoads_n();
  }
  return roads_n;
}

std::map<std::string, Road*>& Map::getRoads_rn()
{
  return m_roads_n;
}

std::map<int, Intersection*>& Map::getIntersections_rn()
{
  return m_intersections_n;
}
