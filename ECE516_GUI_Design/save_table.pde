Table table;
float[] num = new float[10];
float[] num2 = new float[10];
TableRow newRow ;
int number = 100;
void save_table() {

  table = new Table();
  
  table.addColumn("Attention Levels");
  table.addColumn("2014");
  
  
    for (int i=0;i<5;i++)
  {
    num[i] = random(number);
  table.addColumn(str(num[i]));
  }
  
  //**********************************************************
  for (int i =1;i<10;i++)
  {
 
  newRow = table.addRow();
 // newRow.setInt("Attention Levels", table.getRowCount() - 1);
  newRow.setString("2014", str(2014-i));
 // newRow.setString("name", "Lion");
 
   for (int j=0;j<5;j++)
  {
   // num = random(10000);
   newRow.setString(str(num[j]+num2[j]), str((num[j]+num2[j])));
  }
  
  }
  
  
  //**********************************************
 newRow = table.addRow();
  newRow.setString("Attention Levels", "Living Donor Transplant");
  repeat();
  
   newRow = table.addRow();
  newRow.setString("Attention Levels", "Transplanted in another country");
   repeat();
  
   newRow = table.addRow();
   newRow.setString("Attention Levels", "Patient Died During Tx Proc");
   repeat();
   
   
   newRow = table.addRow();
   newRow.setString("Attention Levels", "Too sick to transplant");
   repeat();
   
    newRow = table.addRow();
   newRow.setString("Attention Levels", "Died");
   repeat();
   
    newRow = table.addRow();
   newRow.setString("Attention Levels", "Conditon Improved");
   repeat();
   
   newRow = table.addRow();
   newRow.setString("Attention Levels", "Unable to contact patient");
   repeat();
   
  
   newRow = table.addRow();
   newRow.setString("Attention Levels", "Patient Refused Transplant");
   repeat();
   
    
   newRow = table.addRow();
   newRow.setString("Attention Levels", "Other");
   repeat();

   
   
  
  //**************save the table
  saveTable(table, "data/new.csv");
}


void repeat()
{
   
  newRow.setString("2014","2014");
   for (int j=0;j<5;j++)
  {
   // num = random(10000);
   newRow.setString(str(num[j]+num2[j]), str(num[j]));
  }
  
   for (int i =1;i<10;i++)
  {
 
   newRow = table.addRow();
 // newRow.setInt("Attention Levels", table.getRowCount() - 1);
  newRow.setString("2014", str(2014-i));
 // newRow.setString("name", "Lion");
 
   for (int j=0;j<5;j++)
  {
   // num = random(10000);
   newRow.setString(str(num[j]), str(num[j]));
  }
  
  
  // newRow = table.addRow();
  }
  


}


