BufferedReader reader;
String [] freq;
void setup(){
  size(850,650);
  background(255);
  rectMode(CENTER);
  int x = width/2;
  int y = 0;
  int w = 0;
  int h = 0;
  //reader = createReader("wordfrequency.txt");
  String [] data = loadStrings("wordfrequency.txt");
  int [] size = int(split(data[0],':'));
  float x_scale = width/size[1];
  float y_scale = height/data.length;
  w = int(x_scale*size[1]);
  h = int(y_scale*size[0]);
  y += int(.01*w);  
  fill(255);
  rect(x,y,h,w);  
  for (int i = 1; i < data.length;i++){
    y += int(.01*w);    
    size = int(split(data[i],':'));
    h = int(x_scale*size[1]);
    w = int(y_scale*size[0]);
    //y += int(.5*w);    
    fill(255);
    rect(x,y,w,h);
    
   //rect(width/2,50,30,10);
    
    
  }

  
  //try {          
  //        reader = createReader("wordfrequencies.txt");          
  //        int i = 0;
  //        int max = 0;
  //        while (reader.hasNextLine()) {
  //             String line = s.nextLine();
  //             String numstr = line.split(": ")[1];
  //             int num = Integer.parseInt(numstr);
  //             if (i == 0) {
  //                  max = num;
  //             }
  //             normalizedWordCounts[i] = num/(float)max;
  //             i++;
  //        }
          
  //        s.close();
  //   } catch (IOException e) {
  //        e.printStackTrace();          
}
//}