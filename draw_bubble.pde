PImage img, start, back;
PImage sticker, filter, text, save;
PImage threshold, gray, invert, erode, dilate;

PImage bubble;

int times = 0;
int state = 0;
int colorState = 0;
int X;
int pics = 0;

float[] px = new float[100];
float[] py = new float[100];
int n = 0;


void setup() {
  //設置視窗大小
  size(700, 950);
  //載入起始畫面並設置大小、位置
  start = loadImage("data/UI/start.png");
  start.resize(700,0);
  image(start, 0, 0);
}

//滑鼠點擊效果
void mousePressed() {
  if(state == 0){
    //如果滑鼠第一次點擊，則從檔案選取圖片。
    if (( mousePressed == true ) && ( times < 1 )){
        selectInput("Select a file to process:", "fileSelected");
        times = times + 1;}
    //如果點擊特定位置，則改變變數→並進入其他功能頁。
    else if((mouseX>=0 && mouseX<=175) && (mouseY>=700 && mouseY<=950))
        {state = 1;
         frameRate(5);}
    else if((mouseX>175 && mouseX<=350) && (mouseY>=700 && mouseY<=950))
        {state = 2;
         frameRate(5);}
    else if((mouseX>350 && mouseX<=525) && (mouseY>=700 && mouseY<=950))
        {state = 3;}
    //儲存功能鍵
    else if((mouseX>520 && mouseX<=750) && (mouseY>=700 && mouseY<=950))
        {PImage partialSave = get(0, 0, 700, 700);
         pics++;
         partialSave.save("image/" + year() + month() + day() +"(" + pics + ").png");}}
       
   //貼紙功能：如果點擊特定位置，則載入特定貼紙。
   else if ((state == 1) && !((mouseX>=540 && mouseX<=680) && (mouseY>=630 && mouseY<=680))){
          if((mouseX>=45 && mouseX<=270) && (mouseY>=760 && mouseY<=815))
          {stickerState = 1;}
          else if((mouseX>50 && mouseX<=175) && (mouseY>=815 && mouseY<=935))
          {stickerState = 2;}
          else if((mouseX>195 && mouseX<=275) && (mouseY>=840 && mouseY<=920))
          {stickerState = 3;}
          else if((mouseX>280 && mouseX<=370) && (mouseY>=755 && mouseY<=865))
          {stickerState = 4;}
          else if((mouseX>390 && mouseX<=460) && (mouseY>=755 && mouseY<=865))
          {stickerState = 5;}
          else if((mouseX>295 && mouseX<=455) && (mouseY>=887 && mouseY<=927))
          {stickerState = 6;}
          else if((mouseX>470 && mouseX<=655) && (mouseY>=760 && mouseY<=800))
          {stickerState = 7;}
          else if((mouseX>470 && mouseX<=655) && (mouseY>=805 && mouseY<=855))
          {stickerState = 8;}
          else if((mouseX>470 && mouseX<=560) && (mouseY>=865 && mouseY<=935))
          {stickerState = 9;}
          else if((mouseX>575 && mouseX<=660) && (mouseY>=870 && mouseY<=935))
          {stickerState = 10;}
        }
         
   //濾鏡功能：如果點擊特定位置，則套用濾鏡。
   else if(state == 2){
     if((mouseX>=50 && mouseX<=150) && (mouseY>=775 && mouseY<=875)){
      X = THRESHOLD;
      filter_();
      redraw();}
      else if((mouseX>=175 && mouseX<=275) && (mouseY>=775 && mouseY<=875)){
      X = GRAY;
      filter_();
      redraw();}
      else if((mouseX>=300 && mouseX<=400) && (mouseY>=775 && mouseY<=875)){
      X = INVERT;
      filter_();
      redraw();}
      else if((mouseX>=425 && mouseX<=525) && (mouseY>=775 && mouseY<=875)){
      X = ERODE;
      filter_();
      redraw();}
      else if((mouseX>=550 && mouseX<=650) && (mouseY>=775 && mouseY<=875)){
      X = DILATE;
      filter_();
      redraw();}
    }
   
   //泡泡功能:點擊特定位置，改變色系。
   else if ((state == 3) && !((mouseX>=540 && mouseX<=680) && (mouseY>=630 && mouseY<=680))){
      if (n < 100){ //如果滑鼠點擊次數小於100
          if((mouseX>=15 && mouseX<=135) && (mouseY>=775 && mouseY<=950))
          {colorState = 1;}
          else if((mouseX>150 && mouseX<=270) && (mouseY>=775 && mouseY<=950))
          {colorState = 2;}
          else if((mouseX>290 && mouseX<=410) && (mouseY>=775 && mouseY<=950))
          {colorState = 3;}
          else if((mouseX>430 && mouseX<=550) && (mouseY>=775 && mouseY<=950))
          {colorState = 4;}
          else if((mouseX>570 && mouseX<=685) && (mouseY>=775 && mouseY<=950))
          {colorState = 5;}
      px[n] = mouseX; py[n] = mouseY; n++; }
   }   
}

//選擇檔案
void fileSelected(File selection) {img = loadImage(selection.getAbsolutePath());}

//調整圖片大小以適應視窗
void currentImage(){
     if   ( img.width >= img.height){
            img.resize(700, 0);
            image(img, 0, (700-img.height)/2);} 
     else { img.resize(0, 700);
            image(img, (700-img.width)/2, 0); }
      //轉換泡泡的色系
      switch(colorState){case 1: dot1(); break;
                         case 2: dot2(); break;
                         case 3: dot3(); break;
                         case 4: dot4(); break;
                         case 5: dot5(); break;
                       }
}            


void dot1(){
     int i;
     float w, p;
     colorMode(HSB, 360, 100, 100);
     for ( i = 0; i <= n-1 ; i++) {
           w = random(5, 60); //圓形直徑範圍(隨機泡泡大小)
           p = random(30, 255); //透明度範圍(泡泡的透明度)
           noStroke();
           fill(203, 46, 92, p);
           ellipse(px[i], py[i], w, w);           
    }
}

void dot2(){
     int i;
     float w, p;
     colorMode(HSB, 360, 100, 100);
     for ( i = 0; i <= n-1 ; i++) {
           w = random(5, 60);
           p = random(30, 255);
           noStroke();
           fill(#036EB8,p);
           ellipse(px[i], py[i], w, w);           
    }
}

void dot3(){
     int i;
     float w, p;
     colorMode(HSB, 360, 100, 100);
     for ( i = 0; i <= n-1 ; i++) {
           w = random(5, 60);
           p = random(30, 255);
           noStroke();
           fill(#74C5B6,p);
           ellipse(px[i], py[i], w, w);           
    }
}

void dot4(){
     int i;
     float w, p;
     colorMode(HSB, 360, 100, 100);
     for ( i = 0; i <= n-1 ; i++) {
           w = random(5, 60);
           p = random(30, 255);
           noStroke();
           fill(#E990A3,p);
           ellipse(px[i], py[i], w, w);           
    }
}

//隨機顏色設置
void dot5(){
     int i;
     float w, p, h0, h;
     colorMode(HSB, 360, 100, 100);//色相,飽和度,透明度
     h0 = random(0, 360);//色相範圍
     for ( i = 0; i <= n-1 ; i++) {
           h = h0 + random(-30, 30);//同色系
           w = random(5, 60);//圓形直徑範圍(隨機泡泡大小)
           p = random(30, 255);//透明度範圍(泡泡的透明度)
           noStroke();
           fill(h, 30, 100, p);
           ellipse(px[i], py[i], w, w);           
    }
}


void draw() {
  frameRate(5);
  if (img != null) {
      background(#FFFFFF);
      currentImage();
      filter(X);
      drawsticker();
    if (times >= 1) {
      switch(state){case 0: base();    break;
                    case 1: sticker(); break;
                    case 2: filter_(); break;
                    case 3: text_();   break;}
    }
    }
  }

float stickerX;
float stickerY;
int stickerState= 0 ;
PImage sticker1,sticker2,sticker3,sticker4,sticker5;
PImage sticker6,sticker7,sticker8,sticker9,sticker10;


void drawsticker(){
       switch(stickerState){case  1:  sticker1()  ; break;
                            case  2:  sticker2()  ; break;
                            case  3:  sticker3()  ; break;
                            case  4:  sticker4()  ; break;
                            case  5:  sticker5()  ; break;
                            case  6:  sticker6()  ; break;
                            case  7:  sticker7()  ; break;
                            case  8:  sticker8()  ; break;
                            case  9:  sticker9()  ; break;
                            case 10:  sticker10() ; break;}
}


void mouseClicked(){
  if ((state == 1) && !((mouseX>=540 && mouseX<=680) && (mouseY>=630 && mouseY<=680))){
     stickerX = mouseX;
     stickerY = mouseY;}
}

void sticker1(){
   if (state == 1){
     sticker1 = loadImage("data/sticker/sticker1.png");
     image(sticker1, mouseX-200, mouseY-200);}
     image(sticker1, stickerX-200, stickerY-200);
}

void sticker2(){
   if (state == 1){
     sticker2 = loadImage("data/sticker/sticker2.png");
     image(sticker2, mouseX-100, mouseY-100);}
     image(sticker2, stickerX-100, stickerY-100);
}

void sticker3(){
   if (state == 1){
     sticker3 = loadImage("data/sticker/sticker3.png");
     image(sticker3, mouseX-300, mouseY-400);}
     image(sticker3, stickerX-300, stickerY-400);
}

void sticker4(){
   if (state == 1){
     sticker4 = loadImage("data/sticker/sticker4.png");
     image(sticker4, mouseX-300, mouseY-300);}
     image(sticker4, stickerX-300, stickerY-300);
}

void sticker5(){
   if (state == 1){
     sticker5 = loadImage("data/sticker/sticker5.png");
     image(sticker5, mouseX-250, mouseY-150);}
     image(sticker5, stickerX-250, stickerY-150);
}

void sticker6(){
   if (state == 1){
     sticker6 = loadImage("data/sticker/sticker6.png");
     image(sticker6, mouseX-250, mouseY-150);}
     image(sticker6, stickerX-250, stickerY-150);
}

void sticker7(){
   if (state == 1){
     sticker7 = loadImage("data/sticker/sticker7.png");
     image(sticker7, mouseX-100, mouseY-100);}
     image(sticker7, stickerX-100, stickerY-100);
}

void sticker8(){
   if (state == 1){
     sticker8 = loadImage("data/sticker/sticker8.png");
     image(sticker8, mouseX-100, mouseY-100);}
     image(sticker8, stickerX-100, stickerY-100);
}

void sticker9(){
   if (state == 1){
     sticker9 = loadImage("data/sticker/sticker9.png");
     image(sticker9, mouseX-50, mouseY-50);}
     image(sticker9, stickerX-50, stickerY-50);
}

void sticker10(){
   if (state == 1){
     sticker10 = loadImage("data/sticker/sticker10.png");
     image(sticker10, mouseX-50, mouseY-50);}
     image(sticker10, stickerX-50, stickerY-50);
}

PImage base0;

void base(){
  fill(#BBE3F3);
  base0 = loadImage("data/UI/base0.jpg");
  base0.resize(700,0);
  image(base0, 0, 700);
}

PImage sticker0;

void sticker(){
    fill(#BBE3F3);
    sticker0 = loadImage("data/UI/sticker0.jpg");
    sticker0.resize(700,0);
    image(sticker0, 0, 700);
    if(state == 1){back();}
}

PImage filter0;

void filter_(){
  fill(#BBE3F3);
  filter0 = loadImage("data/UI/filter0.jpg");
  filter0.resize(700,0);
  image(filter0, 0, 700);
  threshold = loadImage("data/filter/threshold.png");
  gray = loadImage("data/filter/gray.png");
  invert = loadImage("data/filter/invert.png");
  erode = loadImage("data/filter/erode.png");
  dilate = loadImage("data/filter/dilate.png");
  image(threshold, 50, 775);
  image(gray, 175, 775);
  image(invert, 300, 775);
  image(erode, 425, 775);
  image(dilate, 550, 775);
  if(state == 2){back();}
}

void text_(){
  fill(#BBE3F3);
  noStroke();
  rect(0, 700, 700, 250);
      bubble = loadImage("data/UI/bubble.png");
      bubble.resize(700,0);
      image(bubble, 0, 700);
  if(state == 3){back();}
}


//返回鍵
void back(){
      //載入圖片並設置大小與位置
      back = loadImage("data/UI/back.png");
      back.resize(140,0);
      image(back, 540, 630);
      if((mousePressed != false) && (mouseX>=540 && mouseX<=680) && (mouseY>=630 && mouseY<=680)){
      base();
      state = 0;
      redraw();}
    }
