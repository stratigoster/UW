#include "SortService.h"
#include <string>
#include <vector>
#include <queue>
using namespace std;

SortService* SortService::m_instance_pn = NULL;

SortService* SortService::getInstance() {
  if (NULL != m_instance_pn) {
    return m_instance_pn;
  }
  m_instance_pn = new SortService();
  return m_instance_pn;
}

void SortService::routine() {
  priority_queue<int> PQ;
  for (unsigned int i=0; i<result_n.size(); ++i) {
    PQ.push(result_n[i]);
  }
  result_n.clear();
  while (!PQ.empty()) {
    result_n.push_back(PQ.top());
    PQ.pop();
  }
  for (std::vector<int>::reverse_iterator it_n = result_n.rbegin(); it_n != result_n.rend(); ++it_n) {
    *m_stream_pn << *it_n << " ";
  }
  *m_stream_pn << endl;
  ofstream* stream_pn = dynamic_cast<ofstream*>(m_stream_pn);
  if (NULL != stream_pn) {
    stream_pn->close();
  }
}
