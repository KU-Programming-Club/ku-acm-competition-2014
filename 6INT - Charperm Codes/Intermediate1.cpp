#include <algorithm>
#include <cstring>
#include <iostream>
using namespace std;

int main()
{
    int n;
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        char sor[55];
        std::cin >> sor;
        if(!std::next_permutation(sor,sor+strlen(sor))) {
            std::cout << "No successor" << std::endl;
        } else {
            std::cout << sor << std::endl;
        }
    }
    return 0;
}
