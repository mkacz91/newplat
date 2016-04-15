class Segment
{
    PVector p0;
    PVector p1;
}

public PVector nearestPoint(Segment s, PVector p)
{
    PVector u0 = span(p, s.p0);
    PVector u1 = span(p, s.p1);
    PVector v = span(s.p0, s.p1);
    float d0 = dot(u0, v);
    float d1 = dot(u1, v);
    if (d0 * d1 >= 0)
        return abs(d0) < abs(d1) ? s.p0 : s.p1;
    v.mult(-d0 / lengthSq(v));
    v.add(s.p0);
    return v;
}