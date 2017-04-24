String url_world = "http://feeds.bbci.co.uk/news/world/rss.xml";
String url_arts = "http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml";
String url_sci = "http://feeds.bbci.co.uk/news/science_and_environment/rss.xml";
String url_tech = "http://feeds.bbci.co.uk/news/technology/rss.xml";
String url_pol = "http://feeds.bbci.co.uk/news/politics/rss.xml";
XML rss_world;
XML rss_arts;
XML rss_sci;
XML rss_tech;
XML rss_pol;
String selection = "world";
String[] titles_world;
String[] titles_arts;
String[] titles_sci;
String[] titles_tech;
String[] titles_pol;
String header = "BBC News";
int per_page = 14;
int page = 0;
int debounce = 0;
int pageDelay = 10;
int categoryDelay = 20;
int linkDelay = 50;
boolean canOpenLink = true;
String description = "";
PFont category_font;
PFont text_font;
HashMap<String, Integer> highlights;

void setup() {
  size(800, 800);
  //Just highlighting some titles which contain trigger keywords
  highlights = new HashMap<String, Integer>();
  highlights.put("dead", 255 + 0*(1<<8) + 120*(1<<16));
  highlights.put("death", 255 + 0*(1<<8) + 140*(1<<16));
  highlights.put(" kill", 255 + 0*(1<<8) + 180*(1<<16));
  highlights.put("threat", 255 + 120*(1<<8) + 120*(1<<16));
  highlights.put("convict", 255 + 120*(1<<8) + 180*(1<<16));
  highlights.put("murder", 255 + 120*(1<<8) + 60*(1<<16));
  highlights.put("north korea", 180 + 180*(1<<8) + 0*(1<<16));
  highlights.put("iraq", 255 + 180*(1<<8) + 0*(1<<16));
  highlights.put("syria", 255 + 255*(1<<8) + 0*(1<<16));
  highlights.put("iran", 180 + 255*(1<<8) + 0*(1<<16));
  highlights.put("china", 180 + 180*(1<<8) + 60*(1<<16));
  highlights.put("isis", 180 + 120*(1<<8) + 0*(1<<16));
  highlights.put("terror", 120 + 180*(1<<8) + 0*(1<<16));
  highlights.put("trump", 255 + 0*(1<<8) + 0*(1<<16));
  highlights.put("nuclear", 0 + 255*(1<<8) + 0*(1<<16));
  highlights.put("climate", 0 + 255*(1<<8) + 180*(1<<16));
  highlights.put("environment", 0 + 255*(1<<8) + 140*(1<<16));
  highlights.put("brexit", 0 + 0*(1<<8) + 255*(1<<16));
  highlights.put("election", 0 + 180*(1<<8) + 255*(1<<16));
  category_font = createFont("Comic Sans MS", 32);
  text_font = createFont("Comic Sans MS", 20);
  textAlign(CENTER, CENTER);
  rss_world = loadXML(url_world);
  rss_arts = loadXML(url_arts);
  rss_sci = loadXML(url_sci);
  rss_tech = loadXML(url_tech);
  rss_pol = loadXML(url_pol);
  XML[] titles_world_rss = rss_world.getChildren("channel/item/title");
  titles_world = new String[titles_world_rss.length];
  for (int i = 0; i < titles_world_rss.length; i++) {
    titles_world[i] = titles_world_rss[i].getContent();
  }
  XML[] titles_arts_rss = rss_arts.getChildren("channel/item/title");
  titles_arts = new String[titles_arts_rss.length];
  for (int i = 0; i < titles_arts_rss.length; i++) {
    titles_arts[i] = titles_arts_rss[i].getContent();
  }
  XML[] titles_sci_rss = rss_sci.getChildren("channel/item/title");
  titles_sci = new String[titles_sci_rss.length];
  for (int i = 0; i < titles_sci_rss.length; i++) {
    titles_sci[i] = titles_sci_rss[i].getContent();
  }
  XML[] titles_tech_rss = rss_tech.getChildren("channel/item/title");
  titles_tech = new String[titles_tech_rss.length];
  for (int i = 0; i < titles_tech_rss.length; i++) {
    titles_tech[i] = titles_tech_rss[i].getContent();
  }
  XML[] titles_pol_rss = rss_pol.getChildren("channel/item/title");
  titles_pol = new String[titles_pol_rss.length];
  for (int i = 0; i < titles_pol_rss.length; i++) {
    titles_pol[i] = titles_pol_rss[i].getContent();
  }
}

void update() {
  debounce--;
  if (mouseY > 50) {
    //Update the description based on mouseOver
    int index = (int)((mouseY - 65)/40);
    if (index >= 0 && index < per_page) {
      switch(selection) {
        case "world":
          if (page*per_page+index >= titles_world.length)
            break;
          description = rss_world.getChildren("channel/item/description")[page*per_page+index].getContent();
          header = "BBC News, " + rss_world.getChildren("channel/item/pubDate")[page*per_page+index].getContent();
          break;
        case "arts":
          if (page*per_page+index >= titles_arts.length)
            break;
          description = rss_arts.getChildren("channel/item/description")[page*per_page+index].getContent();
          header = "BBC News, " + rss_arts.getChildren("channel/item/pubDate")[page*per_page+index].getContent();
          break;
        case "sci":
          if (page*per_page+index >= titles_sci.length)
            break;
          description = rss_sci.getChildren("channel/item/description")[page*per_page+index].getContent();
          header = "BBC News, " + rss_sci.getChildren("channel/item/pubDate")[page*per_page+index].getContent();
          break;
        case "tech":
          if (page*per_page+index >= titles_tech.length)
            break;
          description = rss_tech.getChildren("channel/item/description")[page*per_page+index].getContent();
          header = "BBC News, " + rss_tech.getChildren("channel/item/pubDate")[page*per_page+index].getContent();
          break;
        case "pol":
          if (page*per_page+index >= titles_pol.length)
            break;
          description = rss_pol.getChildren("channel/item/description")[page*per_page+index].getContent();
          header = "BBC News, " + rss_pol.getChildren("channel/item/pubDate")[page*per_page+index].getContent();
          break;
      }
    }
  }
  if (mousePressed && debounce <= 0) {
    if (0 < mouseY && mouseY < 50) {
      canOpenLink = false;
      if (0 < mouseX && mouseX < 50) {
        //Left arrow
        page--;
        if (page < 0)
          page = 0;
        header = "BBC News";
        description = "";
        debounce = pageDelay;
      }
      else if (50 < mouseX && mouseX < 190) {
        //World
        selection = "world";
        header = "BBC News";
        description = "";
        page = 0;
        debounce = categoryDelay;
      }
      else if (190 < mouseX && mouseX < 330) {
        //Arts
        selection = "arts";
        header = "BBC News";
        description = "";
        page = 0;
        debounce = categoryDelay;
      }
      else if (330 < mouseX && mouseX < 470) {
        //Science
        selection = "sci";
        header = "BBC News";
        description = "";
        page = 0;
        debounce = categoryDelay;
      }
      else if (470 < mouseX && mouseX < 610) {
        //Tech
        selection = "tech";
        header = "BBC News";
        description = "";
        page = 0;
        debounce = categoryDelay;
      }
      else if (610 < mouseX && mouseX < 750) {
        //Politics
        selection = "pol";
        header = "BBC News";
        description = "";
        page = 0;
        debounce = categoryDelay;
      }
      else if (750 < mouseX && mouseX < 800) {
        //Right arrow
        page++;
        //Undo if at the end of the list
        switch(selection) {
          case "world":
            if (per_page*page >= titles_world.length)
              page--;
            break;
          case "arts":
            if (per_page*page >= titles_arts.length)
              page--;
            break;
          case "sci":
            if (per_page*page >= titles_sci.length)
              page--;
            break;
          case "tech":
            if (per_page*page >= titles_tech.length)
              page--;
            break;
          case "pol":
            if (per_page*page >= titles_pol.length)
              page--;
            break;
        }
        header = "BBC News";
        description = "";
        debounce = pageDelay;
      }
    }
    else if (canOpenLink && debounce <= 0) {
      //Clicking a link
      debounce = linkDelay;
      canOpenLink = false;
      int index = (int)((mouseY - 65)/40);
      String url = "";
      if (index >= 0 && index < per_page) {
        switch(selection) {
          case "world":
            if (page*per_page+index >= titles_world.length)
              break;
            url = rss_world.getChildren("channel/item/link")[page*per_page+index].getContent();
            if (url.length() > 0)
              link(url);
            break;
          case "arts":
            if (page*per_page+index >= titles_arts.length)
              break;
            url = rss_arts.getChildren("channel/item/link")[page*per_page+index].getContent();
            if (url.length() > 0)
              link(url);
            break;
          case "sci":
            if (page*per_page+index >= titles_sci.length)
              break;
            url = rss_sci.getChildren("channel/item/link")[page*per_page+index].getContent();
            if (url.length() > 0)
              link(url);
            break;
          case "tech":
            if (page*per_page+index >= titles_tech.length)
              break;
            url = rss_tech.getChildren("channel/item/link")[page*per_page+index].getContent();
            if (url.length() > 0)
              link(url);
            break;
          case "pol":
            if (page*per_page+index >= titles_pol.length)
              break;
            url = rss_pol.getChildren("channel/item/link")[page*per_page+index].getContent();
            if (url.length() > 0)
              link(url);
            break;
        }
      }
    }
  }
  if (!mousePressed) {
    canOpenLink = true;
  }
}

void draw() {
  update(); //Check mouse stuff
  //Background
  background(0); //Not necessary but just in case
  if (selection.equals("world"))
    background(64, 0, 0);
  else if (selection.equals("arts"))
    background(64, 64, 0);
  else if (selection.equals("sci"))
    background(0, 64, 0);
  else if (selection.equals("tech"))
    background(0, 0, 64);
  else if (selection.equals("pol"))
    background(64, 0, 64);
  //Box colors
  color[] colors = {color(255,0,0), color(255,255,0), color(0,255,0), color(0,0,255), color(255,0,255)};
  for (int i = 0; i < 5; i++) {
    fill(colors[i]);
    rect(50+140*i, 0, 140, 50);
  }
  //Box outlines
  stroke(255);
  line(0, 50, 800, 50);
  for (int i = 0; i <= 5; i++) {
    line(50+140*i, 0, 50+140*i, 50);
  }
  noFill();
  if (selection.equals("world")) {
    rect(51, 1, 138, 48);
    rect(52, 2, 136, 46);
  }
  else if (selection.equals("arts")) {
    rect(191, 1, 138, 48);
    rect(192, 2, 136, 46);
  }
  else if (selection.equals("sci")) {
    rect(331, 1, 138, 48);
    rect(332, 2, 136, 46);
  }
  else if (selection.equals("tech")) {
    rect(471, 1, 138, 48);
    rect(472, 2, 136, 46);
  }
  else if (selection.equals("pol")) {
    rect(611, 1, 138, 48);
    rect(612, 2, 136, 46);
  }
  //Arrows
  fill(128);
  rect(0, 0, 50, 50);
  rect(750, 0, 50, 50);
  fill(0);
  triangle(10, 25, 40, 10, 40, 40);
  triangle(790, 25, 760, 10, 760, 40);
  //Categories
  textFont(category_font);
  fill(0);
  String[] categories = {"World", "Arts", "Science", "Tech", "Politics"};
  for (int i = 0; i < 5; i++) {
    text(categories[i], 120 + 140*i, 20);
  }
  //Titles
  textFont(text_font);
  switch(selection) {
    case "world":
      for (int i = 0; i < per_page; i++) {
        if (page*per_page+i >= titles_world.length)
          break; //You've reached the end of the news.
        fill(255);
        for (String keyword : highlights.keySet()) {
          if (titles_world[page*per_page + i].toLowerCase().contains(keyword)) {
            int b = (highlights.get(keyword)>>16)%256;
            int g = (highlights.get(keyword)>>8)%256;
            int r = (highlights.get(keyword))%256;
            fill(r, g, b);
          }
        }
        text(titles_world[page*per_page + i], 400, 80 + 40*i);
      }
      break;
    case "arts":
      for (int i = 0; i < per_page; i++) {
        if (page*per_page+i >= titles_arts.length)
          break; //You've reached the end of the news.
        fill(255);
        for (String keyword : highlights.keySet()) {
          if (titles_arts[page*per_page + i].toLowerCase().contains(keyword)) {
            int b = (highlights.get(keyword)>>16)%256;
            int g = (highlights.get(keyword)>>8)%256;
            int r = (highlights.get(keyword))%256;
            fill(r, g, b);
          }
        }
        text(titles_arts[page*per_page + i], 400, 80 + 40*i);
      }
      break;
    case "sci":
      for (int i = 0; i < per_page; i++) {
        if (page*per_page+i >= titles_sci.length)
          break; //You've reached the end of the news.
        fill(255);
        for (String keyword : highlights.keySet()) {
          if (titles_sci[page*per_page + i].toLowerCase().contains(keyword)) {
            int b = (highlights.get(keyword)>>16)%256;
            int g = (highlights.get(keyword)>>8)%256;
            int r = (highlights.get(keyword))%256;
            fill(r, g, b);
          }
        }
        text(titles_sci[page*per_page + i], 400, 80 + 40*i);
      }
      break;
    case "tech":
      for (int i = 0; i < per_page; i++) {
        if (page*per_page+i >= titles_tech.length)
          break; //You've reached the end of the news.
        fill(255);
        for (String keyword : highlights.keySet()) {
          if (titles_tech[page*per_page + i].toLowerCase().contains(keyword)) {
            int b = (highlights.get(keyword)>>16)%256;
            int g = (highlights.get(keyword)>>8)%256;
            int r = (highlights.get(keyword))%256;
            fill(r, g, b);
          }
        }
        text(titles_tech[page*per_page + i], 400, 80 + 40*i);
      }
      break;
    case "pol":
      for (int i = 0; i < per_page; i++) {
        if (page*per_page+i >= titles_pol.length)
          break; //You've reached the end of the news.
        fill(255);
        for (String keyword : highlights.keySet()) {
          if (titles_pol[page*per_page + i].toLowerCase().contains(keyword)) {
            int b = (highlights.get(keyword)>>16)%256;
            int g = (highlights.get(keyword)>>8)%256;
            int r = (highlights.get(keyword))%256;
            fill(r, g, b);
          }
        }
        text(titles_pol[page*per_page + i], 400, 80 + 40*i);
      }
      break;
  }
  //Description
  fill(0);
  rect(0, 630, 800, 190);
  stroke(255);
  line(0, 630, 800, 630);
  fill(255);
  String[] desc_words = description.split(" ");
  int[] indices = {-1, -1, -1};
  int count = 0;
  for (int i = 0; i < desc_words.length; i++) {
    count += desc_words[i].length()+1;
    if (indices[0] == -1 && count > 60) {
      indices[0] = i;
    }
    if (indices[1] == -1 && count > 120) {
      indices[1] = i;
    }
    if (indices[2] == -1 && count > 180) {
      indices[2] = i;
    }
  }
  if (indices[0] == -1) {
    indices[0] = desc_words.length;
  }
  else if (indices[1] == -1) {
    indices[1] = desc_words.length;
  }
  else if (indices[2] == -1) {
    indices[2] = desc_words.length;
  }
  String[] desc = {"", "", ""};
  if (indices[0] != -1) {
    for (int i = 0; i < indices[0]; i++) {
      desc[0] += desc_words[i] + " ";
    }
    if (indices[1] != -1) {
      for (int i = indices[0]; i < indices[1]; i++) {
        desc[1] += desc_words[i] + " ";
      }
      if (indices[2] != -1) {
        for (int i = indices[1]; i < indices[2]; i++) {
          desc[2] += desc_words[i] + " ";
        }
        if (indices[2] < desc_words.length) {
          desc[2] += "...";
        }
      }
    }
  }
  for (int i = 0; i < 3; i++) {
    text(desc[i], 400, 650+40*i);
  }
  text("("+header+")", 400, 780);
}