#include <iostream>
#include <string>
#include <bitset>
#include <sstream>
using namespace std ;

const long MaxSum = 2000*2000;
bitset<MaxSum+1> b;
long sum;
int i;

bool findPartition(const int arr[], const int n) {
    sum = 0 ;
    b.reset() ;
    b[ 0 ] = 1 ;
    for (i = 0; i < n; ++i) {
        sum += arr[i] ;
        b |= b << arr[i];
    }

    return sum % 2 == 0 && b[ sum/2 ] == 1;
}

int main() {

    int n;
    while (true) {
        std::cin >> n;
        if (n <= 0) {
            break;
        } else {
            int arr[n];
            for (int i = 0; i < n; ++i) {
                std::cin >> arr[i];
            }

            std::cout << (findPartition(arr, n) ? 1 : 0) << std::endl;
        }
    }


    return 0 ;
}
