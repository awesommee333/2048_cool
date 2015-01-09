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
boolean tile_full_check() {
  boolean check=true;
  for (int i=0;i<tile_amount;i++) {
    for (int j=0;j<tile_amount;j++) {
      if (tilenumber[j][i]==0)
        check=false;
    }
  }
  return check;
}
void tile_display(int tile_xcoord, int tile_ycoord) {
  switch(tilenumber[tile_xcoord][tile_ycoord]) {
  case 0:
    fill(150, 150, 150);
    break;
  case 2:
    fill(240, 240, 240);
    break;
  case 4:
    fill(240, 240, 100);
    break;
  case 8:
    fill(252, 171, 120);
    break;
  case 16:
    fill(250, 72, 28);
    break;
  case 32:
    fill(242, 19, 7);
    break;
  case 64:
    fill(255, 3, 3);
    break;
  case 128:
    fill(255, 214, 64);
    break;
  case 256:
    fill(247, 226, 30);
    break;
  case 512:
    fill(234, 216, 2);
    break;
  case 1024:
    fill(224, 207, 9);
    break;
  case 2048:
    fill(219, 240, 7);
    break;
  default:
    fill(0, 0, 0);
  }
  textSize(int(30*fraction));
  int textlength=0;
  int textsize=30;
  rect(int((tile_xcoord*120+20)*fraction), int((tile_ycoord*120+20)*fraction)+50, int(100*fraction), int(100*fraction), int(12*fraction));
  if (tilenumber[tile_xcoord][tile_ycoord]!=0 && tilenumber[tile_xcoord][tile_ycoord]<10000) {
    for (int i=10;tilenumber[tile_xcoord][tile_ycoord]-i>=0;i*=10)
      textlength++;
    fill(70, 70, 70);
    text(""+tilenumber[tile_xcoord][tile_ycoord], int((tile_xcoord*120+60-10*textlength)*fraction), int((tile_ycoord*120+80)*fraction)+50);
  }
  if (tilenumber[tile_xcoord][tile_ycoord]>10000) {
    fill(70, 70, 70);
    for (int i=1;tilenumber[tile_xcoord][tile_ycoord]-i>=0;i*=10)
      textlength++;
    for (int i=4;i<=textlength;i++) {
      textsize-=int(textsize/(i*float((8/i))));
    }
    textSize(int(textsize*fraction));
    text(""+tilenumber[tile_xcoord][tile_ycoord], int((tile_xcoord*120+60-10*3)*fraction), int((tile_ycoord*120+80)*fraction)+50);
  }
  textSize(30);
}
void tile_new_generate() {
  if (!tile_full_check()) {
    int temp=int(random(tile_amount*tile_amount));
    while (tilenumber[temp%tile_amount][int (temp/tile_amount)]!=0) {
      temp=int(random(tile_amount*tile_amount));
    }
    int temp_2_or_4=int(random(8));
    if (temp_2_or_4==5) {
      tilenumber[temp%tile_amount][int(temp/tile_amount)]=4;
    } else {
      tilenumber[temp%tile_amount][int(temp/tile_amount)]=2;
    }
  }
}
