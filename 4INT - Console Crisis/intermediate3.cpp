
#include <iostream>
#include <stdlib.h>
using namespace std;

const int CONTROLLER = 30, TAP = 15;

long getCost(long, long);

int main()
{
  int numTests; 
  long friends, controllers; 
  cin >> numTests;
  for(int i=0; i < numTests; i++){
    cin >> friends >> controllers;
    cout << getCost(friends, controllers) << endl;
  }
  return 0;
}

long getCost(long friends, long controllers) 
{
  long cost = 0;
  if (friends > controllers)
  {
    cost = (friends - controllers) * CONTROLLER;
  }
  if (friends > 4)
  {
    cost += (friends - 4) / 2 * TAP;
  }
  return cost; 
}
