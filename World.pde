class World
{
    public ArrayList<WorldNode> origins = new ArrayList<WorldNode>();

    public Iterable<WorldNode> nodes() { return new Iterable<WorldNode>()
    {
        public Iterator<WorldNode> iterator() { return new Iterator<WorldNode>()
        {
            private Iterator<WorldNode> originIt = origins.iterator();
            private Iterator<WorldNode> loopIt = new EmptyIterator<WorldNode>();
            public boolean hasNext() { return loopIt.hasNext() || originIt.hasNext(); }
            public WorldNode next()
            {
                if (!loopIt.hasNext())
                    loopIt = originIt.next().nodeLoop().iterator();
                return loopIt.next();
            }
            public void remove() { throw new UnsupportedOperationException(); }
        };}
    };}

    WorldNode addOrigin(PVector position)
    {
        WorldNode origin = new WorldNode(position);
        origins.add(origin);
        return origin;
    }

    WorldNode pickNode(PVector p, float radius)
    {
        final float radiusSq = sq(radius);
        for (WorldNode node : nodes())
        {
            if (distSq(node.position, p) <= radiusSq)
            return node;
        }
        return null;
    }
}

class WorldNode
{
    public PVector position;
    public WorldNode pred;
    public WorldNode succ;

    public WorldNode(PVector position)
    {
        this.position = position;
        pred = succ = this;
    }

    public WorldNode(PVector position, WorldNode pred, WorldNode succ)
    {
        this.position = position;
        this.pred = pred;
        this.succ = succ;
    }

    public Iterable<WorldNode> nodeLoop() { return new Iterable<WorldNode>()
    {
        public Iterator<WorldNode> iterator() { return new Iterator<WorldNode>()
        {
            private WorldNode last = pred;
            private WorldNode node = new WorldNode(null, null, WorldNode.this);
            public boolean hasNext() { return node != last; }
            public WorldNode next() { return node = node.succ; }
            public void remove() { throw new UnsupportedOperationException(); }
        };}
    };}

    public WorldNode insertSucc(PVector position)
    {
        WorldNode node = new WorldNode(position, this, succ);
        succ.pred = succ = node;
        return node;
    }
    
    public WorldNode insertPred(PVector position)
    {
        WorldNode node = new WorldNode(position, pred, this);
        pred.succ = pred = node;
        return node;
    }
    
    public WorldNode insertAdaptive(PVector position)
    {
        
        if (distSq(position, pred.position) < distSq(position, succ.position))
            return insertPred(position);
        else
            return insertSucc(position);
    }
}

class Segment
{
    Segment succ;
    Segment pred;
    PVector begin;
    PVector end;
}

public PVector nearestPoint(Segment segment, PVector p)
{
    PVector p0 = segment.begin, p1 = segment.end;
    PVector u0 = span(p, p0), u1 = span(p, p1), v = span(p0, p1);
    float d0 = dot(u0, v), d1 = dot(u1, v);
    if (d0 * d1 >= 0)
        return abs(d0) < abs(d1) ? p0 : p1;
    v.mult(-d0 / lengthSq(v));
    v.add(p0);
    return v;
}