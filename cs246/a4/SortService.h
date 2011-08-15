#ifndef __SORTSERVICE_H
#define __SORTSERVICE_H
#include "Service.h"

class SortService : public Service {
  public:
    static SortService* getInstance();

  private:
    virtual void routine();
    static SortService* m_instance_pn;
};

#endif
