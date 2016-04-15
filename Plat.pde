ArrayList<Segment> segments = new ArrayList<Segment>();
Segment activeSegment;
Guy guy = new Guy();
int prevMillis;
PVector g = new PVector(0, 700);
boolean rightPressed;
boolean leftPressed;
boolean upPressed;
boolean ascending;
ArrayList<PVector> contacts = new ArrayList<PVector>();
PVector groundContact;

void setup()
{
    size(1024, 780);
    prevMillis = millis();
}

void line(PVector p0, PVector p1) { line(p0.x, p0.y, p1.x, p1.y); }


void draw()
{
    int currentMillis = millis();
    float dt = (currentMillis - prevMillis) * 0.001f;
    prevMillis = currentMillis;
    
    
    
    if (!guy.supported)
    {
        PVector accel = g.copy();
        if (leftPressed)
            accel.x -= 1500;
        if (rightPressed)
            accel.x += 1500;
        guy.velocity.add(mul(dt, accel));
        if (accel.x == 0)
            guy.velocity.x *= pow(0.02, dt);
        guy.velocity.x = clamp(-300, 300, guy.velocity.x);
        guy.position.add(mul(dt, guy.velocity));
    }
    else if (upPressed)
    {
        
    }
    else if ((leftPressed || rightPressed) && !(leftPressed && rightPressed))
    {
        boolean blocked = false;
        float restricted0 = rightPressed ? 0 : 0.5f * PI;
        float restricted1 = rightPressed ? 0.5f * PI : PI;
        for (Contact contact : guy.contacts)
        {
            if (restricted0 <= contact.angle && contact.angle <= restricted1)
            {
                blocked = true;
                break;
            }
        }
        
        if (!blocked)
        {
            float target = rightPressed ? 0 : -PI;
            float minOffset = Float.POSITIVE_INFINITY;
            float supportAngle;
            for (Contact contact : guy.contacts)
            {
                float offset = abs(contact.angle - target);
                if (offset < minOffset)
                {
                    minOffset = offset;
                    supportAngle = contact.angle;
                }
            }
            if (minOffset < 0.5f * PI) // 
            {
                
            }
            else
            {
                
            }
            
        }
    }
    
    PVector accel = g.copy();
    if (leftPressed)
        accel.add(-1500, 0);
    if (rightPressed)
        accel.add(1500, 0);
    if (upPressed)
    {
        if (groundConctact != null)
        {
            guy.velocity.y = -300;
            ascending = true;
            groundContact = null;
            contact = null;
        }
        if (ascending)
            accel.y *= 0.8;
    }
    else
    {
        ascending = false;
    }
    guy.velocity.add(mul(dt, accel));
    if (accel.x == 0)
        guy.velocity.x *= pow(0.02, dt);
    guy.velocity.x = clamp(-300, 300, guy.velocity.x);
    guy.position.add(mul(dt, guy.velocity));
    
    background(200);
    stroke(0);
    for (Segment seg : segments)
        line(seg.p0, seg.p1);
    
    contacts.clear();
    for (Segment seg : segments)
    {
        PVector contact = span(guy.position, nearestPoint(seg, guy.position))
        if (lengthSq(contact) < Guy.radiusSq)
            contacts.add(contact);
        //PVector offset = span(nearest, guy.position);
        //float distSq = lengthSq(offset);
        //if (distSq >= Guy.radiusSq)
        //    continue;
        //PVector contact = offset.copy();
        //contacts.add(contact);
        //if (offset.y < 0)
        //    jumpAllowed = true;
        //ascending = false;
        //float dist = sqrt(distSq);
        //offset.div(dist);
        //clearDirection(guy.velocity, offset);
        //offset.mult(Guy.radius - dist);
        //guy.position.add(offset);
    }
    
    if (groundContact == null)
    {
        float minAngleOffset = Float.INFINITY;
        for (PVector contact : contacts)
        {
            float angleOffset = abs(angle(contact) + 0.5f * PI);
            if (angleOffset < minAngleOffset)
            {
                minAngleOffset = angleOffset;
                groundContact = contact;
            }
        }
    }
        
    if (groundContact != null)
    {
    }
        
    stroke(50, 0, 0);
    noFill();
    ellipseMode(RADIUS);
    ellipse(guy.position.x, guy.position.y, Guy.radius, Guy.radius);
    
    stroke(255, 255, 0);
    for (PVector contact : contacts)
        line(guy.position, sub(guy.position, contact));
}

PVector guyVsSegment(Guy guy, Segment segment)
{
    PVector u = span(segment.p0, segment.p1).normalize();
    PVector v1 = span(guy.position, segment.p0);
    PVector v2 = span(guy.position, segment.p1);
    
    float d1 = dot(u, v1);
    float d2 = dot(u, v2);
    if (d1 * d2 > 0 && v1.magSq() > Guy.radiusSq && v2.magSq() > Guy.radiusSq)
        return null;
        
    PVector r = span(sub(segment.p0, mul(d1, u)), guy.position);
    float rLengthSq = lengthSq(r);
    if (rLengthSq > Guy.radiusSq)
        return null;
    float rLength = sqrt(rLengthSq);
    r.mult((Guy.radius - rLength) / rLength);
    return r;
}

void mousePressed()
{
    if (mouseButton == LEFT)
    {
        activeSegment = new Segment();
        activeSegment.p0 = new PVector(mouseX, mouseY);
        activeSegment.p1 = new PVector(mouseX, mouseY);
        segments.add(activeSegment);
    }
    else if (mouseButton == RIGHT)
    {
        guy.position.set(mouseX, mouseY);
        guy.velocity.set(0, 0);
    }
}

void mouseDragged()
{
    if (mouseButton == LEFT)
        activeSegment.p1.set(mouseX, mouseY);
}

void mouseReleased()
{
    if (mouseButton == LEFT)
        activeSegment = null;
}

void mouseMoved()
{
    //guy.position.set(mouseX, mouseY);
}

void keyPressed()
{
    switch (keyCode)
    {
        case LEFT: leftPressed = true; break;
        case RIGHT: rightPressed = true; break;
        case UP: upPressed = true; break;
    }
}

void keyReleased()
{
    switch (keyCode)
    {
        case LEFT: leftPressed = false; break;
        case RIGHT: rightPressed = false; break;
        case UP: upPressed = false; break;
    }
}