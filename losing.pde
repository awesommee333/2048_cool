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
boolean lose_check() {
  for (int i=0;i<tile_amount-1;i++) {
    for (int j=0;j<tile_amount-1;j++) {
      if (tilenumber[i][j]==tilenumber[i+1][j] || tilenumber[i][j]==tilenumber[i][j+1])
        return false;
    }
  }
  for (int i=0;i<tile_amount-1;i++) {
    if (tilenumber[tile_amount-1][i]==tilenumber[tile_amount-1][i+1])
      return false;
  }
  for (int i=0;i<tile_amount-1;i++) {
    if (tilenumber[i][tile_amount-1]==tilenumber[i+1][tile_amount-1])
      return false;
  }
  return true;
}
void lose() {
  fill(255, 255, 255);
  rect(width/2-50, height/2-25, 100, 50);
  textSize(int(20*fraction));
  fill(0, 0, 0);
  text("Try Again", width/2-45, height/2-25+35);
  lost=true;
}
