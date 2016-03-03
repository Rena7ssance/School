int s;
int data[1000] = { 1 ,2, 3, 4, 5 };

int main() {
    int* p = (int*) 0x90000000;
    *p = 100;
    s += *p;

    p = (int*) 0xa0000000;
    *p = 200;
    s += *p;

    for (int i=0; i<1000; i++) {
        s += data[i];      
    }
 

    return s;
}
