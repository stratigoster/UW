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

//map<int, node*> hash;

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

void rebuildIndices() {
  counter = 128;
  node* temp = root;
  list<node*> queue;
//  map<node*,bool> visited;
  queue.push_back(temp);
//  visited[temp]=true;
  while (!queue.empty()) {
    temp= queue.front(); queue.pop_front();
    temp->num = counter--;
    if (temp->right) {
//      visited[temp->right]=true;
      queue.push_back(temp->right);
    }
    if (temp->left) {
//      visited[temp->left]=true;
      queue.push_back(temp->left);
    }
  }
}

void printTree() {
  cout << "BEGIN" << endl;
  node* temp = root;
  list<node*> queue;
//  map<node*,bool> visited;
  queue.push_back(temp);
//  visited[temp]=true;
  while (!queue.empty()) {
    temp= queue.front(); queue.pop_front();
//    cout << "node: " << temp->num << " int: " << (int)temp->c << " freq: " << temp->freq << endl;
    if (temp->right) {
//      visited[temp->right]=true;
      queue.push_back(temp->right);
      cout << "parent of " << temp->right->num << "= " << temp->num << endl;
    }
    if (temp->left) {
//      visited[temp->left]=true;
      queue.push_back(temp->left);
      cout << "parent of " << temp->left->num << "= " << temp->num << endl;
    }
  }
  cout << "END" << endl << endl;
}

node* findNode(int c) {
  node* temp = root;
  list<node*> queue;
  queue.push_back(temp);
  while (!queue.empty()) {
    temp = queue.front(); queue.pop_front();
    if (temp->c == c) {
      return temp;
    }
    if (temp->right) {
      queue.push_back(temp->right);
    }
    if (temp->left) {
      queue.push_back(temp->left);
    }
  }
//  cout << "shouldnt be here" << endl;
  return NULL;
}

void doStuff(node* curr) {
  // using BFS to find node with highest number in block
  node* max = curr;
  node* temp = root;
  list<node*> queue;
//  map<node*,bool> visited;
  queue.push_back(temp);
//  visited[temp]=true;
  while (!queue.empty()) {
    temp= queue.front(); queue.pop_front();
    if (temp->freq == curr->freq && temp->num > max->num) {
      max = temp;
    }
    if (temp->right) { 
//      visited[temp->right]=true;
      queue.push_back(temp->right);
    }
    if (temp->left) {
//      visited[temp->left]=true;
      queue.push_back(temp->left);
    }
  }

  if (curr != max) {
    if (curr->parent == max->parent) {
      // swap nodes
      temp = curr->parent->left;
      curr->parent->left = curr->parent->right;
      curr->parent->right = temp;
    }
    else {
      // swap nodes
      temp = curr;
      if (curr->parent->left == curr) {
        curr->parent->left = max;
      }
      else {
        curr->parent->right = max;
      }
      if (max == root) { cout << "CRAP" << endl; }
      if (max->parent->left ==max) {
        max->parent->left = temp;
      }
      else {
        max->parent->right = temp;
      }
      // swap parents
      temp = max->parent;
      max->parent = curr->parent;
      curr->parent = temp;
    }
    // rebuild hash
/*    map<int,node*>::iterator it_max = hash.find(max->c);
    map<int,node*>::iterator it_curr = hash.find(curr->c);
    if (it_curr != hash.end()) {
      hash[curr->c] = curr;
    }
    if (it_max != hash.end()) {
      hash[max->c] = max;
    }
*/
  }
  rebuildIndices(); 
  int newFreq = 0;
  if (curr->left) {
    newFreq += curr->left->freq;
  }
  if (curr->right) {
    newFreq += curr->right->freq;
  }
  curr->freq = newFreq;
  if (curr != root) {
    doStuff(curr->parent);
  }
}

void updateModel(int c) {
//  map<int, node*>::iterator it_pn = hash.find(c);
  node* curr = findNode(c);
  if (curr == NULL) {
    curr = NYT;
    // new int
    node* leftNode = new node;
    node* rightNode = new node;

    NYT->left = leftNode;
    NYT->right = rightNode;
    NYT->freq = 0;

    rightNode->parent = NYT;
    rightNode->left = NULL;
    rightNode->right = NULL;
    rightNode->freq = 1;
    rightNode->c = c;
    rightNode->num = counter--;
//    hash[c] = rightNode;

    // NYT
    leftNode->parent = NYT;
    leftNode->left = NULL;
    leftNode->right = NULL;
    leftNode->freq = 0;
    leftNode->c = EOF;
    leftNode->num = counter--;

    NYT = leftNode;
    
    /*
    if (curr != root) {
      curr = curr->parent;
    }
    */
  }
  else {
//    curr = it_pn->second;
    if (curr->c == 'e') {
//      cout << "it's e!" << endl;
      if (curr->parent == curr) {
        cout << "OMG" << endl;
      }
    }
  }
  rebuildIndices();
  doStuff(curr);
}

string getCode(node* curr) {
  if (curr == NULL) {
    return "";
  }
  rebuildIndices();
  // get encoding
  string path = "";
  while (curr != root) {
    //cout << "curr: " << curr->num << endl;
    if (curr == curr->parent->left) {
      path = "0" + path;
    }
    else {
      path = "1" + path;
    }
    curr = curr->parent;
    if (curr == curr->parent) {
      cout << "WTF" << endl;
      cout << "node: " << curr->num << endl;
      cout << "parent: " << curr->parent->num << endl;
//      printTree();
      return path;
    }
  }
  return path;
}

void encode(int c) {
//  map<int, node*>::iterator it_pn = hash.find(c);
  node* result = findNode(c);
  if (result == NULL) {
    // not in tree yet
    cout << c;
  }
  else {
    cout << getCode(findNode(c));
  }
}

int main() {
  int c;
  initializeModel();
  while ((c = getchar()) != EOF) {
//  while (cin >> c) {
//    printTree();
    encode(c);
    updateModel(c);
  }
}
