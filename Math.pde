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
    float dx = v.x = u.x, dy = v.y - u.y;
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