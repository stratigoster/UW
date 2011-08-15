#include "Map.h"
#include "Intersection.h"
#include "Road.h"
#include <iostream>
#include <string>
#include <vector> 
#include <list> 

#define MAXINT 32767
typedef unsigned int uint;

using namespace std;

std::set<int> linkedIntersections(Map& map_rn, int intersectionNumber_n)
{
  std::set<int> intersections_n;
  for (std::map<std::string, Road*>::iterator it_n = map_rn.getRoads_rn().begin();
       it_n != map_rn.getRoads_rn().end();
       ++it_n)
  {
    it_n->second->addLinkedIntersections_v(intersections_n, intersectionNumber_n);
  }
  return intersections_n;
}

std::set<int> accessibleFrom(Map& map_rn, int intersectionNumber_i)
{
  int curr_i = intersectionNumber_i;
  int next;
  std::list<int> nodes_n;
  std::set<int> result_n;
  std::map<int,bool> visited_n; 
  std::map<std::string, Road*> roads_n = map_rn.getRoads_rn(); 
  nodes_n.push_back(curr_i);
  visited_n[curr_i] = true;
  while (!nodes_n.empty())
  {
    curr_i = nodes_n.front();
    nodes_n.pop_front();
    std::set<std::string> currRoads_n = map_rn.attachedTo_n(curr_i); 
    for (std::set<std::string>::const_iterator it_n = currRoads_n.begin();
         it_n != currRoads_n.end();
         ++it_n)
    {
      next = roads_n[*it_n]->getNextIntersection_i(curr_i);
      if (!visited_n[next])
      {
        visited_n[next] = true;
        nodes_n.push_back(next);
        result_n.insert(next);
      }
    }
  }
  return result_n;
}

bool roadUses(Map& map_rn, std::string name_n, int intersectionNumber_n)
{
  std::map<std::string, Road*> roads_n = map_rn.getRoads_rn(); 
  return roads_n[name_n]->attachedTo_b(intersectionNumber_n);
}

// find shortest path between intersections i1 and i2 using dijkstra's algorithm
std::vector<int> findPath(Map& map_rn, int i1_i, int i2_i) {
  std::map<int, int> d;
  std::map<int, int> previous;
  std::vector<int> S;
  std::list<int> Q; 
  std::map<int, Intersection*> intersections_n = map_rn.getIntersections_rn(); 
  std::map<std::string, Road*> roads_n = map_rn.getRoads_rn(); 
  for (std::map<int, Intersection*>::const_iterator it_n = intersections_n.begin();
       it_n != intersections_n.end();
       ++it_n)
  {
    Q.push_back(it_n->first); 
    d[it_n->first] = MAXINT;
    previous[it_n->first] = -1;
  }
  d[i1_i] = 0;
  while (!Q.empty())
  {
    int min = 0, min_cost = MAXINT; 
    for (std::list<int>::const_iterator it_n = Q.begin();
         it_n != Q.end();
         ++it_n)
    {
      if (d[*it_n] < min_cost)
      {
        min = *it_n;
        min_cost = d[*it_n];
      }
    }
    for (std::list<int>::iterator it_n = Q.begin();
         it_n != Q.end();
         ++it_n)
    {
      if (*it_n == min) 
      {
        Q.erase(it_n);
        break;
      }
    }
    S.push_back(min);
    std::set<std::string> currRoads_n = map_rn.attachedTo_n(min);
    for (std::set<std::string>::const_iterator it_n = currRoads_n.begin();
         it_n != currRoads_n.end();
         ++it_n)
    {
      int v =  roads_n[*it_n]->getNextIntersection_i(min);
      if (d[min] + 1 < d[v]) 
      {
        d[v] = d[min] + 1;
        previous[v] = min; 
      }
    }
  }
  std::list<int> temp_result;
  int u = i2_i;
  while (previous[u] != -1)
  {
    temp_result.push_front(u);
    u = previous[u];
  }
  temp_result.push_front(i1_i);
  std::vector<int> result;
  for (std::list<int>::const_iterator it_n = temp_result.begin();
       it_n != temp_result.end();
       ++it_n)
  {
    result.push_back(*it_n);
  }
  return result;
}

void printStuff_v(const std::set<int>& intersections_rn)
{
  for (std::set<int>::const_iterator it_n = intersections_rn.begin();
       it_n != intersections_rn.end();
       ++it_n)
  {
    cout << *it_n << ' ';
  }
  cout << '\n';
}

#ifdef DEBUG

void printList(const std::list<int>& intersections_rn)
{
  for (std::list<int>::const_iterator it_n = intersections_rn.begin();
       it_n != intersections_rn.end();
       ++it_n)
  {
    cout << *it_n << ' ';
  }
  cout << '\n';
}
#endif

int main()
{
  // build map in figure
  Map map_n;
  map_n.addRoad_b("A",100,5);
  map_n.addRoad_b("B",50,2);
  map_n.addRoad_b("C",100,5);
  map_n.addRoad_b("D",100,5);
  map_n.addRoad_b("E",100,5);
  map_n.addRoad_b("F",50,2);
  map_n.addRoad_b("G",50,2);
  map_n.addRoad_b("H",50,2);
  map_n.addRoad_b("I",50,2);
  map_n.addIntersection_b("A","B",1,2);
  map_n.addIntersection_b("A","C",2,10);
  map_n.addIntersection_b("C","D",3,10);
  map_n.addIntersection_b("D","E",4,10);
  map_n.addIntersection_b("E","F",5,10);
  map_n.addIntersection_b("H","B",6,2);
  map_n.addIntersection_b("H","I",7,2);
  map_n.addRoadToIntersection_b("G",7);
  map_n.addRoadToIntersection_b("G",4);
  map_n.addRoadToIntersection_b("I",5);
  map_n.addRoadToIntersection_b("F",6);

  // query and print all intersections linked directly/indirectly to intersection #2
  printStuff_v(accessibleFrom(map_n, 2));

#ifdef DEBUG
  printStuff_v(accessibleFrom(map_n, 1));
  printStuff_v(accessibleFrom(map_n, 2));
  printStuff_v(accessibleFrom(map_n, 3));
  printStuff_v(accessibleFrom(map_n, 4));
  printStuff_v(accessibleFrom(map_n, 5));
  printStuff_v(accessibleFrom(map_n, 6));
  printStuff_v(accessibleFrom(map_n, 7));
#endif

  // check if road H involves intersection #5
  bool flag_b = roadUses(map_n, "H", 5);
  if (flag_b)
  {
    std::cout << "yes\n";
  }
  else
  {
    std::cout << "no\n";
  }

  // query and find route from intersection 1 to intersection 4
  std::map<std::string, Road*> roads_n = map_n.getRoads_rn();
  std::map<int, Intersection*> intersections_n = map_n.getIntersections_rn(); 
  double totalLength_d = 0; 
  double totalTime_d = 0; 
  double length_d, speedLimit_d;
  std::vector<int> path = findPath(map_n, 1, 4);
  if (!path.size()==0) { 
    cout << "Route: "; 
    for (uint i=1; i<path.size(); ++i)
    {
      std::set<std::string> roads1_n = intersections_n[path.at(i)]->getRoads_n();
      for (std::set<std::string>::const_iterator it1_n = roads1_n.begin();
           it1_n != roads1_n.end();
           ++it1_n)
      {
        if (roadUses(map_n, *it1_n, path.at(i-1)))
        {
          length_d = roads_n[*it1_n]->getLength_d();
          speedLimit_d = roads_n[*it1_n]->getSpeedLimit_d(); 
          totalLength_d += length_d;
          totalTime_d += (length_d/speedLimit_d)*60;
          cout << *it1_n << ' '; 
          break;
        }
      } 
      if (i!=path.size()-1)
      {
        totalTime_d += intersections_n[path.at(i)]->getWaitTime_d();
      }
    } 
    cout << "\nLength of route: " << totalLength_d << "\nTotal time: " << totalTime_d << '\n'; 
  }
  else
  {
    cout << "No path exists.\n";
  }
}
