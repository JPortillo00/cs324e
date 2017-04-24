class C {
	float re, im;
	public C() {
		re = 0;
		im = 0;
	}
	
	public C(float r) {
		re = r;
		im = 0;
	}
	
	public C(float r, float i) {
		re = r;
		im = i;
	}
	
	public float norm() {
		return sqrt(re*re + im*im);
	}
	
	public float norm2() {
		return re*re + im*im;
	}
	
	public float arg() {
		return atan2(im, re);
	}
	
	public C add(C o) {
		return new C(re + o.re, im + o.im);
	}
	
	public C sub(C o) {
		return new C(re - o.re, im - o.im);
	}
	
	public C mul(C o) {
		return new C(re*o.re - im*o.im, re*o.im + im*o.re);
	}

  //Oh wait, this isn't useful because there is no static keyword in processing...
  public C expi(float t) {
    return new C(cos(t), sin(t));
  }

  public String toString() {
    String res = "";
    if (re != 0) {
      res += str(re);
      if (im > 0) {
        res += " + ";
        res += str(im);
        res += "i";
      }
      else if (im < 0) {
        res += " - ";
        res += str(-im);
        res += "i";
      }
    }
    else {
      res += str(im);
      res += "i";
    }
    return res;
  }
}