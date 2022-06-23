//The healthbar
class HealthBar extends Actor
{
  private float _maxHealth = 100f;
  private float _currentHealth = 100f;
  private float _displayHealth = 100f;
  private float _updateSpeed = 5f;
  private PGraphics _colouredBarGrey;
  private PGraphics _colouredBarGreen;
  private PGraphics _colouredBarYellow;
  private PGraphics _colouredBarRed;

  //Constructors
  public HealthBar(float x, float y, int w, int h)
  {
    super(x, y, w, h);
    createColouredBars();
  }
  public HealthBar(float x, float y, int w, int h, float maxHealth)
  {
    super(x, y, w, h);
    _maxHealth = maxHealth;
    _currentHealth = _maxHealth;
    _displayHealth = _currentHealth;
    createColouredBars();
  }
  private void createColouredBars()
  {
    //healthbar colours
    _colouredBarGrey = createColouredBar(color(246, 241, 220));
    _colouredBarGreen = createColouredBar(color(155, 118, 214));
    _colouredBarYellow = createColouredBar(color(63, 149, 230));
    _colouredBarRed = createColouredBar(color(170, 182, 240));
  }
  private PGraphics createColouredBar(int colour)
  {
    float radius = getHeight() / 2f;
    PGraphics ret = createGraphics(getWidth(), getHeight());
    ret.beginDraw();
    ret.noStroke();
    ret.fill(colour);
    ret.ellipse(radius, radius, getHeight(), getHeight());
    ret.ellipse(getWidth() - radius, radius, getHeight(), getHeight());
    ret.rect(radius, 0f, getWidth() - getHeight(), getHeight());
    ret.endDraw();
    return ret;
  }

  //Getters
  public float getMax()
  {
    return _maxHealth;
  }
  public float getSpeed()
  {
    return _updateSpeed;
  }
  public float getTarget()
  {
    return _currentHealth;
  }
  public float getValue()
  {
    return _displayHealth;
  }

  //Setters
  public void setMax(float maxHealth)
  {
    _maxHealth = maxHealth;
    _currentHealth = _maxHealth;
  }
  public void setTarget(float target)
  {
    _currentHealth = target;
  }
  public void setValue(float value)
  {
    value = max(0f, value);
    _currentHealth = value;
    _displayHealth = _currentHealth;
  }
  public void setSpeed(float speed)
  {
    _updateSpeed = speed;
  }

  public void add(float health)
  {
    _currentHealth = max(0f, min(_maxHealth, _currentHealth + health));
  }

  //Library Methods
  public void act(float deltaTime)
  {
    if (_displayHealth != _currentHealth)
      _displayHealth = max(0f, min(_maxHealth, _displayHealth + (_maxHealth / (1000f / _updateSpeed)) * (_displayHealth > _currentHealth ? -1f : 1f)));
  }
  public void draw()
  {
    image(_colouredBarGrey, -getWidth() / 2f, -getHeight() / 2f);
    PImage drawBar = (_displayHealth <= _maxHealth / 4f ? _colouredBarRed : (_displayHealth <= _maxHealth / 2f ? _colouredBarYellow : _colouredBarGreen)).get(0, 0, ceil((_displayHealth / _maxHealth) * getWidth()), getHeight());
    image(drawBar, -getWidth() / 2f, -getHeight() / 2f);
    textAlign(CENTER, CENTER);
    textSize(16f);
    text("" + ceil(_displayHealth) + "/" + ceil(_maxHealth), 0f, -3f);
  }
}
