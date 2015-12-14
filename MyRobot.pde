class MyRobot extends Robot {

  final Sensor frontSensor;
  final Sensor backSensor;
  final Sensor rightSensor;
  final Sensor leftSensor;
  boolean obstacleFront = false;
  boolean obstacleLeft  = false;
  boolean obstacleRight = false;

  float random;


  MyRobot(Environment pEnvironment) {
    super(pEnvironment);
    frontSensor = addSensor(0, 60.0f);
    backSensor  = addSensor(PI, 25.0f);
    rightSensor = addSensor(PI/4, 45.0f);
    leftSensor  = addSensor(-PI/4, 45.0f);
  }



  void update(float pDeltaTime) {


    //setzte die Variablen, wo sich Hindernisse befinden:
    if (frontSensor.triggered()) {
      obstacleFront = true;
    } else if (rightSensor.triggered()) {
      obstacleRight = true;
    } else if (leftSensor.triggered()) {
      obstacleLeft  = true;
    }
    if (!frontSensor.triggered()) {
      obstacleFront = false;
    } else if (!rightSensor.triggered()) {
      obstacleRight = false;
    } else if (!leftSensor.triggered()) {
      obstacleLeft  = false;
    }


//Was geschieht, wenn welche Sensoren triggern?


    if (obstacleFront) {
// Fall1: Geradeaus und links befindet sich ein Hindernis
      if (obstacleLeft && !obstacleRight) {
        steer(-PI/2); //bitte nach rechts drehen
        speed(MAX_SPEED_FORWARD);
      } 
// Fall2: Geradeaus und rechts befindet sich ein Hindernis
      else if (obstacleRight && !obstacleLeft) {
        steer(PI/2); //bitte nach links drehen
        speed(MAX_SPEED_FORWARD);
      } 
// Fall3: Geradeaus, links und rechts befindet sich ein Hindernis
      else if (obstacleRight && obstacleLeft) {
        steer(0);
        speed(MAX_SPEED_BACKWARD); //hier fehlt Code
      } 
// Fall4: Ausschließlich geradeaus befindet sich ein Hindernis
      else if (!obstacleRight && !obstacleLeft) {
        random = random(2);
        if (random >= 0) steer(PI/2);
        else steer(-PI/2);
        speed(MAX_SPEED_FORWARD);
      }
    }
// Fall5: Wenn vor dir kein Hindernis liegt
    else {
      steer(0);
      speed(MAX_SPEED_FORWARD);
    }
  }





  void draw(PGraphics g) {
    /* draw in robot s local coordinate space */
    g.rectMode(CENTER);
    g.stroke(0);
    g.fill(0, 127, 255);
    /* draw a line pointing towards the goal */
    float angle = angleToGoal() + PI / 2;
    float distance = distanceToGoal();
    Vec2 mGoalPosition = new Vec2(cos(angle), sin(angle));
    mGoalPosition.mulLocal(5);
    g.stroke(255, 127, 0);
    g.line(0, 0, mGoalPosition.x, mGoalPosition.y);
  }



  void draw_global(PGraphics g) {
    /* draw in the environment s coordinate space */
    g.stroke(64);
    Vec2 target = environment().target().position();
    g.line(target.x, target.y, position().x, position().y);
  }
}

