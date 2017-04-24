QState[] states;
QGate gate;
Qswitch Swtch;
int t;

C[] s00 = {new C(1), new C(), new C(), new C()};
C[] s01 = {new C(), new C(1), new C(), new C()};
C[] s10 = {new C(), new C(), new C(1), new C()};
C[] s11 = {new C(), new C(), new C(), new C(1)};

void setup() {
  size(800, 800);
  Swtch = new Qswitch(height,width,mouseX,mouseY);
  t = 0;
  states = new QState[6];
  for (int i = 0; i < states.length; i++) {
    //states[i] = new QState(1);
    states[i] = new QState(2);
  }
  //gate = new QGate(1);
  gate = new QGate(2);
}

void mousePressed(){
  Swtch.update(mouseX,mouseY);
  Swtch.updateColor();

}

void draw() {
  t++;
  if (Swtch.sq1 == 0 && Swtch.sq2 == 0)
    states[0].setState(s00);
  if (Swtch.sq1 == 0 && Swtch.sq2 == 255)
    states[0].setState(s01);
  if (Swtch.sq1 == 255 && Swtch.sq2 == 0)
    states[0].setState(s10);
  if (Swtch.sq1 == 255 && Swtch.sq2 == 255)
    states[0].setState(s11);
  background(50);
  Swtch.display();
  C c0 = new C();
  C p1 = new C(1);
  C pi = new C(0, 1);
  C m1 = new C(-1);
  C mi = new C(0, -1);
  C ph = new C(1/sqrt(2));
  C mh = new C(-1/sqrt(2));
  
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
  C[][] hdata = {{ph, ph},{ph, mh}};
  QGate H = new QGate(1);
  H.setData(hdata);
  
  QGate II = new QGate(2);
  QGate XI = I.pretensor(X);
  QGate IX = X.pretensor(I);
  QGate XX = X.pretensor(X);
  QGate YI = I.pretensor(Y);
  QGate IY = Y.pretensor(I);
  QGate YY = Y.pretensor(Y);
  QGate ZI = I.pretensor(Z);
  QGate IZ = Z.pretensor(I);
  QGate ZZ = Z.pretensor(Z);
  QGate HI = I.pretensor(H);
  QGate IH = H.pretensor(I);
  QGate HH = H.pretensor(H);
  
  QGate XY = Y.pretensor(X);
  QGate YX = X.pretensor(Y);
  QGate XZ = Z.pretensor(X);
  QGate ZX = X.pretensor(Z);
  QGate YZ = Z.pretensor(Y);
  QGate ZY = Y.pretensor(Z);
  QGate XH = H.pretensor(X);
  QGate HX = X.pretensor(H);
  QGate YH = H.pretensor(Y);
  QGate HY = Y.pretensor(H);
  QGate ZH = H.pretensor(Z);
  QGate HZ = Z.pretensor(H);
  
  C[][] cnotdata = {{p1,c0,c0,c0},{c0,p1,c0,c0},{c0,c0,c0,p1},{c0,c0,p1,c0}};
  QGate CNOT = new QGate(2);
  CNOT.setData(cnotdata);
  
  C[][] toncdata = {{p1,c0,c0,c0},{c0,c0,c0,p1},{c0,c0,p1,c0},{c0,p1,c0,c0}};
  QGate TONC = new QGate(2);
  TONC.setData(toncdata);
  
  C[][] cp2data = {{p1,c0,c0,c0},{c0,p1,c0,c0},{c0,c0,p1,c0},{c0,c0,c0,pi}};
  QGate CP2 = new QGate(2);
  CP2.setData(cp2data);
  
  //1 qubit demo: Phase reversal via superposition states
  /*
  states[1] = states[0].act(X);
  states[2] = states[1].act(H);
  states[3] = states[2].act(X);
  states[4] = states[3].act(H);
  states[5] = states[4].act(X);
  */
  
  //2 qubit demo: QFT on 2 qubits
  
  states[1] = states[0].act(IH);
  states[2] = states[1].act(CNOT);
  states[3] = states[2].act(YZ);
  states[4] = states[3].act(CNOT);
  states[5] = states[4].act(HI);
  
  for (int i = 0; i < states.length; i++) {
    states[i].render(i);
  }
  
  //1 qubit
  /*
  if (t % 20 == 0) {
    QGate[] gates = {I, X, Y, Z, H};
    int r = int(random(1)*gates.length);
    gate = gate.premult(gates[r]);
  }
  gate.render();
  */
  
  //2 qubits
  /*
  if (t % 20 == 0) {
    QGate[] gates = {II, IX, XI, XX, IY, YI, YY, IZ, ZI, ZZ, IH, HI, HH, XY, YX, XZ, ZX, YZ, ZY, HX, XH, HY, YH, HZ, ZH, CNOT, TONC};
    int r = int(random(1)*gates.length);
    gate = gate.premult(gates[r]);
  }
  gate.render();
  */
  
  //2 qubit Quantum Fourier Transform
  //gate.premult(HI).premult(CP2).premult(IH).premult(CNOT).premult(IZ).premult(TONC).premult(IZ).premult(CNOT).render();

  
}