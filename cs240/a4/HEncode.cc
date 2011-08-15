#include <vector>
#include <map>
#include <list>
#include <string>
#include <queue>
#include <iostream>
#include <fstream>
#include <math.h>
using namespace std;

map<int,int> freq;
list<int> buffer;

struct node {
  node* left;
  node* right;
  node* parent;
  int c;
  int freq;
};

int bin2dec(string binstr) {
  int result = 0;
  char c;
  for(unsigned int i=0; i<binstr.length(); ++i) {
    c = binstr.at(i);
    if (c=='1') {
      result += (int)pow(2,i);
    }
  }
  return result;
}

struct nodeCmp {
  bool operator() (const node* na, const node* nb) {
    return (na->freq > nb->freq);
  }
};

node* root;

void buildTree() {
  priority_queue<node*,vector<node*>,nodeCmp> PQ;
  for (int i=0; i<128; ++i) {
    node* curr = new node;
    curr->left = curr->right = curr->parent = NULL;
    curr->c = i;
    curr->freq = freq[i];
    PQ.push(curr);
  }
  node* left;
  node* right;
  node* newroot;
  while (PQ.size() > 1) {
    left = PQ.top(); PQ.pop();
    right = PQ.top(); PQ.pop();
    newroot = new node;
    newroot->left = left;
    newroot->right = right;
    newroot->parent = NULL;
    newroot->c = EOF;
    newroot->freq = left->freq + right->freq;
    left->parent = right->parent = newroot;
    PQ.push(newroot);
  }
  root = PQ.top();
}

node* findNode(int c) {
  node* temp = root;
  list<node*> Q;
  Q.push_back(temp);
  while (!Q.empty()) {
    temp = Q.front(); Q.pop_front();
    if (temp->c == c) {
      return temp;
    }
    if (temp->right) {
      Q.push_back(temp->right);
    }
    if (temp->left) {
      Q.push_back(temp->left);
    }
  }
  return NULL;
}

string encode(int c) {
  node* curr = findNode(c);
  string path = "";
  while (curr != root) {
    if (curr == curr->parent->left) {
      path = "0" + path;
    }
    else {
      path = "1" + path;
    }
    curr = curr->parent;
  }
  return path;
}

int charCount = 0;
int blockCount = 3;

int main() {
  for (int i=0; i<128; ++i) {
    // initialize frequences of all chars to 1
    freq[i]=1;
  }
  buildTree();
  int c;
  string s;
  while ((c=getchar()) != EOF) {
    s = encode(c);
    for (unsigned int i=0; i<s.length(); ++i) {
      buffer.push_back(s.at(i));
    }
    if (buffer.size() > 7) {
      string temp = "";
      for (int i=0; i<8; ++i) {
        temp += buffer.front();
        buffer.pop_front();
      }
      cout << (char)bin2dec(temp);
    }
    freq[c]++;
    charCount++;
    if (charCount == pow(10,blockCount)) {
      blockCount++;
      buildTree();
      charCount = 0;
    }
  }
  if (!buffer.empty()) {
    string temp = "";
    while (!buffer.empty()) {
      temp += buffer.front();
      buffer.pop_front();
    }
    cout << (char)bin2dec(temp);
  }
  ofstream huff_freq("huff.freq");
  for (int i=0; i<128; ++i) {
    huff_freq << freq[i] << endl;
  }
  huff_freq.close();
  ofstream huff_code("huff.code");
  for (int i=0; i<128; ++i) {
    huff_code << encode(i) << endl;
  }
  huff_code.close();
}
