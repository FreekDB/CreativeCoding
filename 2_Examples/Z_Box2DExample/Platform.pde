import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


// A static rectangular platform that lives in Box2d.
class Platform {
  // Reference to the Box2D Body object.
  Body body;

  float platformWidthProcessing;
  float platformHeightProcessing;

  Platform(float x, float y, float platformWidth, float platformHeight, float angle) {
    platformWidthProcessing = platformWidth;
    platformHeightProcessing = platformHeight;

    // Construct the body (using a body definition).
    BodyDef bodyDefinition = new BodyDef();
    bodyDefinition.type = BodyType.STATIC;
    bodyDefinition.position.set(box2d.coordPixelsToWorld(x, y));
    // bodyDefinition.angle = box2d.scalarPixelsToWorld(angle);
    bodyDefinition.angle = angle;
    body = box2d.createBody(bodyDefinition);

    // Remember: Box2D considers the width and height of a rectangle to be the distance from the
    // center to the edge (so half of what we normally think of as width and height.)
    float box2dWidth = box2d.scalarPixelsToWorld(platformWidth / 2);
    float box2dHeight = box2d.scalarPixelsToWorld(platformHeight / 2);

    // Construct the polygon shape (this is what we use for a rectangle).
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(box2dWidth, box2dHeight);

    // Construct the fixture definition.
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    // Parameters that affect the physical characteristics.
    fixtureDef.density = 1;
    fixtureDef.friction = 0.3;
    fixtureDef.restitution = 0.5;

    // Attach the fixture to the body.
    body.createFixture(fixtureDef);
  }

  void display() {
    // We need the body’s location and angle.
    Vec2 position = box2d.getBodyPixelCoord(body);
    float angle = body.getAngle();

    // Save the current translation and rotation.
    pushMatrix();

    // Using the Vec2 position and float angle to translate and rotate the rectangle.
    translate(position.x, position.y);
    rotate(-angle);  // Using the negative angle because the y axis is different in Processing.

    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, platformWidthProcessing, platformHeightProcessing);

    // Restore the previous translation and rotation.
    popMatrix();
  }
}
// Platform
