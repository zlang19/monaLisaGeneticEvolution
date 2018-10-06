static final int width = 500;
static final int height = 745;

static int generation = 0;
static final int populationSize = 100;
static final float mutationRate = 1.0 / 100000;

//generation: 6876 fitness: -6.7292408E7

PImage monaLisa;

Organism organism;
Organism[] population;

void setup() {
  frameRate(100);
  size(500, 745);
  
  monaLisa = loadImage("monaLisa.jpg");
  monaLisa.resize(width, height);
  monaLisa.loadPixels();
  
  PImage organismImage = createImage(width, height, RGB);
  organismImage.loadPixels();
  for (int i = 0; i < organismImage.pixels.length; i++) {
    organismImage.pixels[i] = getRandomColor();
  }
  organism = new Organism(organismImage);
  //organism = new Organism(monaLisa);
}

void draw() {  
  organism.getImage().updatePixels();
  image(organism.getImage(), 0, 0);
  println("generation: " + generation++ + " fitness: " + organism.getFitness());
  
  //population = organism.reproduce();
  //organism = naturalSelection(population);
  organism.evolve();
}

Organism naturalSelection(Organism[] population) {
  Organism fittest = population[0];
  for (int i = 1; i < populationSize; i++) {
    if (population[i].getFitness() > fittest.getFitness()) {
      fittest = population[i];
    }
  }
  return fittest;
}

Organism randomSelection(Organism[] population) {
  return population[(int) random(0, populationSize)];
}

color getRandomColor() {
  return color(random(0, 255), random(0, 255), random(0, 255));
}
