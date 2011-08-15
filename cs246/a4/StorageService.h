#ifndef __STORAGESERVICE_H
#define __STORAGESERVICE_H
#include "Service.h"

class StorageService : public Service {
  public:
    static StorageService* getInstance();

  private:
    virtual void routine();
    static StorageService* m_instance_pn;
};

#endif
