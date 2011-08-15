#include "cache.h"
#include <iostream>
using namespace std;

Cache::Cache() {}

void Cache::addFileName( const std::string &topic, const unsigned int server, const std::string &fileName ) {
    lock_topic.startWrite();

    topic2fileNames[topic].push_back(fileName);
    fileName2serverId[fileName] = server;

    lock_topic.endWrite();
}

void Cache::addUrl( const std::string &url, const std::string &content ) {
    lock_url.startWrite();

    url2contents[url] = content;

    lock_url.endWrite();
}

bool Cache::retrieveTopic( std::string &fileNames, const std::string &topic ) {
    lock_topic.startRead();

    bool rtn_result = false;
    fileNames = "";
    if ( topic2fileNames.find( topic ) != topic2fileNames.end() ) {
        rtn_result = true;
        for (unsigned int i=0; i<topic2fileNames[topic].size(); i+=1) {
            fileNames += topic2fileNames[topic][i] + "\n";
        }
    }

    lock_topic.startRead();

    return rtn_result;
}

bool Cache::retrieveUrl( std::string &content, const std::string &url ) {
    lock_url.startRead();

    bool rtn_result = false;

    map<string,string>::iterator it = url2contents.find( url );
    if (it != url2contents.end()) {
        content = url2contents[url];
        rtn_result = true;
    }

    lock_url.endRead();

    return rtn_result;
}

void Cache::clear() {
    lock_topic.startRead();
    lock_url.startRead();

    fileName2serverId.clear();
    url2contents.clear();
    topic2fileNames.clear();

    lock_url.endRead();
    lock_topic.endRead();
}

void Cache::printAll() {
    lock_topic.startRead();
    lock_url.startRead();

    cout << "CACHE: Topic to Url" << endl;
    for (map< string,vector<string> >::const_iterator it = topic2fileNames.begin();
         it != topic2fileNames.end();
         ++it) {
        cout << "Topic: " << it->first << endl;
        for (unsigned int i=0; i<it->second.size(); ++i) {
            cout << "\t" << "Server/File name: " << fileName2serverId[it->second[i]] << " " << it->second[i] << endl;
        }
    }
    cout << "CACHE: Url to File Content" << endl;
    for (map<string,string>::iterator it=url2contents.begin(); it!=url2contents.end(); ++it) {
        cout << "url " << it->first;
        if (it->second.length() > 60) {
            cout << "\t" << "some content:" << endl;
            cout << it->second.substr(0,60) << "..." << endl;
        } else {
            cout << endl << it->second << endl;
        }
    }

    lock_url.endRead();
    lock_topic.endRead();
}
