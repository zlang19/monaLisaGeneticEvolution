public class Organism {
  private PImage image;
  private float fitness;
  
  public Organism(PImage image, float fitness) {
    this.image = image.copy();
    this.fitness = fitness;
  }
  
  public Organism(PImage image) {
    this.image = image.copy();
    calculateFitness();
  }
  
  public PImage getImage() {
    return image;
  }
  
  public float getFitness() {
    return fitness;
  }
  
  public void calculateFitness() {
    fitness = 0;
    for (int i = 0; i < image.pixels.length; i++) {
      fitness -= abs(red(image.pixels[i]) - red(monaLisa.pixels[i]));
      fitness -= abs(green(image.pixels[i]) - green(monaLisa.pixels[i]));
      fitness -= abs(blue(image.pixels[i]) - blue(monaLisa.pixels[i]));
    }
  }
  
  public Organism[] reproduce() {
    Organism[] population = new Organism[populationSize];
    for (int i = 0; i < populationSize; i++) {
      population[i] = getChild();
    }
    return population;
  }
  
  private Organism getChild() {
    PImage childImage = image.copy();
    float childFitness = fitness;
    float value;
    int location, rgb;
    color oldPixel;
    for (int i = 0; i < image.pixels.length * mutationRate; i++) {
      location = (int) random(image.pixels.length);
      rgb = (int) random(0, 3);
      value = random(0, 255);
      oldPixel = image.pixels[location];
      if (rgb == 0) {
        childFitness += abs(red(oldPixel) - red(monaLisa.pixels[location]));
        childFitness -= abs(value - red(monaLisa.pixels[location]));
        childImage.pixels[location] = color(value, green(oldPixel), blue(oldPixel));
      } else if (rgb == 1) {
        childFitness += abs(green(oldPixel) - green(monaLisa.pixels[location]));
        childFitness -= abs(value - green(monaLisa.pixels[location]));
        childImage.pixels[location] = color(red(oldPixel), value, blue(oldPixel));
      } else {
        childFitness += abs(blue(oldPixel) - blue(monaLisa.pixels[location]));
        childFitness -= abs(value - blue(monaLisa.pixels[location]));
        childImage.pixels[location] = color(red(oldPixel), green(oldPixel), value);
      }
    }
    return new Organism(childImage, childFitness);
  }
  
  public void evolve() {
    Organism child;
    for (int i = 0; i < populationSize; i++) {
      child = getChild();
      if (child.getFitness() > fitness) {
        image = child.getImage();
        fitness = child.getFitness();
      }
    }
  }
}
