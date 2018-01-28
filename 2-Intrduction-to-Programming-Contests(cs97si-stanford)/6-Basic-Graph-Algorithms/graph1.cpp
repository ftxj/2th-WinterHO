#include <iostream>
#include <vector>
#include <queue>
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
void JudgeTree();
void inputGraph();
int kill = 0;
int main() {
	vector<int> caseResult;
	while (true) {
		inputGraph();
		if (kill == 1) {
			break;
		}
		JudgeTree();
		caseResult.push_back(G.istree);
	}
	for (int i = 0; i < caseResult.size(); ++i) {
		cout << "Case " << i + 1 << " is ";
		if (caseResult[i] == 0) {
			cout << "not ";
		}
		cout << "a tree.";
    if(i + 1 != caseResult.size()){
      cout << endl;
    }
	}
	return 0;
}

void JudgeTree() {
	int black = 0;
	queue<int> gray;
	int* LE = G.LE;
	adjList* E = G.E;
	int n = G.n;
	int m = G.m;
  if(n == 0 || m == 0){
    G.istree = 1;
    return;
  }
	int *HashSee = new int[G.max + 1];
	for (int i = 0; i < G.max + 1; ++i) {
		HashSee[i] = 0;
	}
	int point = G.point;
	HashSee[point] = 1;
	gray.push(point);
	while (!gray.empty()) {
		point = gray.front();
		int iter = LE[point];
		while (iter != -1) {
			int currPoint = E[iter].to;
			iter = E[iter].nextID;
			if (HashSee[currPoint] == 0) {
				HashSee[currPoint] = 1;
				gray.push(currPoint);
			}
			else {
				G.istree = 0;
			}
		}
		gray.pop();
		black++;
	}
	if (black != n) {
		G.istree = 0;
	}
}

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