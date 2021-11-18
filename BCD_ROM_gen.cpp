/******************************************************************************

                              Online C++ Compiler.
               Code, Compile, Run and Debug C++ program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <iostream>
#include <math.h>
#include <fstream>

using namespace std;
void seg_con(int int_array[64], char seg_val[64][2]);

int main()
{
    float neg_6 = pow(2,-6);
    float vals;
    int tenths[64], hundredths[64], thousandths[64], ten_thousandths[64], hundred_thousandths[64], millionths[64];
    char seg_char[64][2];
    float thousandths_float;
    for(int i = 0; i < 64; i++)
    {
        vals = i * neg_6;
        cout<<vals<<"  ";
        tenths[i] = int(10 * vals);
        vals = vals * 10;
        while(vals >= 1)
        {
            vals -=1;
        }
        cout<<tenths[i]<<"  ";
        hundredths[i] = int(10 * vals);
        vals = vals * 10;
        while(vals >= 1)
        {
            vals -=1;
        }
        cout<<hundredths[i]<<"  ";

        thousandths[i] = int(10 * vals);
        vals = vals * 10;
        while(vals >= 1)
        {
            vals -=1;
        }
        cout<<thousandths[i]<<"  ";

        ten_thousandths[i] = int(10 * vals);
        vals = vals * 10;
        while(vals >= 1)
        {
            vals -=1;
        }
        cout<<ten_thousandths[i]<<"  ";

        hundred_thousandths[i] = int(10 * vals);
        vals = vals * 10;
        while(vals >= 1)
        {
            vals -=1;
        }
        cout<<hundred_thousandths[i]<<"  ";

        millionths[i] = int(10 * vals);
        vals = vals * 10;
        while(vals >= 1)
        {
            vals -=1;
        }
        cout<<millionths[i]<<endl;

              
        
        
        
    }
    
    seg_con(tenths,seg_char);
    ofstream myfile;
    myfile.open("tenths.txt");

    for(int j = 0;j<64;j++)
    {
        for(int i = 1;i>=0;i--)
        {
            myfile<<seg_char[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();

    seg_con(hundredths,seg_char);
    myfile.open("hundredths.txt");

    for(int j = 0;j<64;j++)
    {
        for(int i = 1;i>=0;i--)
        {
            myfile<<seg_char[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();
    
    seg_con(thousandths,seg_char);
    myfile.open("thousandths.txt");

    for(int j = 0;j<64;j++)
    {
        for(int i = 1;i>=0;i--)
        {
            myfile<<seg_char[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();    


    seg_con(ten_thousandths,seg_char);
    myfile.open("ten_thousandths.txt");

    for(int j = 0;j<64;j++)
    {
        for(int i = 1;i>=0;i--)
        {
            myfile<<seg_char[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();

    seg_con(hundred_thousandths,seg_char);
    myfile.open("hundred_thousandths.txt");

    for(int j = 0;j<64;j++)
    {
        for(int i = 1;i>=0;i--)
        {
            myfile<<seg_char[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();
    

    seg_con(millionths,seg_char);
    myfile.open("millionths.txt");

    for(int j = 0;j<64;j++)
    {
        for(int i = 1;i>=0;i--)
        {
            myfile<<seg_char[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();    


    return 0;
}

void seg_con(int int_array[64], char seg_val[64][2])
{
   for(int i = 0;i<64;i++)
   {
       switch(int_array[i]){
           
           case 0:
              seg_val[i][1] = 'c';
              seg_val[i][0] = '0';
            break;
           case 1:
              seg_val[i][1] = 'f';
              seg_val[i][0] = '9';
            break;     
           case 2:
              seg_val[i][1] = 'a';
              seg_val[i][0] = '4';
            break;
           case 3:
              seg_val[i][1] = 'b';
              seg_val[i][0] = '0';
            break;            
           case 4:
              seg_val[i][1] = '9';
              seg_val[i][0] = '9';
            break;            
           case 5:
              seg_val[i][1] = '9';
              seg_val[i][0] = '2';
            break;            
           case 6:
              seg_val[i][1] = '8';
              seg_val[i][0] = '2';
            break;            
           case 7:
              seg_val[i][1] = 'f';
              seg_val[i][0] = '8';
            break;            
           case 8:
              seg_val[i][1] = '8';
              seg_val[i][0] = '0';
            break;            
           case 9:
              seg_val[i][1] = '9';
              seg_val[i][0] = '0';
            break;    
           default:
              seg_val[i][1] = 'f';
              seg_val[i][0] = '0';
            break;            
       }
       
   }
}

