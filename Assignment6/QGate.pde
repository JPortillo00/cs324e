class QGate {
  int n;
  
  /*
  C c0 = new C();
  C p1 = new C(1);
  C pi = new C(0, 1);
  C m1 = new C(-1);
  C mi = new C(0, -1);
  QGate I = new QGate(1);
  C[][] xdata = {{c0, p1},{p1, c0}};
  QGate X = new QGate(1);
  X.setData(xdata);
  C[][] ydata = {{c0, mi},{pi, c0}};
  QGate Y = new QGate(1);
  Y.setData(ydata);
  C[][] zdata = {{p1, c0},{c0, m1}};
  QGate Z = new QGate(1);
  Z.setData(zdata);
  QGate I2 = new QGate(2);
  */
  
  C[][] data;
  public QGate(int n) {
    this.n = n;
    init();
  }
  
  //As identity matrix
  public void init() {
    data = new C[int(pow(2, n))][int(pow(2, n))];
    for (int i = 0; i < pow(2, n); i++) {
      for (int j = 0; j < pow(2, n); j++) {
        if (i == j) {
          data[i][j] = new C(1);
        }
        else {
          data[i][j] = new C();
        }
      }
    }
  }
  
  public int getQSize() {
    return n;
  }
  
  public C getData(int i, int j) {
    if (i < 0 || j < 0 || i > pow(2, n) || j > pow(2, n)) {
      println("Outside of domain");
      return new C();
    }
    return data[i][j];
  }
  
  public QGate setData(C[][] d) {
    if (d.length == pow(2, n) && d[0].length == pow(2, n)) {
      for (int i = 0; i < pow(2, n); i++) {
        for (int j = 0; j < pow(2, n); j++) {
          data[i][j] = d[i][j];
        }
      }
    }
    else {
      println("Invalid data");
    }
    return this;
  }
  
  public void setData(int i, int j, C v) {
    if (i < 0 || j < 0 || i > pow(2, n) || j > pow(2, n)) {
      println("Outside of domain");
    }
    data[i][j] = v;
  }
  
  public QGate premult(QGate g) {
    if (g.getQSize() != n) {
      println("Cannot multiply these gates");
      return null;
    }
    QGate res = new QGate(n);
    for (int i = 0; i < pow(2, n); i++) {
      for (int j = 0; j < pow(2, n); j++) {
        C val = new C();
        for (int k = 0; k < pow(2, n); k++) {
          val = val.add(g.getData(i, k).mul(getData(k, j)));
        }
        res.setData(i, j, val);
      }
    }
    return res;
  }
  
  public QGate postmult(QGate g) {
    if (g.getQSize() != n) {
      println("Cannot multiply these gates");
      return null;
    }
    QGate res = new QGate(n);
    for (int i = 0; i < pow(2, n); i++) {
      for (int j = 0; j < pow(2, n); j++) {
        C val = new C();
        for (int k = 0; k < pow(2, n); k++) {
          val = val.add(getData(i, k).mul(g.getData(k, j)));
        }
        res.setData(i, j, val);
      }
    }
    return res;
  }
  
  public QGate pretensor(QGate g) {
    int m = g.getQSize();
    QGate res = new QGate(m + n);
    for (int i = 0; i < pow(2, m); i++) {
      for (int j = 0; j < pow(2, m); j++) {
        for (int k = 0; k < pow(2, n); k++) {
          for (int l = 0; l < pow(2, n); l++) {
            res.setData(i*int(pow(2, n))+k, j*int(pow(2, n))+l, g.getData(i, j).mul(getData(k, l)));
          }
        }
      }
    }
    return res;
  }
  
  public QGate posttensor(QGate g) {
    int m = g.getQSize();
    QGate res = new QGate(m + n);
    for (int i = 0; i < pow(2, n); i++) {
      for (int j = 0; j < pow(2, n); j++) {
        for (int k = 0; k < pow(2, m); k++) {
          for (int l = 0; l < pow(2, m); l++) {
            res.setData(i*int(pow(2, m))+k, j*int(pow(2, m))+l, getData(i, j).mul(g.getData(k, l)));
          }
        }
      }
    }
    return res;
  }
  
  public String toString() {
    String res = "[\n";
    for (int i = 0; i < pow(2, n); i++) {
      res += "[";
      for (int j = 0; j < pow(2, n); j++) {
        res += getData(i, j).toString();
        if (j != int(pow(2, n)-1))
          res += ", ";
      }
      res += "]";
      if (i != int(pow(2, n)-1))
        res += ", \n";
    }
    res += "\n]";
    return res;
  }
  
  public void render() {
    int px = 100;
    int py = 100;
    int cx = max(int(600/pow(2, n)), 1);
    int cy = max(int(600/pow(2, n)), 1);
    
    for (int i = 0; i < pow(2, n); i++) {
      for (int j = 0; j < pow(2, n); j++) {
        colorMode(HSB);
        fill((256+128/PI*getData(i, j).arg())%256, 255, 255*getData(i, j).norm());
        rect(px+j*cx, py+i*cy, cx, cy);
      }
    }
  }
}