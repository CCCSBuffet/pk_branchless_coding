#include <string.h>
#include <iostream>

extern "C" void ToUpper3(char *, int);

int main() {
	char * s = (char *) "TesT";
	char d[128] = { 0 };
	strcpy(d, s);

	ToUpper3(d, 4);
	std::cout << d << std::endl;
	return 0;
}