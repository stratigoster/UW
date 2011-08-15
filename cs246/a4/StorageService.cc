#include "StorageService.h"
#include <iostream>
#include <fstream>
using namespace std;

#define STORAGE_FILE "storage.txt"

StorageService* StorageService::m_instance_pn = NULL;

StorageService* StorageService::getInstance() {
  if (NULL != m_instance_pn) {
    return m_instance_pn;
  }
  m_instance_pn = new StorageService();
  return m_instance_pn;
}

void StorageService::routine() {
  ofstream out(STORAGE_FILE, ios::app);
  for (std::vector<int>::iterator it_n = result_n.begin(); it_n != result_n.end(); ++it_n) {
    *m_stream_pn << *it_n << " ";
    out << *it_n << " ";
  }
  out << endl;
  out.close();
  *m_stream_pn << endl;
  ofstream* stream_pn = dynamic_cast<ofstream*>(m_stream_pn);
  if (NULL != stream_pn) {
    stream_pn->close();
  }
}

