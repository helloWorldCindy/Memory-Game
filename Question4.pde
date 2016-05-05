/*picture credit
 img1:http://www.langtuw.com/Artc/show/1213
 img2:http://www.icec.org.cn/xwzx/201406/08/70841.html
 img3:http://allmumrecipe.blogspot.ca/2013/09/blog-post_9710.html
 img4:http://062220099.tw.tranews.com/
 img5:http://www.go2hn.com/jiachangcai/jcc-00003.htm
 img6:http://zh.wikipedia.org/wiki/%E7%89%9B%E9%9B%9C
 */
tile[] tiles=new tile[12];
int time;
int[] trackClicked=new int[100];
int[] track=new int[100];
boolean keep=false;
int[] show=new int[12];
void setup()
{
  time=0;
  size(600, 600);
  //create a number list to decide which picture put in the rectangles
  int[] numberList= {
    1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6
  };
  randomize(numberList);//shuffle the number list
  for (int i=0; i<tiles.length; i++)
  {
    tiles[i]=new tile(numberList[i]);
    tiles[i].reveal=false;
    show[i]=0;
  }
  for (int i=0; i<100; i++)
  {
    trackClicked[i]=0;
    track[i]=0;
  }
}
//write a function to shufflet the number list 
void randomize(int[] a)
{ 
  int temp;
  for (int i=0; i<a.length; i++)
  {
    int pick=(int)random(a.length);
    temp=a[i];
    a[i]=a[pick];
    a[pick]=temp;
  }
}

void draw()
{
  background(0);
  rectMode(CENTER);
  int trueTiles=0;
  for (int i=0; i<tiles.length; i++)
  {
    if (tiles[i].reveal==false)//if the tile's reveal boolean is false, the tiles filled with white color
    {
      fill(color(255));
    }

    if (i<4)//place the tiles in the form of 4*3
    {
      tiles[i].x=140*(i+1)-50;
      tiles[i].y=80;
    } else if (i>=4&&i<8)
    {
      tiles[i].x=140*(i-3)-50;
      tiles[i].y=250;
    } else
    {
      tiles[i].x=140*(i-7)-50;
      tiles[i].y=420;
    }
    rect(tiles[i].x, tiles[i].y, tiles[i].tileWidth, tiles[i].tileHeight);

    if (tiles[i].reveal==true)//if the tiles is clicked
    {

      show[i]++;
      imageMode(CENTER);
      if (show[i]%3==0&&show[i]<23)
      {
        fill(255, 255, 0);//make the transition effect
      } else
      {
        image(tiles[i].tileColor, tiles[i].x, tiles[i].y);//show the picture
      }
    } else
    {
      show[i]=0;
    }
    fill(0);
    if (tiles[i].reveal==true)
    {
      trueTiles++;//tracking how many tiles is revealed
    }
  }

  if (time>1&&time%2!=0)
  {
    //Clicking on a third tile reveals it and hides the previously revealed tiles when the previous two tiles' number is not the same
    if ((track[time-3]!= track[time-2]))
    {
      tiles[trackClicked[time-3]].reveal=false;
      tiles[trackClicked[time-2]].reveal=false;
    }
    //When two revealed tiles have the same color, they remain revealed until the game is over 
    else
    {
      tiles[trackClicked[time-3]].reveal=true;
      tiles[trackClicked[time-2]].reveal=true;
    }
  }
  //if all the tiles are revealed,the game is over
  if (trueTiles==tiles.length)

  {
    gameOver();
  }
}
boolean over;
//create the tile class
class tile
{
  int x;
  int y;
  PImage tileColor;
  boolean reveal;
  int number;
  int tileWidth;
  int tileHeight;
  PImage[] images= {
    loadImage("img1.jpg"), loadImage("img2.jpg"), loadImage("img3.jpg"), loadImage("img4.jpg"), loadImage("img5.jpg"), loadImage("img6.jpg"),
  };
  tile( int colorNumber)
  {
    reveal=false;
    tileWidth=120;
    tileHeight=120;
    number=colorNumber;
    tileColor=images[number-1];
  }
}

void mouseClicked()
{

  for (int i=0; i<tiles.length; i++)
  {//when the mouse click in the area of the tiles
    if (mouseX<=tiles[i].x+tiles[i].tileWidth/2&&mouseX>=tiles[i].x-tiles[i].tileWidth/2&&mouseY>=tiles[i].y-tiles[i].tileHeight/2&&mouseY<=tiles[i].y+tiles[i].tileHeight/2&&tiles[i].reveal==false)
    {
      tiles[i].reveal=true;

      time++;
      track[time-1]=tiles[i].number;
      trackClicked[time-1]=i;
    }
  }
  //the game restart when the player win the game and click at the screen
  if (over==true)
  {
    //reset all the variables
    setup();
    over=false;
  }
}


void gameOver()
{

  fill(255);
  textSize(50);
  //if the player win , show the 'you win' text
  text("YOU WIN", 200, 540);
  over=true;
}

