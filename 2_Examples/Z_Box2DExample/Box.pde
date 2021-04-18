import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


// A rectangular box that lives in Box2d.
class Box {
  // Reference to the Box2D Body object.
  Body body;

  boolean highDensity = random(2) >= 1;
  float boxWidth = 24;
  float boxHeight = 16;

  // Green: https://www.vvtp.tudelft.nl
  // Blue:  https://www.tudelft.nl/huisstijl/kleuren
  color fillColor = highDensity ? color(0, 102, 51) : color(0, 166, 214);

  Box(float x, float y) {
    // Construct the body (using a body definition).
    BodyDef bodyDefinition = new BodyDef();
    bodyDefinition.type = BodyType.DYNAMIC;
    bodyDefinition.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bodyDefinition);

    // Remember: Box2D considers the width and height of a rectangle to be the distance from the
    // center to the edge (so half of what we normally think of as width and height.)
    float box2dWidth = box2d.scalarPixelsToWorld(boxWidth / 2);
    float box2dHeight = box2d.scalarPixelsToWorld(boxHeight / 2);

    // Construct the polygon shape (this is what we use for a rectangle).
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(box2dWidth, box2dHeight);

    // Construct the fixture definition.
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    // Parameters that affect the physical characteristics.
    fixtureDef.density = highDensity ? 10 : 0.1;
    fixtureDef.friction = 0.3;
    fixtureDef.restitution = 0.5;

    // Attach the fixture to the body.
    body.createFixture(fixtureDef);
  }

  void applyForce(Vec2 force) {
    body.applyForce(force, body.getWorldCenter());
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

    fill(fillColor);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, boxWidth, boxHeight);

    // Restore the previous translation and rotation.
    popMatrix();
  }
}
// Box
