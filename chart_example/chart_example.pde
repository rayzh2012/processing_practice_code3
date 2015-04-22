import org.gicentre.utils.stat.*;    // For chart classes.
 
// Sketch to to draw a very simple bar chart.
// Version 1.1, 3rd November, 2013.
// Author Jo Wood.
 
BarChart barChart;
 
// Initialises the sketch and loads data into the chart.
void setup()
{
  size(300,200);
  
  barChart = new BarChart(this);
  barChart.setData(new float[] {0.76, 0.24, 0.39, 0.18, 0.20});
}
 
// Draws the chart in the sketch
void draw()
{
  background(255);
  barChart.draw(15,15,width-30,height-30); 
}
