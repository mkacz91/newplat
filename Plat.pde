import java.util.*;

final float NODE_RADIUS = 10;
final float HOVER_NODE_RADIUS = 11;
final float ACTIVE_NODE_RADIUS = 12;
final int SELECT_BUTTON = LEFT;

Mode mode = Mode.NONE;
Guy guy = new Guy();
World world = new World();
float dt;
WorldNode activeNode;
WorldNode hoverNode;

PVector g = new PVector(0, 700);

void setup()
{
    size(800, 600);
    prevMillis = millis();
    setMode(Mode.EDIT_WORLD);
}

int prevMillis;
boolean firstDraw = true;
void draw()
{   
    int currentMillis = millis();
    dt = (currentMillis - prevMillis) * 0.001f;
    prevMillis = currentMillis;

    background(252, 216, 210);

    // Draw world

    noStroke();
    fill(229, 117, 99);
    for (WorldNode origin : world.origins)
    {
        beginShape();
        for (WorldNode node : origin.nodeLoop())
            vertex(node.position);
        endShape(CLOSE);
    }

    strokeWeight(1);
    stroke(87, 34, 77);
    if (mode == Mode.EDIT_WORLD)
    {
        ellipseMode(RADIUS);
        for (WorldNode node : world.nodes())
        {
            if (node == activeNode)
            {
                fill(168, 86, 72);
                ellipse(node.position, ACTIVE_NODE_RADIUS);
            }
            else if (node == hoverNode)
            {
                fill(255);
                ellipse(node.position, HOVER_NODE_RADIUS);
            }
            else
            {
                noFill();
                ellipse(node.position, NODE_RADIUS);
            }
        }
    }

    //if (!guy.supported)
    //{
    //    PVector accel = g.copy();
    //    if (leftPressed)
    //        accel.x -= 1500;
    //    if (rightPressed)
    //        accel.x += 1500;
    //    guy.velocity.add(mul(dt, accel));
    //    if (accel.x == 0)
    //        guy.velocity.x *= pow(0.02, dt);
    //    guy.velocity.x = clamp(-300, 300, guy.velocity.x);
    //    guy.position.add(mul(dt, guy.velocity));
    //}
    //else if (upPressed)
    //{

    //}
    //else if ((leftPressed || rightPressed) && !(leftPressed && rightPressed))
    //{
    //    boolean blocked = false;
    //    float restricted0 = rightPressed ? 0 : 0.5f * PI;
    //    float restricted1 = rightPressed ? 0.5f * PI : PI;
    //    for (Contact contact : guy.contacts)
    //    {
    //        if (restricted0 <= contact.angle && contact.angle <= restricted1)
    //        {
    //            blocked = true;
    //            break;
    //        }
    //    }

    //    if (!blocked)
    //    {
    //        float target = rightPressed ? 0 : -PI;
    //        float minOffset = Float.POSITIVE_INFINITY;
    //        float supportAngle;
    //        for (Contact contact : guy.contacts)
    //        {
    //            float offset = abs(contact.angle - target);
    //            if (offset < minOffset)
    //            {
    //                minOffset = offset;
    //                supportAngle = contact.angle;
    //            }
    //        }
    //        if (minOffset < 0.5f * PI) //
    //        {

    //        }
    //        else
    //        {

    //        }

    //    }
    //}

    //PVector accel = g.copy();
    //if (leftPressed)
    //    accel.add(-1500, 0);
    //if (rightPressed)
    //    accel.add(1500, 0);
    //if (upPressed)
    //{
    //    if (groundConctact != null)
    //    {
    //        guy.velocity.y = -300;
    //        ascending = true;
    //        groundContact = null;
    //        contact = null;
    //    }
    //    if (ascending)
    //        accel.y *= 0.8;
    //}
    //else
    //{
    //    ascending = false;
    //}
    //guy.velocity.add(mul(dt, accel));
    //if (accel.x == 0)
    //    guy.velocity.x *= pow(0.02, dt);
    //guy.velocity.x = clamp(-300, 300, guy.velocity.x);
    //guy.position.add(mul(dt, guy.velocity));

    //background(200);
    //stroke(0);
    //for (Segment seg : segments)
    //    line(seg.p0, seg.p1);

    //contacts.clear();
    //for (Segment seg : segments)
    //{
    //    PVector contact = span(guy.position, nearestPoint(seg, guy.position))
    //    if (lengthSq(contact) < Guy.radiusSq)
    //        contacts.add(contact);
    //    //PVector offset = span(nearest, guy.position);
    //    //float distSq = lengthSq(offset);
    //    //if (distSq >= Guy.radiusSq)
    //    //    continue;
    //    //PVector contact = offset.copy();
    //    //contacts.add(contact);
    //    //if (offset.y < 0)
    //    //    jumpAllowed = true;
    //    //ascending = false;
    //    //float dist = sqrt(distSq);
    //    //offset.div(dist);
    //    //clearDirection(guy.velocity, offset);
    //    //offset.mult(Guy.radius - dist);
    //    //guy.position.add(offset);
    //}

    //if (groundContact == null)
    //{
    //    float minAngleOffset = Float.INFINITY;
    //    for (PVector contact : contacts)
    //    {
    //        float angleOffset = abs(angle(contact) + 0.5f * PI);
    //        if (angleOffset < minAngleOffset)
    //        {
    //            minAngleOffset = angleOffset;
    //            groundContact = contact;
    //        }
    //    }
    //}

    //if (groundContact != null)
    //{
    //}

    //stroke(50, 0, 0);
    //noFill();
    //ellipseMode(RADIUS);
    //ellipse(guy.position.x, guy.position.y, Guy.radius, Guy.radius);

    //stroke(255, 255, 0);
    //for (PVector contact : contacts)
    //    line(guy.position, sub(guy.position, contact));
}

enum Mode
{
    NONE,
    EDIT_WORLD,
    PLAY
}

void setMode(Mode newMode)
{ //<>//
    if (mode == newMode)
        return;
    switch (mode)
    {
        case NONE:
            break;
        case EDIT_WORLD:
            activeNode = null;
            break;
        case PLAY:
            break;
    }
    switch (newMode)
    {
        case NONE:
            break;
        case EDIT_WORLD:
            break;
        case PLAY:
            break;
    }
    mode = newMode;
}

//PVector guyVsSegment(Guy guy, Segment segment)
//{
//    PVector u = span(segment.p0, segment.p1).normalize();
//    PVector v1 = span(guy.position, segment.p0);
//    PVector v2 = span(guy.position, segment.p1);

//    float d1 = dot(u, v1);
//    float d2 = dot(u, v2);
//    if (d1 * d2 > 0 && v1.magSq() > Guy.radiusSq && v2.magSq() > Guy.radiusSq)
//        return null;

//    PVector r = span(sub(segment.p0, mul(d1, u)), guy.position);
//    float rLengthSq = lengthSq(r);
//    if (rLengthSq > Guy.radiusSq)
//        return null;
//    float rLength = sqrt(rLengthSq);
//    r.mult((Guy.radius - rLength) / rLength);
//    return r;
//}

void mousePressed()
{
    if (mode == Mode.EDIT_WORLD && mouseButton == SELECT_BUTTON)
    {
        PVector m = vec(mouseX, mouseY);
        WorldNode node = world.pickNode(m, NODE_RADIUS);
        if (node == null)
        {
            if (activeNode == null)
                activeNode = world.addOrigin(m);
            else
                activeNode = activeNode.insertAdaptive(m);
        }
        else
        {
            activeNode = node;
        }
    }
}

void mouseDragged()
{
    if (mode == Mode.EDIT_WORLD && mouseButton == SELECT_BUTTON)
    {
        if (activeNode != null)
            activeNode.position.set(mouseX, mouseY);
    }
}

void mouseReleased()
{

}

void mouseMoved()
{
    if (mode == Mode.EDIT_WORLD)
        hoverNode = world.pickNode(vec(mouseX, mouseY), NODE_RADIUS);
}

boolean rightPressed;
boolean leftPressed;
boolean upPressed;

void keyPressed()
{
    switch (keyCode)
    {
        case LEFT: leftPressed = true; break;
        case RIGHT: rightPressed = true; break;
        case UP: upPressed = true; break;
        case '1': setMode(Mode.PLAY); break;
        case '2': setMode(Mode.EDIT_WORLD); break;
        case 'D':
            println("BREAK"); //<>//
            break;
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