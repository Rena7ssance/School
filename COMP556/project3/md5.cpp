#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <fstream>

struct int128 {
  int a; //highest order bytes of the int128
  int b;
  int c;
  int d; //lowest order bytes
};

void InitializeK(int *k) {
  k[0] = 0xd76aa478;
  k[1] = 0xe8c7b756;
  k[2] = 0x242070db;
  k[3] = 0xc1bdceee;

  k[4] = 0xf57c0faf;
  k[5] = 0x4787c62a;
  k[6] = 0xa8304613;
  k[7] = 0xfd469501;

  k[8] = 0x698098d8;
  k[9] = 0x8b44f7af;
  k[10] = 0xffff5bb1;
  k[11] = 0x895cd7be;

  k[12] = 0x6b901122;
  k[13] = 0xfd987193;
  k[14] = 0xa679438e;
  k[15] = 0x49b40821;

  k[16] = 0xf61e2562;
  k[17] = 0xc040b340;
  k[18] = 0x265e5a51;
  k[19] = 0xe9b6c7aa;

  k[20] = 0xd62f105d;
  k[21] = 0x02441453;
  k[22] = 0xd8a1e681;
  k[23] = 0xe7d3fbc8;

  k[24] = 0x21e1cde6;
  k[25] = 0xc33707d6;
  k[26] = 0xf4d50d87;
  k[27] = 0x455a14ed;

  k[28] = 0xa9e3e905;
  k[29] = 0xfcefa3f8;
  k[30] = 0x676f02d9;
  k[31] = 0x8d2a4c8a;

  k[32] = 0xfffa3942;
  k[33] = 0x8771f681;
  k[34] = 0x6d9d6122;
  k[35] = 0xfde5380c;

  k[36] = 0xa4beea44;
  k[37] = 0x4bdecfa9;
  k[38] = 0xf6bb4b60;
  k[39] = 0xbebfbc70;

  k[40] = 0x289b7ec6;
  k[41] = 0xeaa127fa;
  k[42] = 0xd4ef3085;
  k[43] = 0x04881d05;

  k[44] = 0xd9d4d039;
  k[45] = 0xe6db99e5;
  k[46] = 0x1fa27cf8;
  k[47] = 0xc4ac5665;

  k[48] = 0xf4292244;
  k[49] = 0x432aff97;
  k[50] = 0xab9423a7;
  k[51] = 0xfc93a039;

  k[52] = 0x655b59c3;
  k[53] = 0x8f0ccc92;
  k[54] = 0xffeff47d;
  k[55] = 0x85845dd1;

  k[56] = 0x6fa87e4f;
  k[57] = 0xfe2ce6e0;
  k[58] = 0xa3014314;
  k[59] = 0x4e0811a1;

  k[60] = 0xf7537e82;
  k[61] = 0xbd3af235;
  k[62] = 0x2ad7d2bb;
  k[63] = 0xeb86d391;

}

void InitializeS(int *s) {
  int mod = 0;
  for(int i = 0; i < 64; i++) {
    if(i < 16) {
      if(mod == 0) {
        s[i] = 7;
      }
      if(mod == 1) {
        s[i] = 12;
      }
      if(mod == 2) {
        s[i] = 17;
      }
      if(mod == 3) {
        s[i] = 22;
      }
    }
    if(i < 32 && i > 15) {
      if(mod == 0) {
        s[i] = 5;
      }
      if(mod == 1) {
        s[i] = 9;
      }
      if(mod == 2) {
        s[i] = 14;
      }
      if(mod == 3) {
        s[i] = 20;
      }
    }
    if(i < 48 && i > 31) {
      if(mod == 0) {
        s[i] = 4;
      }
      if(mod == 1) {
        s[i] = 11;
      }
      if(mod == 2) {
        s[i] = 16;
      }
      if(mod == 3) {
        s[i] = 23;
      }
    }
    if(i > 47) {
      if(mod == 0) {
        s[i] = 6;
      }
      if(mod == 1) {
        s[i] = 10;
      }
      if(mod == 2) {
        s[i] = 15;
      }
      if(mod == 3) {
        s[i] = 21;
      }
    }
    mod++;
    if(mod > 3) {
      mod = 0;
    }
  }
}

int leftRotate(int x, int c) {
  return (x << c) | (x >> (32 - c));
}

int128 checksum(std::string message) {
  /*
    Checksum takes a string message, and returns int128 struct
  */

  int size_bits = 8 * message.length();
  int index = message.length();

  //Determine size of final padded message
  int chunk_size = 512;
  while(chunk_size < size_bits) {
    chunk_size += 512;
  }

  //Establish padded message for hash algo
  char* p_m = (char*)malloc(chunk_size/8);

  if((size_bits % 512) != 0) {
    //pad message until number of bits is divisible by 512
    int pad_to = ((chunk_size - 64) - size_bits)/8;

    //in case the values are too close
    while(pad_to < 0){
      chunk_size += 512;
      pad_to = ((chunk_size - 64) - size_bits)/8;
    }

    //copy original message
    for(int y = 0; y < index; y++) {
      p_m[y] = message[y];
    }

    //pad with a single 1 bit, followed by zeroes
    p_m[index++] = 0x80;
    while(index < (chunk_size/8)) {
      p_m[index++] = 0;
    }

    //append length of message mod 2^64
    long long power = (long long)pow(2,64);
    int length = message.length();
    double remain = (double)(length % power);
    char arr[sizeof(remain)];
    memcpy(&arr, &remain, sizeof(remain));
    index = (chunk_size/8) - 8;
    for(int r = 0; r < sizeof(remain);r++) {
      p_m[index++] = arr[r];
    }

  }

  //Starting values
  int a0 = 0x67452301;
  int b0 = 0xefcdab89;
  int c0 = 0x98badcfe;
  int d0 = 0x10325476;

  int s[64];
  int k[64];

  //Initialize S
  InitializeS(s);

  //Initialize K
  InitializeK(k);

  int M[16];
  for(int i = 0; i < (chunk_size/512); i++) {
    //for each 512 bit chunk
    M[0] = (p_m[0+(64*i)] << 24) | (p_m[1+(64*i)] << 16) | (p_m[2+(64*i)] << 8) | p_m[3+(64*i)];
    M[1] = (p_m[4+(64*i)] << 24) | (p_m[5+(64*i)] << 16) | (p_m[6+(64*i)] << 8) | p_m[7+(64*i)];
    M[2] = (p_m[8+(64*i)] << 24) | (p_m[9+(64*i)] << 16) | (p_m[10+(64*i)] << 8) | p_m[11+(64*i)];
    M[3] = (p_m[12+(64*i)] << 24) | (p_m[13+(64*i)] << 16) | (p_m[14+(64*i)] << 8) | p_m[15+(64*i)];
    M[4] = (p_m[16+(64*i)] << 24) | (p_m[17+(64*i)] << 16) | (p_m[18+(64*i)] << 8) | p_m[19+(64*i)];
    M[5] = (p_m[20+(64*i)] << 24) | (p_m[21+(64*i)] << 16) | (p_m[22+(64*i)] << 8) | p_m[23+(64*i)];
    M[6] = (p_m[24+(64*i)] << 24) | (p_m[25+(64*i)] << 16) | (p_m[26+(64*i)] << 8) | p_m[27+(64*i)];
    M[7] = (p_m[28+(64*i)] << 24) | (p_m[29+(64*i)] << 16) | (p_m[30+(64*i)] << 8) | p_m[31+(64*i)];
    M[8] = (p_m[32+(64*i)] << 24) | (p_m[33+(64*i)] << 16) | (p_m[34+(64*i)] << 8) | p_m[35+(64*i)];
    M[9] = (p_m[36+(64*i)] << 24) | (p_m[37+(64*i)] << 16) | (p_m[38+(64*i)] << 8) | p_m[39+(64*i)];
    M[10] = (p_m[40+(64*i)] << 24) | (p_m[41+(64*i)] << 16) | (p_m[42+(64*i)] << 8) | p_m[43+(64*i)];
    M[11] = (p_m[44+(64*i)] << 24) | (p_m[45+(64*i)] << 16) | (p_m[46+(64*i)] << 8) | p_m[47+(64*i)];
    M[12] = (p_m[48+(64*i)] << 24) | (p_m[49+(64*i)] << 16) | (p_m[50+(64*i)] << 8) | p_m[51+(64*i)];
    M[13] = (p_m[52+(64*i)] << 24) | (p_m[53+(64*i)] << 16) | (p_m[54+(64*i)] << 8) | p_m[55+(64*i)];
    M[14] = (p_m[56+(64*i)] << 24) | (p_m[57+(64*i)] << 16) | (p_m[58+(64*i)] << 8) | p_m[59+(64*i)];
    M[15] = (p_m[60+(64*i)] << 24) | (p_m[61+(64*i)] << 16) | (p_m[62+(64*i)] << 8) | p_m[63+(64*i)];

    int A = a0;
    int B = b0;
    int C = c0;
    int D = d0;

    for(int j = 0; j < 64; j++) {
      int F, g, dTemp;
      if(j <= 15) {
        F = (B & C) | ((!B) & D);
        g = j;
      }
      else if(j >= 16 && j <= 31) {
        F = (D & B) | ((!D) & C);
        g = (5*j + 1) % 16;
      }
      else if(j >= 32 && j <= 47) {
        F = B ^ C ^ D;
        g = (3*j + 5) % 16;
      }
      else if(j >= 48 && j <= 63) {
        F = C ^ (B | (!D));
        g = (7*j) % 16;
      }
      dTemp = D;
      D = C;
      C = B;
      B = B + leftRotate((A + F + k[j] + M[g]), s[j]);
      A = dTemp;
    }

    a0 = A + a0;
    b0 = B + b0;
    c0 = C + c0;
    d0 = D + d0;

  }

  int128 result;
  result.a = a0;
  result.b = b0;
  result.c = c0;
  result.d = d0;
  return result;
}

//main used for testing.
//tested multiple native strings, and processed entire file
/*int main() {
  int128 r = checksum("hello");
  int128 m = checksum("The quick brown fox jumps over the lazy dog");
  int128 d = checksum("The quick brown fox jumps over the lazy dog");
  int128 t = checksum("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
  int128 v = checksum("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwvwwwwwwwwwwwwwwwwwwwwwwwwwwww");
  printf("%x %x %x %x\n",r.a,r.b,r.c,r.d);
  printf("%x %x %x %x\n",m.a,m.b,m.c,m.d);
  printf("%x %x %x %x\n",d.a,d.b,d.c,d.d);
  printf("%x %x %x %x\n",t.a,t.b,t.c,t.d);
  printf("%x %x %x %x\n",v.a,v.b,v.c,v.d);
  printf("%x %x %x %x\n",file.a,file.b,file.c,file.d);
}*/
