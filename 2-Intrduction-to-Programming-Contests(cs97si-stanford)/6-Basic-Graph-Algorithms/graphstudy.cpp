#include <iostream>
#include <vector>
#include <queue>
#include <set>
using namespace std;

typedef struct edge {
	int start;
	int to;
} edge;

typedef struct adjList {
	int to;
	int nextID;
} adjList;

typedef struct Graph {
	int* LE;
	adjList* E;
	int n;
	int m;
	int max;
	int point;
	int istree;
}Graph;
Graph G;
vector<int> dfsSortVector;
vector<int> topologicalSortVector;
void inputGraph();
void inputGraph() {
	G.LE = NULL;
	G.E = NULL;
	G.m = 0;
	G.n = 0;
	G.istree = 1;
	G.point = 0;
	G.max = 0;
	int st, ed, n = 0, m = 0;
	edge thisedge;
	vector<edge> edges;
	while (true) {
		cin >> st >> ed;
		n = n > st ? n : st;
		n = n > ed ? n : ed;
		if (st == 0 && ed == 0) {
			break;
		}
		if (st == -1 && ed == -1) {
			kill = 1;
			break;
		}
		thisedge.start = st;
		thisedge.to = ed;
		edges.push_back(thisedge);
	}
	m = edges.size();
	G.max = n;
	G.LE = new int[n + 1];
	G.E = new adjList[m];
	G.point = n;
	int* CountNum = new int[n + 1];
	int* Choose = new int[n + 1];
	for (int i = 0; i < n + 1; ++i) {
		G.LE[i] = -1;
		CountNum[i] = 0;
		Choose[i] = 0;
	}
	n = 0;
	for (int i = 0; i < m; ++i) {
		int st = edges[i].start;
		int ed = edges[i].to;
		Choose[ed] = 1;
		if (CountNum[st] == 0) {
			n++;
			CountNum[st] = 1;
		}
		if (CountNum[ed] == 0) {
			n++;
			CountNum[ed] = 1;
		}
		if (G.LE[st] == -1) {
			G.LE[st] = i;
			G.E[i].to = ed;
			G.E[i].nextID = -1;
		}
		else {
			G.E[i].to = ed;
			G.E[i].nextID = G.LE[st];
			G.LE[st] = i;
		}
	}
	for (int i = 0; i < n + 1; ++i) {
		if (CountNum[i] == 1 && Choose[i] == 0) {
			G.point = i;
			G.istree = 1;
			break;
		}
		else {
			G.point = i;
			G.istree = 0;
		}
	}
	G.n = n;
	G.m = m;
}

void DFS(int point){
  dfsSortVector.push_back(point);
  int iter = G.LE[point];
  while(iter != -1){
    int newPoint = G.E[iter].to;
    DFS(newPoint);
    iter = G.E[iter].nextID;
  }
}

void TopologicalSort(){
  int deg[G.n + 1];
  for(int i = 0; i < n + 1; ++i){
    deg[i] = 0;
  }
  for(int i = 0; i < n + 1; ++i){
    int iter = G.LE[i];
    while(iter != -1){
      deg[G.E[iter].to] += 1;
      iter = G.E[iter].nextID;
    }
  }
  queue<int> topo;
  for(int i = 0; i < n + 1; ++i){
    if(deg[i] == 0){
      topo.push(i);
    }
  }
  while(!topo.empty()){
    int point = topo.front();
    int iter = G.LE[point];
    while(iter != -1){
      deg[G.E[iter].to] -= 1;
      if(deg[G.E[iter].to] == 0){
        queue.push(G.E[iter].to);
      }
      iter = G.E[iter].nextID;
    }
  }
}


void kurskal(Graph G){
	int* LE = G.LE;
	adjList* E = G.E;
	int n = G.n;
	int m = G.m;
	set<int> super_node;
	SortEdge();
}

void SortEdge(Graph G){
	int* LE = G.LE;
	adjList* E = G.E;
	vector<int>
}