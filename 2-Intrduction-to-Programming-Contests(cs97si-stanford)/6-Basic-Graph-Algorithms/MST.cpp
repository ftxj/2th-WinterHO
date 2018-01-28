#include <iostream>
#include <vector>
#include <queue>
#include <set>
using namespace std;
typedef struct edge {
	int start;
	int to;
	int weight;
} edge;

int Kruskal(edge* Graph, int n, int m);
void sortEdges(edge* Graph, int m);
void quickSort(edge* Graph, int p, int r);
int parition(edge* Graph, int p, int r);

int main() {
	int n;
  while(cin >> n){
    edge* Graph = new edge [n * n];
    for (int i = 0; i < n; ++i) {
      for (int j = 0; j < n; ++j) {
        Graph[i * n + j].start = i;
        Graph[i * n + j].to = j;
        cin >> Graph[i * n + j].weight;
      }
    }
    int res = Kruskal(Graph, n, n * n);
    cout << res << endl;
  }
	return 0;
}

int Kruskal(edge* Graph, int n, int m) {
	int res = 0;
	int* superNode = new int [n];
	for (int i = 0; i < n; ++i) {
		superNode[i] = 0;
	}
	sortEdges(Graph, m);
	for (int i = 0; i < m; ++i) {
		edge smallest = Graph[i];
		if (smallest.weight != 0) {
			if (!(superNode[smallest.start] == 1 &&
				superNode[smallest.to] == 1)) {
				superNode[smallest.start] = 1;
				superNode[smallest.to] = 1;
				res += smallest.weight;
			}
		}
	}
	return res;
}

void sortEdges(edge* Graph, int m) {
	quickSort(Graph, 0, m);
}

void quickSort(edge* Graph, int p, int r) {
	if (p < r) {
		int q = parition(Graph, p, r);
		quickSort(Graph, p, q);
		quickSort(Graph, q + 1, r);
	}
}

int parition(edge* Graph, int p, int r) {
	int flag = Graph[r - 1].weight;
	int i = p - 1;
	int j = p;
	while (j < r - 1) {
		if (Graph[j].weight <= flag) {
			i++;
			edge big = Graph[j];
			Graph[j].start = Graph[i].start;
			Graph[j].to = Graph[i].to;
			Graph[j].weight = Graph[i].weight;
			Graph[i].start = big.start;
			Graph[i].to = big.to;
			Graph[i].weight = big.weight;
		}
		j++;
	}
	i++;
	edge big = Graph[r - 1];
	Graph[r - 1].start = Graph[i].start;
	Graph[r - 1].to = Graph[i].to;
	Graph[r - 1].weight = Graph[i].weight;
	Graph[i].start = big.start;
	Graph[i].to = big.to;
	Graph[i].weight = big.weight;
	return i;
}
