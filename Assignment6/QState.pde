class QState {
  int n;
  C[] data;
  public QState(int n) {
    this.n = n;
    init();
  }
  
  public void init() {
    data = new C[int(pow(2, n))];
    data[0] = new C(1);
    for (int i = 1; i < pow(2, n); i++) {
      data[i] = new C();
    }
  }
  
  public void setState(C[] data) {
    if (data.length != pow(2, n)) {
      println("Data is wrong length");
      return;
    }
    float norm = 0;
    for (int i = 0; i < data.length; i++) {
      norm += data[i].norm2();
    }
    if (norm == 0) {
      println("Norm is zero");
      return;
    }
    for (int i = 0; i < data.length; i++) {
      setData(i, data[i]);
    }
  }
  
  public int getQSize() {
    return n;
  }
  public C getData(int i) {
    if (i < 0 || i > pow(2, n)) {
      println("Outside of domain");
      return new C();
    }
    return data[i];
  }
  
  public void setData(int i, C v) {
    if (i < 0 || i > pow(2, n)) {
      println("Outside of domain");
    }
    data[i] = v;
  }
  
  public float norm2() {
    float norm = 0;
    for (int i = 0; i < pow(2, n); i++) {
      norm += getData(i).norm2();
    }
    return norm;
  }
  
  public float normOf(QState s) {
    float norm = 0;
    for (int i = 0; i < pow(2, s.getQSize()); i++) {
      norm += s.getData(i).norm2();
    }
    return sqrt(norm);
  }
  
  public QState normalizeState() {
    QState s2 = new QState(n);
    float norm2 = norm2();
    if (norm2 == 0) {
      println("Input state is norm zero");
      return s2;
    }
    for (int i = 0; i < pow(2, n); i++) {
      s2.setData(i, getData(i).mul(new C(1/sqrt(norm2))));
    }
    return s2;
  }
  
  public QState act(QGate g) {
    if (g.getQSize() != n) {
      println("Cannot act by this gate");
    }
    QState res = new QState(n);
    for (int i = 0; i < pow(2, n); i++) {
      C val = new C();
      for (int k = 0; k < pow(2, n); k++) {
        val = val.add(g.getData(i, k).mul(getData(k)));
      }
      res.setData(i, val);
    }
    return res;
  }
  
  public String toString() {
    String res = "[";
    for (int i = 0; i < pow(2, n); i++) {
      res += getData(i).toString();
      if (i != int(pow(2, n)-1))
        res += ", ";
    }
    res += "]";
    return res;
  }
  
  public void render(int t) {
    int px = 100;
    int py = 100;
    int cx = 100; //temp
    int cy = max(int(600/pow(2, n)), 1);
    
    for (int i = 0; i < pow(2, n); i++) {
      colorMode(HSB);
      fill((256+128/PI*getData(i).arg())%256, 255, 255*getData(i).norm());
      rect(px+t*cx, py+i*cy, cx, cy);
    }
  }
}