#include <iostream>
using namespace std;

struct node {
	int key;
	int value;
	node *next;
};

void find(int i, node *curr, node &answer) {
	answer.key= i;
	answer.value = -1;
	while (1) {
		if (curr->key == i) {
			answer.value = curr->value;
		}
		curr = curr->next;
		if (curr == 0) { break; }
	}
}

int main(int argc, char *argv[]) {
	node *list = new node;
	list->key = 1;
	list->value = 100;
	list->next = new node;
	list->next->key = 2;
	list->next->value = 200;
	list->next->next = new node;
	list->next->next->key = 3;
	list->next->next->value = 300;
	list->next->next->next = 0;
	node answer;
	for(int i=0; i<5; i++) {
		find(i, list, answer);
		cout << answer.key << ":" << answer.value << endl;
	}
	return 0;
}
