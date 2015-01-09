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
boolean anti_hack() {
  int numbers_second_dimension=0;
  String[] check=split(highscorestr[0], ' ');
  pass=int(check[0]);
  high=0;
  int number=1;
  check=split(highscorestr[1], ' ');
  for (int i=1;int(check[0])!=0;i++) {
    check=split(highscorestr[i], ' ');
    if (int(check[0])!=0) {
      if (int(check[0])+int(check[1])-1==15 && int(check[1])<11) {
        high*=10;
        high+=int(check[1])-1;
        checking=true;
      }
      if (int(check[0])+int(check[1])-1!=15 || int(check[1])>10) {
        return false;
      }
      number++;
    }
  }
  check=split(highscorestr[number],  ' ');
  endpass=int(check[1]);
  if (high%pass_antihack==pass && high%endpass_antihack==endpass) {
    highscore=high;
    return true;
  }
  return false;
}
