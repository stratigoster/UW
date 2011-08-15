#include <iostream>
#include <list>
#include <math.h>
using namespace std;

struct well {
	int x;
	int y;
};

int wellCmp( const void *o1, const void *o2 ) {
	const well *w1 = (well *)o1;
	const well *w2 = (well *)o2;
	if (w1->x == w2->x) return (w1->y - w2->y);
	return (w1->x - w2->x);
}

int main() {
	int nwells;
	well *wells;
	cin >> nwells;
	nwells += 2;
	wells = new well[nwells];
	wells[0].x = 0, wells[0].y = 1600; // azkaban
	wells[1].x = 1600, wells[1].y = 0; // quidditch site

	// read in coordinates of wells
	for (int i=2; i<nwells; i+=1) {
		cin >> wells[i].x >> wells[i].y;
	}

	// sort wells first by x-coordinate, and then by y-coordinate
	qsort( wells, nwells, sizeof(*wells), wellCmp );

#ifdef NP_DEBUG
	for (int i=0; i<nwells; i+=1) {
		cout << wells[i].x << " " << wells[i].y << endl;
	}
#endif

	// construct adjacency list
	list<int> *graph = new list<int>[nwells];
	for (int i=0; i<nwells; i+=1) {
		for (int j=i+1; j<nwells; j+=1) {
			if ( abs( wells[i].x - wells[j].x ) > 200 ) break;
			if ( sqrt( pow( abs(wells[i].x - wells[j].x), 2 ) +
								 pow( abs(wells[i].y - wells[j].y), 2 ) ) <= 200 ) {
				graph[i].push_back(j);
			}
		}
		for (int j=i-1; j>=0; j-=1) {
			if ( abs( wells[i].x - wells[j].x ) > 200 ) break;
			if ( sqrt( pow( abs(wells[i].x - wells[j].x), 2 ) +
								 pow( abs(wells[i].y - wells[j].y), 2 ) ) <= 200 ) {
				graph[i].push_back(j);
			}
		}
	}

	double *wtime = new double[nwells];
	int *prev = new int[nwells];
	list<int> unvisited;
	for (int i=0; i<nwells; i+=1) {
		wtime[i] = (unsigned int)-1; // wtime[i] = INF
		prev[i] = -1;
		unvisited.push_back(i);
	}

	wtime[0] = 0.0; // wtime[azkaban] = 0
	int u = 0, counter=0;
	while (! unvisited.empty() ) {
		counter++;
		if (counter != 1) {
			int min = unvisited.front();
			for (list<int>::iterator it=unvisited.begin(); it!=unvisited.end(); ++it) {
				if ( wtime[*it] < wtime[min] ) {
					min = *it;
				}
			}
			u = min;
		}
		unvisited.remove(u);
		double cost_via_u, dist, time;
		for (list<int>::iterator it=graph[u].begin(); it!=graph[u].end(); ++it) {
			dist = sqrt( pow( abs(wells[u].x - wells[*it].x), 2 ) +
									 pow( abs(wells[u].y - wells[*it].y), 2 ) );
			if (dist <= 100) {
				// just travel the entire distance in dog-mode
				time = dist / 20.0;
			} else {
				time = 5.0 + (dist - 100.0)/10.0;
			}

			cost_via_u = wtime[u] + time;
			if ( cost_via_u < wtime[*it] ) {
				wtime[*it] = cost_via_u;
				prev[*it] = u;
			}
		}
	}

	// print shortest path
	list<well> result;
	u = prev[nwells-1];
	while (u != -1) {
		result.push_front(wells[u]);
		u = prev[u];
	}
	if (result.size() == 0) {
		cout << "-1" << endl;
	} else {
		cout << result.size()-1 << endl;
		for (list<well>::iterator it=result.begin(); it!=result.end(); ++it) {
			if (it->x != 0 && it->y != 1600)
				cout << it->x << " " << it->y << endl;
		}
	}

	return 0;
}