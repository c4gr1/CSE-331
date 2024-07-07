#include <stdio.h>

// Function to print the grid
void print(int row, int column, char arr[row][column]) {
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < column; j++) {
            printf("%c", arr[i][j]);
        }
        printf("\n");
    }
}

// Function to fill the grid with '0's
void fill_zeros(int row, int column, char arr[row][column]) {
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < column; j++) {
            arr[i][j] = '0';
        }
    }
}

// Function to detonate neighborhood bombs according to the Bomberman game
void detonate(int row, int column, char arr[row][column], int k, int seconds) {
    char temp[row][column];
    fill_zeros(row, column, temp);

    for (int i = 0; i < row; i++) {
        for (int j = 0; j < column; j++) {
            if (arr[i][j] == '0') {
                temp[i][j] = '.';
                if (i - 1 >= 0) {
                    temp[i - 1][j] = '.';
                }
                if (i + 1 < row) {
                    temp[i + 1][j] = '.';
                }
                if (j - 1 >= 0) {
                    temp[i][j - 1] = '.';
                }
                if (j + 1 < column) {
                    temp[i][j + 1] = '.';
                }
            }
        }
    }

    // Additional logic for handling the detonation after a specified number of seconds

    // Copy the detonated grid back to the original grid
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < column; j++) {
            arr[i][j] = temp[i][j];
        }
    }
}

int main() {
    int seconds;
    int row, column;

    printf("Enter how many seconds: \n");
    scanf("%d", &seconds);

    printf("Enter grid x and y: \n");
    scanf("%d %d", &row, &column);

    char grid[row][column];

    printf("Please fill the grid row*column times \n");

    for (int i = 0; i < row; i++) {
        scanf("%s", grid[i]);
    }

    printf("\n\nAfter 1 second\n");
    print(row, column, grid);

    // Detonate bombs after a specified number of seconds
    detonate(row, column, grid, i, seconds);

    return 0;
}


