#include <map>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <list>
using namespace std;

struct node {
  node* parent;
  node* left;
  node* right;
  int num;
  int freq;
  int c;
};

node* root;
node* NYT;
int counter = 128;

map<char, node*> hash;

void initializeModel() {
  root = new node;
  root->parent = NULL;
  root->left = NULL;
  root->right = NULL;
  root->freq = 0;
  root->num = counter--;
  root->c = EOF;
  NYT = root;
}

void doStuff(node* curr) {
  // using BFS to find node with highest number in block
  node* max = curr;
  node* temp = root;
  list<node*> queue;
  map<node*,bool> visited;
  queue.push_back(temp);
  visited[temp]=true;
  while (!queue.empty()) {
    temp= queue.front(); queue.pop_front();
    if (temp->freq == curr->freq && temp->num > curr->num) {
      max = temp;
    }
    if (temp->left) {
      visited[temp->left]=true;
      queue.push_back(temp->left);
    }
    if (temp->right) {
      visited[temp->right]=true;
      queue.push_back(temp->right);
    }
  }

  if (curr != max) {
    temp=curr; curr=max; max=temp;
  }
  curr->freq = curr->freq + 1;
  if (curr != root) {
    doStuff(curr);
  }
}

void updateModel(char c) {
  map<char, node*>::iterator it_pn = hash.find(c);
  node* curr; 
  if (it_pn == hash.end()) {
    curr = NYT;
    // new char
    node* leftNode = new node;
    node* rightNode = new node;

    NYT->left = leftNode;
    NYT->right = rightNode;
    NYT->freq = 1;

    rightNode->parent = NYT;
    rightNode->left = NULL;
    rightNode->right = NULL;
    rightNode->freq = 1;
    rightNode->c = c;
    rightNode->num = counter--;
    hash[c] = rightNode;

    // NYT
    leftNode->parent = NYT;
    leftNode->left = NULL;
    leftNode->right = NULL;
    leftNode->freq = 0;
    leftNode->c = EOF;
    leftNode->num = counter--;

    NYT = leftNode;
    
    if (curr != root) {
      curr = curr->parent;
    }
  }
  else {
    curr = it_pn->second;
  }

  doStuff(curr);
}

string getCode(node* curr) {
  // get encoding
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

void encode(char c) {
  map<char, node*>::iterator it_pn = hash.find(c);
  if (it_pn == hash.end()) {
    // not in tree yet
    cout << c;
  }
  else {
    cout << getCode(it_pn->second);
  }
}

int main() {
  char c;
  initializeModel();
  while ((c = cin.get()) != EOF) {
    if (c != '0' && c != '1') {
      cout << c;
    }
    else {
      node* curr = root;
      while ((c == '0' || c == '1') && c != EOF) {
        if (!curr) {
          break;
        }
        if (c == '0') {
          curr = curr->left;
        }
        else {
          curr = curr->right;
        }
        if (curr->c != EOF) {
          cout << (char)curr->c;
          break;
        }
        c = cin.get();
        if (c != '0' && c != '1' && c != EOF) {
          cout << c;
          break;
        }
      }
    }
    updateModel(c);
  }
}
