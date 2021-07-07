#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define PI 3.141592654

#define FIX824(x) ((double)(x * (double)(1 << 24)))
#define UNFIX824(x) ((double)x / (double)(1 << 24))

static int atan_tab[32];

char *convert(int n){
    int c, d, count;
    char *pointer;
    count = 0;
    pointer = (char*)malloc(32+1);
    for ( c = 31 ; c >= 0 ; c-- ){
        d = n >> c;
        if ( d & 1 )
            *(pointer+count) = 1 + '0';
        else
            *(pointer+count) = 0 + '0';
        count++;
        }
    *(pointer+count) = '\0';
    return pointer;
}

void atan_table(int n){
    int i;
    double delta = 1;

    for(i = 1; i <= n; i++){
        atan_tab[i-1] = FIX824((atan(delta)*180)/PI);
        delta = delta / 2.0;
    }
}

void cordic_fix824(int phi){
    int i;
    int x, y, z, tmpx, tmpy;

    x = FIX824(1.0);
    y = FIX824(0.0);
    
    
    z = phi;
    i = 0;

    do{
	printf(" %d | x = %s, y = %s, z = %s\n", i, convert(x), convert(y), convert(z));
	//printf("x_shift: %s\n", convert(x >> i));
        tmpx = z < 0 ? x + (y >> i) : x - (y >> i);

	tmpy = z < 0 ? y - (x >> i) : y + (x >> i);
        z = z < 0 ? z + atan_tab[i] : z - atan_tab[i];
        x = tmpx; y = tmpy; i++;
    } while(i < 24);
    printf("x = %f, y = %f\n", UNFIX824(x), UNFIX824(y));

}

int main(void){
    atan_table(24);
    cordic_fix824(FIX824(90));
    return 1;
}
