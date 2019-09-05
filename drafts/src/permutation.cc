#include <iostream>
#include <algorithm>

using namespace std;

int main(void)
{
    int t[3] = {1, 1, 2};
    // Affiche l'ensemble des permutations de (1, 1, 2) :
    do
    {
        int i;
        for (i=0; i<3; ++i)
            cout << t[i] << " ";
        cout << endl;
    }
    while (next_permutation(t, t+3));
    return 0;
}
