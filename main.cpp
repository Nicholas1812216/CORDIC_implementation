/******************************************************************************

                              Online C++ Compiler.
               Code, Compile, Run and Debug C++ program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <iostream>
#include <math.h>
#include <fstream>
using namespace std;
void fixed_conversion(char char_array[][16], int iteration_count, float float_arr[],string filename);
int main()
{
    char fixed_vectors[11][16];
    float end = M_PI/2.0;
    float inc = end/10.0;

    float test_vectors[11];
    float sin_out[11],cos_out[11];
    sin_out[0] = 0.0;
    cos_out[0] = 1.0;
    test_vectors[0] = 0.0;

    for(int i = 0;i<10;i++)
    {
        test_vectors[i + 1] = inc * (i + 1);
        sin_out[i + 1] = sin(inc * (i + 1));
        cos_out[i + 1] = cos(inc * (i + 1));
    }
    
    fixed_conversion(fixed_vectors,11,test_vectors,"test_values.txt");
    fixed_conversion(fixed_vectors,11,sin_out,"sin_values.txt");
    fixed_conversion(fixed_vectors,11,cos_out,"cos_values.txt");
    
    
    // float Ki_values[20];
    // char Ki_fixed[20][17];
    // float temp;
    // float inf_approx = 1;
    
    // for(int i = 0;i < 20;i++)
    // {
    //     temp = 1.0 + pow(2.0,-2.0*i);
    //     temp = sqrt(temp);
    //     temp = 1.0/temp;
    //     if(i == 0)
    //     {
    //         Ki_values[0] = temp;
    //     }
    //     else
    //     {
    //       Ki_values[i] = Ki_values[i-1] * temp;
    //     }
    //     cout<<Ki_values[i]<<endl;
    // }
    
    // fixed_conversion(Ki_fixed,20,Ki_values,"K_values.txt");
    
    char PI_DIV_4[1][16];
    float  pi_over_4[1] = {M_PI/4.0};
    
    fixed_conversion(PI_DIV_4,1,pi_over_4,"angle_values.txt");
    
    char x_y_init[2][16];
    float s = sin(M_PI/4.0);
    cout << s<<endl;
    float sin_cos[2] = {s,s};
    fixed_conversion(x_y_init,2,sin_cos,"xy_init_values.txt");
    
    char angle_ref_fixed[16][16];
    float angles_ref[16] =  
    {
    0.78539816339745,   0.46364760900081,   0.24497866312686,   0.12435499454676, 
    0.06241880999596,   0.03123983343027,   0.01562372862048,   0.00781234106010, 
    0.00390623013197,   0.00195312251648,   0.00097656218956,   0.00048828121119, 
    0.00024414062015,   0.00012207031189,   0.00006103515617,   0.00003051757812
    };
    fixed_conversion(angle_ref_fixed,16,angles_ref,"angles_ref.txt");

    char k_val_fixed[16][16];
    float k_val[16] = 
    {
    0.70710678118655,   0.63245553203368,   0.61357199107790,   0.60883391251775,
    0.60764825625617,   0.60735177014130,   0.60727764409353,   0.60725911229889,
    0.60725447933256,   0.60725332108988,   0.60725303152913,   0.60725295913894,
    0.60725294104140,   0.60725293651701,   0.60725293538591,   0.60725293510314
    };

    fixed_conversion(k_val_fixed,16,k_val,"k_val.txt");


    return 0;
}


void fixed_conversion(char char_array[][16], int iteration_count, float float_arr[],string filename)
{
    int test = 0;
    float end = 0.0;
  for(int j = 0;j<iteration_count;j++)    
   {
       test = 0;
       end = float_arr[j];
    for(int i = 15;i>=0;i--)
    {
        // cout << end<<endl;
       if((end >= 1.0) && (test == 0))
        {
            char_array[j][15] = '1';
            end -=1.0;
            test = 1;
        }
        else if((end<1.0) && (test == 0))
        {
            char_array[j][15] = '0';
            test = 1;
        }        
        else if(end >= 1.0)
        {
            char_array[j][i] = '1';
            end -=1.0;
        }
        else 
        {
            char_array[j][i] = '0';
        }
        end *=2;
    }
    
    // for(int i = 15;i>=0;i--)
    // {
    //     cout<<fixed_vectors[j][i];
    // }   
    // cout<<endl;
    
   }
   
    ofstream myfile;
    myfile.open(filename);
    for(int j = 0;j<iteration_count;j++)
    {
        myfile<<'0';
        for(int i = 15;i>=0;i--)
        {
            myfile<<char_array[j][i];
        }
        myfile<<"\n";
    }
    myfile.close();
}
