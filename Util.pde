PVector vec(float x, float y)
{
    return new PVector(x, y);
}

PVector add(PVector u, PVector v)
{
    return new PVector(u.x + v.x, u.y + v.y);
}

PVector sub(PVector u, PVector v)
{
    return new PVector(u.x - v.x, u.y - v.y);
}

PVector mul(float s, PVector u)
{
    return new PVector(s * u.x, s * u.y);
}

PVector mul(PVector u, float s)
{
    return mul(s, u);
}

float dot(PVector u, PVector v)
{
    return u.x * v.x + u.y * v.y;
}

float per(PVector u, PVector v)
{
    return u.x * v.y - u.y * v.x;
}

PVector span(PVector u, PVector v)
{
    return new PVector(v.x - u.x, v.y - u.y);
}

PVector mid(PVector u, PVector v)
{
    return new PVector(0.5f * (u.x + v.x), 0.5f * (u.y + v.y));
}

PVector rhperp(PVector u)
{
    
}

void clearDirection(PVector u, PVector direction)
{
    u.sub(mul(dot(u, direction), direction));
}

float lengthSq(PVector u)
{
    return u.x * u.x + u.y * u.y;
}

float distSq(PVector u, PVector v)
{
    float dx = v.x - u.x, dy = v.y - u.y;
    return dx * dx + dy * dy;
}

float clamp(float minVal, float maxVal, float x)
{
    if (x <= minVal)
        return minVal;
    if (x >= maxVal)
        return maxVal;
    return x;
}

float angle(PVector u)
{
    return atan2(u.y, u.x);
}

void line(PVector p0, PVector p1) { line(p0.x, p0.y, p1.x, p1.y); }

void ellipse(PVector p, float r) { ellipse(p.x, p.y, r, r); }

void vertex(PVector p) { vertex(p.x, p.y); }

class EmptyIterator<T> implements Iterator<T>
{
    public boolean hasNext() { return false; }
    public T next() { throw new NoSuchElementException(); }
    public void remove() { throw new UnsupportedOperationException(); }
}