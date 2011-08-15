#ifndef CACHE_H
#define CACHE_H

#include <map>
#include <vector>
#include <string>
#include "server.h"
#include "readersWriter.h"

class Cache {
    public:
        Cache();
        void addFileName( const std::string &topic, const unsigned int server, const std::string &fileName );
        void addUrl( const std::string &url, const std::string &topic );
        bool retrieveTopic( std::string &fileNames, const std::string &topic );
        bool retrieveUrl( std::string &content, const std::string &url );
        void clear();
        void printAll();

    private:
        std::map<std::string,unsigned int> fileName2serverId;
        std::map<std::string,std::string> url2contents;
        Server::Topic2FileNames topic2fileNames;
        ReadersWriter lock_topic, lock_url;
};

#endif
