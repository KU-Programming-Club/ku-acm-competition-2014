
#include <iostream>
#include <stdlib.h>
using namespace std;

class Bot {
  public: 
    int x, y, dir, rot;
    void rotate();
    Bot move();
};

bool isValid(Bot, int, int);

int main() {
  int numTests, w, h, t;
  Bot bot;
  
  cin >> numTests;
  for(int i=0; i < numTests; i++){
    cin >> w >> h >> bot.x >> bot.y >> bot.dir >> bot.rot >> t;
    if (w > 1 && h > 1)
    {
      while(t > 0)
      {
        if (isValid(bot.move(), w, h))
	{
          bot = bot.move();
          t--;
	}
        else
          bot.rotate();
      }
    }
    cout << bot.x << " " << bot.y << endl;
  }    
  return 0;
}

void Bot::rotate()
{
  dir += rot;
  if (dir < 0)
    dir += 360;
  else if (dir >= 360)
    dir -= 360;
}

Bot Bot::move()
{
  Bot temp;
  temp.x = x; temp.y = y; temp.dir = dir; temp.rot = rot;
  switch (temp.dir){
  case 0: temp.x++; break;
  case 90: temp.y--; break;
  case 180: temp.x--; break;
  case 270: temp.y++; break;
  default: cerr << "HOW DID THIS HAPPEN?!?!?!\n" << temp.dir; exit(1); 
  }
  return temp;
}

bool isValid(Bot b, int w, int h)
{
  return (b.x >= 0 && b.x < w) && (b.y >= 0 && b.y < h);
}
