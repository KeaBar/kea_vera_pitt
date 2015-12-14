import de.hfkbremen.robots.challenge.*;
import org.jbox2d.common.*;

Environment mEnvironment;
MyRobot mRobot;
final float mScale = 0.8f;
void settings() {
    
}
void setup() {

    size(1024, 768);
    mEnvironment = new Environment(this, Environment.MAP_RACE_TEST);
    mRobot = new MyRobot(mEnvironment);
    mRobot.position(-380, -320);
    mRobot.rotation(PI * -0.9f);
    mEnvironment.add(mRobot);
}
void draw() {
    background(255);
    mEnvironment.update();
    mEnvironment.draw(g, mScale, mRobot.position());
}

void keyPressed() {
    mEnvironment.setNewRandomTarget();
}
