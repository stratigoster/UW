#include "Road.h"
#include <iostream>
using namespace std;

Road::Road(double speedLimit_d, double length_d)
  : m_length_d(length_d),
    m_speedLimit_d(speedLimit_d)
{
}

bool Road::addIntersection_b(int number_i)
{
  if (m_intersections_si.size() < 2) {
    m_intersections_si.insert(number_i);
    return true;
  }
  return false;
}

bool Road::removeIntersection_b(int number_i)
{
  m_intersections_si.erase(number_i);
  return true;
}

void Road::addLinkedIntersections_v(std::set<int>& intersections_rn, int number_i)
{
  std::set<int>::iterator it_n = m_intersections_si.find(number_i);
  if (it_n != m_intersections_si.end()) {
    // this road is part of the desired intersection
    for (it_n = m_intersections_si.begin();
         it_n != m_intersections_si.end();
         ++it_n)
    {
      if (*it_n != number_i)
      {
        // only add the intersection if it's not the same one that was passed in
        intersections_rn.insert(*it_n);
      }
    }
  }
}

bool Road::attachedTo_b(int number_i)
{
  std::set<int>::iterator it_n = m_intersections_si.find(number_i);
  if (it_n != m_intersections_si.end()) {
    return true;
  }
  return false;
}

int Road::getNumIntersections_i()
{
  return m_intersections_si.size();
}

int Road::getNextIntersection_i(int number_i)
{
  for (std::set<int>::iterator it_n = m_intersections_si.begin();
       it_n != m_intersections_si.end();
       ++it_n)
  {
    if (*it_n != number_i) {
      return *it_n;
    }
  }
  return number_i;
}

double Road::getLength_d()
{
  return m_length_d;
}

double Road::getSpeedLimit_d()
{
  return m_speedLimit_d;
}
