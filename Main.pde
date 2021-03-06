/*
  2048_cool
    Copyright (C) 2014 Awesommee333

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
int rectparameters=100;
float fraction=1.0;
int add_every_x=4;
int generate=1;
int score=0;
boolean lost=false;
int highscore;
String[] highscorestr;
PrintWriter output;
int tile_amount;
int hextoint=0;
int z=0;
int pass=0;
int endpass=0;
int high=0;
boolean checking=false;
int pass_antihack=439;
int endpass_antihack=631;
int[][] tilenumber;
void setup() {
  String[] tile_amountstr=loadStrings("tile_width.txt");
  tile_amount=int(tile_amountstr[0]);
  tilenumber=new int[tile_amount][tile_amount];
  int size_width=(120*tile_amount+20);
  int size_height=(size_width);
  if (tile_amount>5) {
    for (int i=tile_amount;i>5;i--) {
      fraction-=1/float(tile_amount);
    }
  }
  size_height=int(size_height*fraction);
  size_width=int(size_width*fraction);
  size_height+=50;
  size(size_width, size_height);
  if (tile_amount>=8) {
    for (int i=8;tile_amount>=i;i+=4) {
      generate++;
    }
  }
  textSize(int(30*fraction));
  noStroke();
  highscorestr=loadStrings("high_scores.txt");
  if (anti_hack()) {
  }
  if (!anti_hack()) {
    z=1;
  }
  for (int i=0;i<generate;i++) {
    tile_new_generate();
    tile_new_generate();
  }
}
void draw() {
  if (tile_amount==0) {
    tile_amount=4;
  }
  if (score>highscore) {
    dataPath("data/high_scores.txt");
    highscore=score;
    int power_score=1;
    int value_temp=0;
    int j=0;
    for (int i=1;score-i>=0;i*=10) {
      j++;
      power_score=i;
    }
    String[] highscorestrr=new String[j+2];
    highscorestrr[0]=str(score%pass_antihack);
    int i=0;
    for (i=1;power_score>=1;power_score/=10) {
      while (score-power_score>=0) {
        score-=power_score;
        value_temp++;
      }
      highscorestrr[i]=str(15-value_temp)+' '+str(value_temp+1);
      value_temp=0;
      i++;
    }
    score=highscore;
    highscorestrr[i]=str(0)+' '+str(score%endpass_antihack);
    saveStrings(dataPath("high_scores.txt"), highscorestrr);
  }
  clear();
  if (z==0) {
    background(100, 100, 100);
  }
  if (z!=0) {
    background(0, 0, 0);
  }
  textSize(20);
  fill(255, 255, 255);
  //highscore=int(highscorestr[0]);
  text("highscore: "+highscore, 25, 25);
  text("score: "+score, width/2+25, 25);
  for (int i=0;i<tile_amount;i++) {
    for (int j=0;j<tile_amount;j++) {
      tile_display(i, j);
    }
  }
  if (tile_full_check()) {
    if (lose_check()) {
      lose();
    }
  }
}
void keyPressed() {
  //  if (key==ESC) {//uncomment this if you want the code not to exit when escape is pressed
  //    key=0;
  //  }
  if (keyCode==RIGHT) {
    int[] tileleftnumber=new int[tile_amount];
    boolean tile_change=false;
    boolean[] changed=new boolean[tile_amount];
    for (int i=0;i<tile_amount;i++)
      tileleftnumber[i]=tile_amount-1;
    for (int i=0;i<tile_amount;i++)
      changed[i]=false;
    for (int i=0;i<tile_amount;i++) {
      for (int j=tile_amount-2;j>=0;j--) {
        if (tilenumber[j][i]!=0 && tileleftnumber[i]>j) {
          for (int x=j;x<tile_amount-1;x++) {
            if (tilenumber[x+1][i]==0) {
              tilenumber[x+1][i]=tilenumber[x][i];
              tilenumber[x][i]=0;
              tile_change=true;
            }
            if (tilenumber[x+1][i]==tilenumber[x][i] && (!changed[x])) {
              tilenumber[x+1][i]*=2;
              score+=tilenumber[x+1][i];
              tilenumber[x][i]=0;
              tile_change=true;
              changed[x+1]=true;
              changed[x]=true;
            }
          }
          tileleftnumber[i]-=1;
        }
      }
      for (int y=0;y<4;y++)
        changed[i]=false;
    }
    if (tile_change) {
      for (int i=0;i<generate;i++) {
        tile_new_generate();
      }
    }
  }
  if (keyCode==LEFT) {
    int[] tileleftnumber=new int[tile_amount];
    boolean tile_change=false;
    boolean[] changed=new boolean[tile_amount];
    for (int i=0;i<tile_amount;i++)
      tileleftnumber[i]=0;
    for (int i=0;i<tile_amount;i++)
      changed[i]=false;
    for (int i=0;i<tile_amount;i++) {
      for (int j=1;j<=tile_amount-1;j++) {
        if (tilenumber[j][i]!=0 && tileleftnumber[i]<j) {
          for (int x=j;x>0;x--) {
            if (tilenumber[x-1][i]==0) {
              tilenumber[x-1][i]=tilenumber[x][i];
              tilenumber[x][i]=0;
              tile_change=true;
            }
            if (tilenumber[x-1][i]==tilenumber[x][i] && (!changed[x])) {
              tilenumber[x-1][i]*=2;
              score+=tilenumber[x-1][i];
              tilenumber[x][i]=0;
              tile_change=true;
              changed[x-1]=true;
              changed[x]=true;
            }
          }
          tileleftnumber[i]+=1;
        }
      }
      for (int y=0;y<tile_amount;y++)
        changed[y]=false;
    }
    if (tile_change) {
      for (int i=0;i<generate;i++) {
        tile_new_generate();
      }
    }
  }
  if (keyCode==DOWN) {
    int[] tileleftnumber=new int[tile_amount];
    boolean tile_change=false;
    boolean[] changed=new boolean[tile_amount];
    for (int i=0;i<tile_amount;i++)
      tileleftnumber[i]=tile_amount-1;
    for (int i=0;i<tile_amount;i++)
      changed[i]=false;
    for (int i=0;i<tile_amount;i++) {
      for (int j=tile_amount-2;j>=0;j--) {
        if (tilenumber[i][j]!=0 && tileleftnumber[i]>j) {
          for (int x=j;x<tile_amount-1;x++) {
            if (tilenumber[i][x+1]==0) {
              tilenumber[i][x+1]=tilenumber[i][x];
              tilenumber[i][x]=0;
              tile_change=true;
            }
            if (tilenumber[i][x+1]==tilenumber[i][x] && (!changed[x])) {
              tilenumber[i][x+1]*=2;
              score+=tilenumber[i][x+1];
              tilenumber[i][x]=0;
              tile_change=true;
              changed[x+1]=true;
              changed[x]=true;
            }
          }
          tileleftnumber[i]-=1;
        }
      }
      for (int y=0;y<tile_amount;y++)
        changed[y]=false;
    }
    if (tile_change) {
      for (int i=0;i<generate;i++) {
        tile_new_generate();
      }
    }
  }
  if (keyCode==UP) {
    int[] tileleftnumber=new int[tile_amount];
    boolean tile_change=false;
    boolean[] changed=new boolean[tile_amount];
    for (int i=0;i<tile_amount;i++)
      tileleftnumber[i]=0;
    for (int i=0;i<tile_amount;i++)
      changed[i]=false;
    for (int i=0;i<tile_amount;i++) {
      for (int j=1;j<=tile_amount-1;j++) {
        if (tilenumber[i][j]!=0 && tileleftnumber[i]<j) {
          for (int x=j;x>0;x--) {
            if (tilenumber[i][x-1]==0) {
              tilenumber[i][x-1]=tilenumber[i][x];
              tilenumber[i][x]=0;
              tile_change=true;
            }
            if (tilenumber[i][x-1]==tilenumber[i][x] && (!changed[x])) {
              tilenumber[i][x-1]*=2;
              score+=tilenumber[i][x-1];
              tilenumber[i][x]=0;
              tile_change=true;
              changed[x-1]=true;
              changed[x]=true;
            }
          }
          tileleftnumber[i]+=1;
        }
      }
      for (int y=0;y<tile_amount;y++)
        changed[y]=false;
    }
    if (tile_change) {
      for (int i=0;i<generate;i++) {
        tile_new_generate();
      }
    }
  }
}
void mousePressed() {
  if (mouseX>width/2-50 && mouseX<width/2+50 && mouseY>height/2-25 && mouseY<height/2+25 && mouseButton==LEFT && lost) {
    score=0;
    for (int i=0;i<tile_amount;i++) {
      for (int j=0;j<tile_amount;j++) {
        tilenumber[j][i]=0;
      }
    }
    tile_new_generate();
    tile_new_generate();
    lost=false;
  }
}
