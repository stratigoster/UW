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

struct node {
  node* left;
  node* right;
  node* parent;
  int c;
  int freq;
};

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

void encode(int c) {
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
  cout << path;
}

int charCount = 0;
int blockCount = 3;

string int2bin(int i) {
  string result = "";
  int remainder;
  while (i != 0) {
    remainder = i % 2; i %= 2;
    result += remainder;
  }
  return result;
}

int main() {
  for (int i=0; i<128; ++i) {
    // initialize frequences of all chars to 1
    freq[i]=1;
  }
  buildTree();
  int c;
  node* curr = root;
  while ((c=getchar()) != EOF) {
    if (c == '0') {
      curr = curr->left;
    }
    else if (c == '1') {
      curr = curr->right;
    }
    if (curr->c != EOF) {
      cout << (char)curr->c;
      freq[curr->c]++;
      charCount++;
      if (charCount == pow(10,blockCount)) {
        blockCount++;
        buildTree();
        charCount = 0;
      }
      curr = root;
    } 
  }
}
