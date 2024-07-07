#include "stdio.h"
#include "stdlib.h"
#include "time.h"

const int size = 16;

void plant_bomb_randomly(char arr[size][size]){

    for(int i=0; i<size; i++){
        for(int j=0; j<size; j++)
        {
            int bomb = rand()%2;
            if(bomb == 1){
                arr[i][j]='0';
            }

            else{
                arr[i][j]='.';
            }

        }
    }
}

void fill(char arr[size][size]){

        for(int i=0; i<size; i++)
            for(int j=0; j<size; j++)
                arr[i][j]='0';

}

void detonate_bomb(char arr[size][size],char arr2[size][size]){

    for(int i=0; i<size; i++){
        for(int j=0; j<size; j++)
        {

            if(arr[i][j]=='0'){

                arr2[i][j]='.';
                if(i > 0) arr2[i-1][j]='.';
                if(i < size-1) arr2[i+1][j]='.';
                if(j > 0) arr2[i][j-1]='.';
                if(j < size-1) arr2[i][j+1]='.';
                
            }
        }
    }

}

int main(){

    srand(time(NULL));

    char arr[size][size];
    char arr2[size][size];

    plant_bomb_randomly(arr);
    fill(arr2);

    for(int i=0; i<size; i++){
        for(int j=0; j<size; j++){
            printf("%c",arr[i][j]);
        }
    printf("\n");   
    }

    printf("\n");  
    printf("AFTER 1 SECONDS");
    printf("\n");  
    printf("\n"); 

    for(int i=0; i<size; i++){
        for(int j=0; j<size; j++){
            printf("%c",arr2[i][j]);
        }
    printf("\n");   
    }

    printf("\n");  
    printf("AFTER 1 SECONDS");
    printf("\n");  
    printf("\n"); 

    detonate_bomb(arr,arr2);
    
    for(int i=0; i<size; i++){
        for(int j=0; j<size; j++){
            printf("%c",arr2[i][j]);
        }
    printf("\n");   
    }   

    return 0;

}