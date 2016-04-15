class Guy
{   
    PVector position = new PVector();
    PVector velocity = new PVector();
    float radius = 20;
    float angleOfAdhesion = 0.25f * PI;
    boolean supported;
    boolean ascending;
    ArrayList<Contacts> contacts = new ArrayList<PVector>();
    float maxGripAngle = 0.15f * PI;
    float minGripAngle = -maxGripAngle;
    float maxClimbAngle = 0.39f * PI;
    
    float getClimbCoeff(float angle)
    {
        if (angle > 0.5f * PI)
            angle = PI - angle;
        if (angle <= maxGripAngle)
            return 1;
        if (angle >= maxClimbAngle)
            return 0;
        float t = (angle - maxGripAngle) / (maxClimbAngle - maxGripAngle);
        return 1 - t * t;
    }
    
    float getSlideCoeff(float angle)
    {
         if (angle < -0.5f * PI)
             angle = -PI - angle;
         if (angle >= minGripAngle)
             return 0;
         float t = (minGripAngle - angle) / (minGripAngle - 0.5f * PI);
         return t * t;
    }
    
    boolean touches(Segment segment)
    {
        for (Contact contact : contacts)
        {
            if (segment == contact.segment)
                return true;
        }
        return false;
    }
}

class Contact
{
    float angle;
    Segment segment;
    
    public Contact(float angle, Segment segment)
    {
        this.angle = angle;
        this.segment = segment;
    }
}